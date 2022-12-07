package com.portal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	@RequestMapping("")
	public String home() {
		
		return "redirect:/sugang/login";
	}
	
	// 권한 없음 페이지로 이동
	@RequestMapping("access-denied")
	public void access_denied() {
		
	}
}
