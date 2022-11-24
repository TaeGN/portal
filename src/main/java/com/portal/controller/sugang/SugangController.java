package com.portal.controller.sugang;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("sugang")
public class SugangController {
	
//	@Autowired
//	private SugangMapper sugangMapper;
	
	@GetMapping("info")
	public void info() {
		// 
	}
	
	
}
