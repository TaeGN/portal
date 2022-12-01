package com.portal.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminMapper;

@Component("adminSecurity")
public class AdminSecurity {
	
	public boolean checkAdminAuthority(Authentication authentication) {
		return authentication.getAuthorities().size() != 0;
	}
	
}
