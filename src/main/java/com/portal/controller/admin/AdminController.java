package com.portal.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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
	private AdminService adminService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	// 기본화면 대시보드
	@GetMapping("")
	@PreAuthorize("isAuthenticated()")
	public String admin() {
		
		return "redirect:/admin/board";
	}
	
	@GetMapping("login")
	public void login() {
		
	}
	
	
	// 대시보드
	@GetMapping("board")
	@PreAuthorize("isAuthenticated()")
	public void board() {
		
	}
	
	
	// 관리자 등록
	@GetMapping("register")
	@PreAuthorize("@adminSecurity.checkAdminAuthority(authentication)")
	public void register() {
		
	}	
	@PostMapping("register")
	@PreAuthorize("@adminSecurity.checkAdminAuthority(authentication)")
	public String method(AdminMemberDto adminMember) {
		int id = adminMapper.selectLastAdminMemberId();
		adminMember.setId(id + 1);
		adminService.registerAdminMember(adminMember);
		
		
		return "redirect:/admin/list";
	}
	
	
	// 관리자 리스트
	@GetMapping("list")
	@PreAuthorize("@adminSecurity.checkAdminAuthority(authentication)")
	public void member(Model model) {
		List<AdminMemberDto> list = adminService.getAdminMemberList();
		System.out.println(list);
		model.addAttribute("adminMemberList", list);
	}
}
