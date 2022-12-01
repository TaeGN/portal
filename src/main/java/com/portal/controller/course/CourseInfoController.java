package com.portal.controller.course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.domain.course.CourseInfoDto;
import com.portal.service.course.CourseInfoService;

@Controller
@RequestMapping("courseInfo")
public class CourseInfoController {
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	@GetMapping("get")
	@PreAuthorize("hasAnyAuthority('admin','courseInfo')")
	public void get() {
		
	}
	
	@GetMapping("getInfo")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('admin','courseInfo')")
	public Map<String, Object> getInfo(@RequestBody Map<String, String> req) {
		Map<String, Object> data = new HashMap<>();
		CourseInfoDto courseInfo = courseInfoService.getCourseInfoByClassNumber(req.get("classNumber"));
		data.put("courseInfo", courseInfo);
		return data;
	}
	
	@GetMapping("list")
	@PreAuthorize("hasAnyAuthority('admin','course','member')")
	public void list(Model model) {
		List<CourseInfoDto> courseInfoList = courseInfoService.getCourseInfoAll();
		
		model.addAttribute("courseInfoList", courseInfoList);
	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','courseInfo')")
	public void register() {
		
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','courseInfo')")
	public String register(CourseInfoDto courseInfo) {
		int cnt = courseInfoService.registerCourseInfo(courseInfo);
		
		return "redirect:/courseInfo/list";
	}
}
