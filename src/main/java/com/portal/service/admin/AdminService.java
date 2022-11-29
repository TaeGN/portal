package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.admin.AdminLogDto;
import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminMapper;

@Service
@Transactional
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

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

	public List<AdminMemberDto> getAdminMemberList() {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMemberAll();
	}

	public AdminMemberDto getAdminMemberByUserName(String username) {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMemberByUserName(username);
	}

	public int modifyAdminMember(AdminMemberDto adminMember) {
		String pw = adminMember.getPassword();
		adminMember.setPassword(passwordEncoder.encode(pw));
		return adminMapper.updateAdminMember(adminMember);
	}

	public int removeAdminMemberById(int id) {
		// 권한 테이블 삭제
		int cnt1 = adminMapper.deleteAdminAuthorityByAdminId(id);
		//
		int cnt2 = adminMapper.deleteAdminMemberById(id);
		return cnt1 * cnt2;
	}



}
