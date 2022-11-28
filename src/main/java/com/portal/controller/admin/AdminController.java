package com.portal.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("login")
	public void login() {
		
	}
	
	@GetMapping("board")
	public void board() {
		
	}
}
