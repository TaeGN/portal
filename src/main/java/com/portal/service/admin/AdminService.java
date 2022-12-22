package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.mapper.signUpNotice.SignUpNoticeMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Transactional
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private SignUpNoticeMapper signUpNoticeMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private S3Client s3Client;
	
	@Value("${aws.s3.bucket}")
	private String bucketName;

	public int registerAdminMember(AdminMemberDto adminMember, MultipartFile[] files) {
		List<String> authorityList = adminMember.getAuthorityList();
		// 비밀번호 암호화해서 저장
		String pw = adminMember.getPassword();
		adminMember.setPassword(passwordEncoder.encode(pw));
		
		// adminMember에 추가
		int cnt1 = adminMapper.insertAdminMember(adminMember);
		int cnt2 = 1;
		// authority 추가
		if(authorityList != null ) {
			for(String authority : authorityList) {
				cnt2 *= adminMapper.insertAdminAuthority(adminMember.getId(), authority);
			}
		}
		
		for (MultipartFile file : files) {
			if (file != null && file.getSize() > 0) {
				// db에 파일 정보 저장
				adminMapper.insertFile(adminMember.getId(), file.getOriginalFilename());
				
				uploadFile(adminMember.getId(), file);
			}
		}
		
		return cnt1 * cnt2;
	}
	
	private void uploadFile(int id, MultipartFile file) {
		try {
			// S3에 파일 저장
			// 키 생성
			String key = "school/member/" + id + "/" + file.getOriginalFilename();
			
			// putObjectRequest
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(key)
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			// requestBody
			RequestBody requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			
			// object(파일) 올리기
			s3Client.putObject(putObjectRequest, requestBody);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public List<AdminMemberDto> getAdminMemberList(int startNum, int count) {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMemberAll(startNum, count);
	}

	public AdminMemberDto getAdminMemberByUserName(String username) {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMemberByUserName(username);
	}

	public int modifyAdminMember(AdminMemberDto adminMember, MultipartFile[] addFiles, List<String> removeFiles) {
		String pw = adminMember.getPassword();
		adminMember.setPassword(passwordEncoder.encode(pw));
		int memberId = adminMember.getId();
		
		// removeFiles 에 있는 파일명으로 
		if(removeFiles != null) {
			for (String fileName : removeFiles) {
				// 1. File 테이블에서 record 지우기
				adminMapper.deleteFileByBoardIdAndFileName(memberId, fileName);
				
				// S3 저장소의 파일지우기
				deleteFile(memberId, fileName);			

			}
		}
			
		
		for (MultipartFile file : addFiles) {
			if (file != null && file.getSize() > 0) {
				String name = file.getOriginalFilename();
				// File table에 해당파일명 지우기
				adminMapper.deleteFileByBoardIdAndFileName(memberId, name);
				
				// File table에 파일명 추가
				adminMapper.insertFile(memberId, name);
				
				// S3 저장소에 실제 파일(object) 추가
				
				uploadFile(memberId, file);
				
			}
			
		}
		
		
		return adminMapper.updateAdminMember(adminMember);
	}

	public int removeAdminMemberById(int id, String username) {
		// 권한 테이블 삭제
		adminMapper.deleteAdminAuthorityByAdminId(id);
		
		// adminLog 삭제
		adminLogService.removeAdminLogByAdminId(id);
		
		// signUpNotice 삭제
		List<Integer> signUpNoticeIdList = signUpNoticeMapper.selectSignUpNoticeIdByWriterId(id);
		
		for(int signUpNoticeId : signUpNoticeIdList) {
			int cnt2 = signUpNoticeMapper.deleteSignUpNoticeById(signUpNoticeId);
			String messageLog = "";
			
			if(cnt2 == 1) {
				messageLog = "공지번호 : " + signUpNoticeId + " 공지사항 삭제 성공";
			}	else {
				messageLog = "공지번호 : " + signUpNoticeId + " 공지사항 삭제 실패";
			}
			String category = "remove";
			AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(username);
			int cnt3 = adminLogService.registerSignUpNoticeLogById(admin.getId(), messageLog, category);
		}
		
		
		// adminMember 삭제
		int cnt = adminMapper.deleteAdminMemberById(id);
		return cnt;
	}
	
	private void deleteFile(int id, String fileName) {
		// S3 저장소의 파일지우기
		String key = "school/member/" + id + "/" + fileName;
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3Client.deleteObject(deleteObjectRequest);
	}

	public AdminMemberDto getAdminMemberById(int id) {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMemberById(id);
	}

	public int modifyAdminMember(AdminMemberDto adminMember) {
		// 비밀번호 암호화 (변경될 비밀번호 없으면 기존 비밀번호 그대로)
		if(adminMember.getPassword() == null || adminMember.getPassword().equals("")) {
			String pw = adminMapper.selectAdminMemberById(adminMember.getId()).getPassword();
			adminMember.setPassword(pw);
		} else {
			adminMember.setPassword(passwordEncoder.encode(adminMember.getPassword()));
		}		
		
		int adminId = adminMember.getId();
		
		// authority 삭제
		int cnt = adminMapper.deleteAdminAuthorityByAdminId(adminId);
		
		int cnt2 = 0;
		// authority 등록
		for(String authority : adminMember.getAuthorityList()) {
			cnt2 += adminMapper.insertAdminAuthority(adminId, authority);
		}
		
		// update member
		return adminMapper.updateAdminMember(adminMember);
	}

	public int registerAdminMember(AdminMemberDto adminMember) {
		List<String> authorityList = adminMember.getAuthorityList();
		// 비밀번호 암호화해서 저장
		String pw = adminMember.getPassword();
		adminMember.setPassword(passwordEncoder.encode(pw));
		
		// adminMember에 추가
		int cnt1 = adminMapper.insertAdminMember(adminMember);
		int cnt2 = 1;
		// authority 추가
		if(authorityList != null ) {
			for(String authority : authorityList) {
				cnt2 *= adminMapper.insertAdminAuthority(adminMember.getId(), authority);
			}
		}		
		
		return cnt1 * cnt2;
	}

	public int getCountAdminMemberAll() {
		// TODO Auto-generated method stub
		return adminMapper.selectCountAdminMemberAll();
	}



}
