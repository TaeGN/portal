package com.portal.controller.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.domain.course.CourseDto;
import com.portal.service.course.CourseService;

@Controller
@RequestMapping("course")
public class CourseController {
	
	
	@Autowired
	private CourseService courseService;
	
	@GetMapping("list")
	public void list(Model model) {
		List<CourseDto> courseList = courseService.getCourseAll();
		
		model.addAttribute("courseList", courseList);
	}
	
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(CourseDto course, String departmentName) {
		
		int cnt = courseService.registerCourse(course, departmentName);
		
		return "redirect:/course/list";
	}
	
	@GetMapping("modify")
	public void modify() {
		
	}
}
