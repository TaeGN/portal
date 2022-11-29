package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminMapper;

@Service
@Transactional
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	public void registerAdminMember(AdminMemberDto adminMember) {
		List<String> authorityList = adminMember.getAuthorityList();
		// 비밀번호 암호화해서 저장
		String pw = adminMember.getPassword();
		adminMember.setPassword(passwordEncoder.encode(pw));
//		
		// adminMember에 추가
		adminMapper.insertAdminMember(adminMember);
		
		// authority 추가
		if(authorityList != null ) {
			for(String authority : authorityList) {
				adminMapper.insertAdminAuthority(adminMember.getId(), authority);
			}
		}
	}

	public List<AdminMemberDto> getAdminMemberList() {
		// TODO Auto-generated method stub
		return adminMapper.selectAdminMemberAll();
	}



}
