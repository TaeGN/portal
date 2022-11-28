package com.portal.service.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.portal.mapper.admin.AdminMemberMapper;

@Service
public class AdminMemberService {

	@Autowired
	private AdminMemberMapper adminMemberMapper;
}
