package com.portal.controller.course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseInfoDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.course.CourseInfoService;

@Controller
@RequestMapping("courseInfo")
public class CourseInfoController {
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private AdminLogService adminLogService;
	

	@GetMapping("get")
	@PreAuthorize("hasAnyAuthority('admin','courseInfo')")
	public void get() {
		
	}
	
	@GetMapping("getCourseInfo/{classNumber}")
	public String getCourseInfo(@PathVariable String classNumber, RedirectAttributes rttr) {
		System.out.println("확인: "+ classNumber);
		CourseInfoDto courseInfo = courseInfoService.getCourseInfoByClassNumber(classNumber);
		System.out.println(courseInfo);
		rttr.addFlashAttribute("courseInfo", courseInfo);
		return "redirect:/courseInfo/description";
	}
	
	@GetMapping("description")
	public void description(HttpServletRequest req, Model model) {
		CourseInfoDto courseInfo = (CourseInfoDto)RequestContextUtils.getInputFlashMap(req).get("courseInfo");
		model.addAttribute("courseInfo", courseInfo);
	}
	
//	@PostMapping("getCourseInfo")
//	@ResponseBody
//	public Map<String, Object> getCourseInfo(@RequestBody Map<String, String> req) {
//		Map<String, Object> data = new HashMap<>();
//		CourseInfoDto courseInfo = courseInfoService.getCourseInfoByClassNumber(req.get("classNumber"));
//		data.put("courseInfo", courseInfo);
//		return data;
//	}
	
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
	public String register(CourseInfoDto courseInfo, Authentication authentication) {
		int cnt = courseInfoService.registerCourseInfo(courseInfo);
		
		String messageLog = "";
		String classNumber = courseInfo.getClassNumber();
		if(cnt == 1) {
			messageLog = "학수번호 " + classNumber + " 강의 정보 추가 성공";
		} else {
			messageLog = "학수번호 " + classNumber + " 강의 정보 추가 실패";
		}
		
		String category = "register";
		
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		adminLogService.registerCourseInfoLogById(admin.getId(), messageLog, category);
		
		return "redirect:/courseInfo/list";
	}
}
