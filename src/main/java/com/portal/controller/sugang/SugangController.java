package com.portal.controller.sugang;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.domain.sugang.CourseDto;
import com.portal.domain.sugang.InfoDto;
import com.portal.service.sugang.SugangService;


@Controller
@RequestMapping("sugang")
public class SugangController {
	
	@Autowired
	private SugangService sugangService;
	
	@GetMapping("info")
	public void info(Model model) {
		List<InfoDto> list = sugangService.getInfoList();
		
		model.addAttribute("infoList", list);
	}
	
	@GetMapping("list")
	public void list(Model model) {
		List<CourseDto> list = sugangService.getCourseList(); 

		model.addAttribute("courseList", list);
	}
	
	@GetMapping("infoText")
	public void infoText(int id, Model model) {
		String infoText = sugangService.getInfoText(id);
		
		model.addAttribute("infoText", infoText);
	}
}
