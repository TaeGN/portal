package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminMapper;

@Service
@Transactional
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;

	public void registerAdminMember(AdminMemberDto adminMember) {
		// TODO Auto-generated method stub
		List<String> authorities = adminMember.getAuthority();
		adminMapper.insertAdminMember(adminMember);
		
		for(String authority : authorities) {
			adminMapper.insertAdminAuthority(adminMember.getId(), authority);
		}
	}



}
