package com.portal.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.sugang.SignUpNoticeDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.admin.SignUpNoticeService;

@Controller
@RequestMapping("signUpNotice")
public class SignUpNoticeController {
	
	@Autowired
	private SignUpNoticeService signUpNoticeService;
	
	@Autowired
	private AdminMapper amdinMapper;
	
	@Autowired
	private AdminLogService adminLogService;
	 
	@GetMapping("list")
	@PreAuthorize("hasAnyAuthority('admin','sugang')")
	public void list(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		List<SignUpNoticeDto> signUpNoticeList = signUpNoticeService.getSignUpNoticeAllByPage(startNum, count);
		int totalNum = signUpNoticeService.getCountSignUpNoticeAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		model.addAttribute("signUpNoticeList", signUpNoticeList);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
	}
	
	@GetMapping("get/{id}")
	@PreAuthorize("hasAnyAuthority('admin','sugang')")
	@ResponseBody
	public SignUpNoticeDto get(@PathVariable int id) {
		SignUpNoticeDto signUpNotice = signUpNoticeService.getSignUpNoticeById(id);
		
		return signUpNotice;
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','sugang')")
	public String register(SignUpNoticeDto signUpNotice, Authentication authentication) {
		
		// ????????? ??????
		AdminMemberDto adminMember = amdinMapper.selectAdminMemberByUserName(authentication.getName());
		signUpNotice.setWriterId(adminMember.getId());
		
		int cnt = signUpNoticeService.registerSignUpNotice(signUpNotice);
		String messageLog = "";
		int signUpNoticeId = signUpNoticeService.getLastSignUpNoticeId();
		if(cnt == 1) {
			messageLog = "???????????? : " + signUpNoticeId + " ???????????? ?????? ??????";
		}	else {
			messageLog = "???????????? ?????? ??????";
		}
		
		String category = "register";
		int cnt2 = adminLogService.registerSignUpNoticeLogById(adminMember.getId(), messageLog, category);
		
		return "redirect:/signUpNotice/list";
	}
	
	
	@PostMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','sugang')")
	public String modify(SignUpNoticeDto signUpNotice, Authentication authentication) {
		
		// ????????? ??????
		AdminMemberDto adminMember = amdinMapper.selectAdminMemberByUserName(authentication.getName());
		signUpNotice.setWriterId(adminMember.getId());
		
		int cnt = signUpNoticeService.modifySignUpNotice(signUpNotice);
		String messageLog = "";
		
		if(cnt == 1) {
			messageLog = "???????????? : " + signUpNotice.getId() + " ???????????? ?????? ??????";
		}	else {
			messageLog = "???????????? : " + signUpNotice.getId() + " ???????????? ?????? ??????";
		}
		
		String category = "modify";
		int cnt2 = adminLogService.registerSignUpNoticeLogById(adminMember.getId(), messageLog, category);
		
		return "redirect:/signUpNotice/list";
	}
	
	
	@PostMapping("remove")
	@PreAuthorize("hasAnyAuthority('admin','sugang')")
	public String remove(int id, Authentication authentication) {
		
		// ????????? ??????
		
		int cnt = signUpNoticeService.removeSignUpNotice(id);
		String messageLog = "";
		
		if(cnt == 1) {
			messageLog = "???????????? : " + id + " ???????????? ?????? ??????";
		}	else {
			messageLog = "???????????? : " + id + " ???????????? ?????? ??????";
		}
		String category = "remove";
		AdminMemberDto admin = amdinMapper.selectAdminMemberByUserName(authentication.getName());
		int cnt2 = adminLogService.registerSignUpNoticeLogById(admin.getId(), messageLog, category);
		
		return "redirect:/signUpNotice/list";
	}
	
	
	
}
