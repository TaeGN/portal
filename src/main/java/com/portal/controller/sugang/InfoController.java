package com.portal.controller.sugang;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.mapper.sugang.InfoMapper;

@Controller
@RequestMapping("sugang")
public class InfoController {
	
//	@Autowired
//	private SugangMapper sugangMapper;
	
	@GetMapping("info")
	public void info() {
		
	}
	
	
}
