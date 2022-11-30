package com.portal.controller.course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.domain.course.CourseInfoDto;
import com.portal.service.course.CourseInfoService;

@Controller
@RequestMapping("courseInfo")
public class CourseInfoController {
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(CourseInfoDto courseInfo) {
		int cnt = courseInfoService.registerCourseInfo(courseInfo);
		
		return "redirect:/courseInfo/list";
	}
}
