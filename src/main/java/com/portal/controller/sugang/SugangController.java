package com.portal.controller.sugang;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.domain.course.CollegeDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;
import com.portal.domain.member.StudentDto;
import com.portal.domain.sugang.SignUpNoticeDto;
import com.portal.domain.sugang.SearchDto;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.course.DepartmentService;
import com.portal.service.member.StudentService;
import com.portal.service.sugang.SugangService;


@Controller
@RequestMapping("sugang")
public class SugangController {
	
	@Autowired
	private SugangService sugangService;
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private StudentService studentService;
	
	@GetMapping("login")
	public void login() {
		
	}
	
	// 로그인 후 권한에 따른 페이지 이동
	@GetMapping("success")
	@PreAuthorize("isAuthenticated()")
	public String success(Authentication authentication) {
		String url = "";
		if(authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("student"))) {
			url = "/sugang/list";
		} else if(authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("professor"))) {
			url = "/sugang/list";
		} else {
			url = "/admin/board";
		}
		
		return "redirect:" + url;
	}
	
	@GetMapping("signUpNotice")
	public void info(Model model) {
		List<SignUpNoticeDto> signUpNoticeList = sugangService.getSignUpNoticeList();
		
		model.addAttribute("signUpNoticeList", signUpNoticeList);
	}
	
	@GetMapping("signUpNoticeText")
	public void signUpNoticeText(int id, Model model) {
		String signUpNoticeText = sugangService.getSignUpNoticeText(id);
		
		model.addAttribute("signUpNoticeText", signUpNoticeText);
	}		

	// 수강편람
	@GetMapping("list")
	public void list(SearchDto search, Model model, Authentication authentication,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		
		int count = 10;
		int startNum = (page - 1) * count; 
		search.setStartNum(startNum);
		search.setCount(count);
		
		List<CourseDto> courseList = new ArrayList<>();
		
		if(authentication.getName() != null) {
			StudentDto student = studentService.getStudentByStudentId(authentication.getName());
			search.setStudentNumber(student.getStudentNumber());
			// 로그인 상태
			courseList = sugangService.getSearchCourseListByStudentNumber(search); 
		} else {
			// 비로그인 상태
			courseList = sugangService.getSearchCourseList(search); 
		}
		
		
		int totalNum = sugangService.getTotalNumBySearchCourseList(search);
		int maxPage = (totalNum - 1) / count + 1;
		
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		
		model.addAttribute("courseList", courseList);
		model.addAttribute("organizationList", organizationList);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
	}
	
	
	
	// 희망수업 리스트
	@GetMapping("desireList")
	@PreAuthorize("hasAnyAuthority('student')")
	public void desireList(Model model, Authentication authentication) {
		String userId = authentication.getName();
		List<CourseDto> desireList = courseSignUpService.getCourseByUserId(userId);
		model.addAttribute("desireList", desireList);
	}
	
	@GetMapping("signUpList")
	@PreAuthorize("hasAnyAuthority('student')")
	public void signUpList(Model model, Authentication authentication) {
		String userId = authentication.getName();
		List<CourseDto> signUpList = courseSignUpService.getSignUpAllByUserId(userId);
		model.addAttribute("signUpList", signUpList);
	}
	
	
	@GetMapping("getCollege/{organizationId}")
	@PreAuthorize("hasAnyAuthority('student')")
	@ResponseBody
	public Map<String, Object> getCollege(@PathVariable int organizationId) {
		Map<String, Object> map = new HashMap<>();
		
		List<CollegeDto> collegeList = departmentService.getCollegeByOrganizationId(organizationId);
		
		map.put("collegeList", collegeList);
		return map;
	}
	
	@GetMapping("getDepartment/{collegeId}")
	@PreAuthorize("hasAnyAuthority('student')")
	@ResponseBody
	public Map<String, Object> getDepartment(@PathVariable int collegeId) {
		Map<String, Object> map = new HashMap<>();
		
		List<DepartmentDto> departmentList = departmentService.getDepartmentByCollegeId(collegeId);
		
		map.put("departmentList", departmentList);
		return map;
	}
	
}
