package com.portal.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.service.admin.AdminMemberService;

@Controller
@RequestMapping("admin/student")
public class MemberController {
	
	@Autowired
	private AdminMemberService adminMemberService;

	
	@GetMapping("register")
	public void register() {
		
	}
	
	
}
