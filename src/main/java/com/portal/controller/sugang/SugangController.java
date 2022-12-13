package com.portal.controller.sugang;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.domain.course.CourseDto;
import com.portal.domain.sugang.SignUpNoticeDto;
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
	
	// 로그인 후 권한에 따른 페이지 이동
	@GetMapping("success")
	@PreAuthorize("isAuthenticated()")
	public String success(Authentication authentication) {
//		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
//		Iterator<? extends GrantedAuthority> iter = authorities.iterator();
//		GrantedAuthority auth = iter.next();
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
	
	
//	@GetMapping("list")
//	public void list(SearchDto search, Model model, Authentication authentication,
//			@RequestParam(name = "page", defaultValue = "1") int page) {
//		List<CourseDto> list = new ArrayList<>();
//		
//		int count = 20;
//		int startNum = (page - 1) * count; 
//		search.setStartNum(startNum);
//		search.setCount(count);
//		if(authentication.getName() != null) {
//			list = sugangService.getSearchCourseListByUserId(search, authentication.getName()); 
//		} else {
//			list = sugangService.getSearchCourseList(search); 
//		}
//		
//		int maxPageNum = 
//		
//		model.addAttribute("courseList", list);
//		model.addAttribute("page", page);
//	}
	
	@GetMapping("list")
	public void list(SearchDto search, Model model, Authentication authentication,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		List<CourseDto> list = new ArrayList<>();
		if(authentication.getName() != null) {
			list = sugangService.getSearchCourseListByUserId(search, authentication.getName()); 
		} else {
			list = sugangService.getSearchCourseList(search); 
		}
		
		model.addAttribute("courseList", list);
		
		int maxPage = 0;
		if(list.size() != 0) {
			maxPage = (list.size() - 1) / 20 + 1;
		}
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
	
}
