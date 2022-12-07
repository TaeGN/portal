package com.portal.controller.sugang;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.domain.course.CourseDto;
import com.portal.domain.sugang.InfoDto;
import com.portal.domain.sugang.SearchDto;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.sugang.SugangService;


@Controller
@RequestMapping("sugang")
public class SugangController {
	
	@Autowired
	private SugangService sugangService;
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@GetMapping("login")
	public void login() {
		
	}
	
	@GetMapping("info")
	public void info(Model model) {
		List<InfoDto> list = sugangService.getInfoList();
		
		model.addAttribute("infoList", list);
	}
	
	@GetMapping("list")
	public void list(SearchDto search, Model model, Authentication authentication) {
		List<CourseDto> list = new ArrayList<>();
		System.out.println(search);
		System.out.println(authentication.getName());
		if(authentication.getName() != null) {
			list = sugangService.getSearchCourseListByUserId(search, authentication.getName()); 
		} else {
			list = sugangService.getSearchCourseList(search); 
		}
		System.out.println(list.get(0));
		System.out.println(list.get(1));
		model.addAttribute("courseList", list);
	}
	
//	@PostMapping("list")
//	public String list(SearchDto search, RedirectAttributes rttr, Authentication authentication) {
//		List<CourseDto> list = new ArrayList<>();
//		System.out.println(search);
//		System.out.println(authentication.getName());
//		if(authentication.getName() != null) {
//			list = sugangService.getSearchCourseListByUserId(search, authentication.getName()); 
//		} else {
//			list = sugangService.getSearchCourseList(search); 
//		}
//		System.out.println(list.get(0));
//		System.out.println(list.get(1));
//		rttr.addFlashAttribute("courseList", list);
//		return "redirect:/sugang/list";
//	}
	
	
	@GetMapping("infoText")
	public void infoText(int id, Model model) {
		String infoText = sugangService.getInfoText(id);
		
		model.addAttribute("infoText", infoText);
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
	
}
