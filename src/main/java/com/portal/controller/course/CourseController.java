package com.portal.controller.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseInfoDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.course.CourseInfoService;
import com.portal.service.course.CourseService;
import com.portal.service.course.DepartmentService;

@Controller
@RequestMapping("course")
public class CourseController {
	
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@GetMapping("list")
	@PreAuthorize("@adminSecurity.checkAdminAuthority(authentication)")
	public void list(Model model) {
		List<CourseDto> courseList = courseService.getCourseAll();
		
		model.addAttribute("courseList", courseList);
	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void register(Model model) {
		List<DepartmentDto> departmentList = departmentService.getDepartmentAll();
		List<CourseInfoDto> courseInfoList = courseInfoService.getCourseInfoAll(); 
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("courseInfoList", courseInfoList);
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public String register(CourseDto course, Authentication authentication) {
		int cnt = courseService.registerCourse(course);
		
		String messageLog = "";
		
		
		if(cnt == 1) {
			CourseDto newCourse = courseService.getLastCourse();
			int classCode = newCourse.getClassCode();
			messageLog = "수업번호 " + classCode + " 강의 추가 성공";
		}	else {
			messageLog = "강의 추가 실패";
		}
		
		String category = "register";
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		int cnt2 = adminLogService.registerCourseLogById(admin.getId(), messageLog, category);
		
		return "redirect:/course/list";
	}
	
	@GetMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void modify() {
		
	}
}
