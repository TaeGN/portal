package com.portal.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@GetMapping("")
	public String admin() {
		
		return "redirect:/admin/board";
	}
	
	@GetMapping("login")
	public void login() {
		
	}
	
	@GetMapping("board")
	public void board() {
		
	}
	
	@GetMapping("register")
	public void member() {
		
	}
	
	@PostMapping("register")
	public String method(AdminMemberDto adminMember) {
		int id = adminMapper.selectLastAdminMemberId();
		adminMember.setId(id + 1);
		adminService.registerAdminMember(adminMember);
		
		
		return "redirect:/admin/list";
	}
}
