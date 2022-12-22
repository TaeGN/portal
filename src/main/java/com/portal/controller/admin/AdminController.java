package com.portal.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.domain.admin.AdminLogDto;
import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.course.CourseDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.admin.AdminService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	// 기본화면 대시보드
	@GetMapping("")
	@PreAuthorize("isAuthenticated()")
	public String admin() {
		
		return "redirect:/admin/board";
	}
	
	
	static int count = 10;
	// 대시보드
	@GetMapping("board")
	@PreAuthorize("isAuthenticated()")
	public void board(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int startNum = (page - 1) * count; 
		
		List<AdminLogDto> list = adminLogService.getAdminLogAll(startNum, count);
		int totalNum = adminLogService.getCountAdminLogAll();
		int maxPage = (totalNum - 1) / count + 1;
		System.out.println(totalNum);
		
		model.addAttribute("adminLogList", list);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
	}
	
	
	
	@GetMapping("getAdminLog/{page}")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public Map<String, Object> getAdminLog(@PathVariable int page) {
		int startNum = (page - 1) * count; 
		
		List<AdminLogDto> adminLogList = adminLogService.getAdminLogAll(startNum, count);
		int totalNum = adminLogService.getCountAdminLogAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		Map<String, Object> map = new HashMap<>();
		map.put("adminLogList", adminLogList);
		map.put("maxPage", maxPage);
		
		
		return map;
	}
	
	@PostMapping("remove")
	@PreAuthorize("hasAuthority('admin')")
	public String remove(int id, RedirectAttributes rttr, Authentication authentication) {
		int cnt = adminService.removeAdminMemberById(id, authentication.getName());
		
		String messageLog = "";
		if(cnt == 1) {
			messageLog = "관리자 번호 " + id + " 정보 삭제 완료";
			rttr.addFlashAttribute("message", messageLog);
			
		} else {
			messageLog = "관리자 번호 " + id + " 정보 삭제 실패";
			rttr.addFlashAttribute("message", messageLog);
		}
		AdminMemberDto adminMember = adminMapper.selectAdminMemberByUserName(authentication.getName());
		adminLogService.registerAdminLogById(adminMember.getId(), messageLog, "remove");
		return "redirect:/admin/list";
	}
	
	// 관리자 정보 수정
	@GetMapping("modify")
	@PreAuthorize("hasAuthority('admin') or (authentication.name == #username)")
	public void modify(String username, Model model) {
		AdminMemberDto adminMember = adminService.getAdminMemberByUserName(username);
		
		model.addAttribute("adminMember", adminMember);
	}
	
	@PostMapping("modify")
	@PreAuthorize("hasAuthority('admin') or (authentication.name == #username)")
	public String modify(AdminMemberDto adminMember,
			Model model, 
			RedirectAttributes rttr,
			Authentication authentication,
			String username) {
		
		int cnt = adminService.modifyAdminMember(adminMember);

		String messageLog = "";
		if(cnt == 1) {
			messageLog = "관리자 번호 " + adminMember.getId() + " 정보 수정 완료";
			rttr.addFlashAttribute("message", messageLog);
			
		} else {
			messageLog = "관리자 번호 " + adminMember.getId() + " 정보 수정 실패";
			rttr.addFlashAttribute("message", messageLog);
		}
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		adminLogService.registerAdminLogById(admin.getId(), messageLog, "modify");
		return "redirect:/admin/list";
	}
	
//	@PostMapping("modify")
//	@PreAuthorize("hasAuthority('admin') or (authentication.name == #username)")
//	public String modify(AdminMemberDto adminMember,
//			Model model, 
//			MultipartFile[] addFiles,
//			@RequestParam(name = "removeFiles", required = false) List<String> removeFiles,
//			RedirectAttributes rttr,
//			Authentication authentication,
//			String username) {
//		if(addFiles.length != 0) {
//			int cnt = adminService.modifyAdminMember(adminMember, addFiles, removeFiles);
//		} else {
//			int cnt = adminService.modifyAdminMember(adminMember);
//		}
//		String messageLog = "";
//		if(cnt == 1) {
//			messageLog = "관리자 번호 " + adminMember.getId() + " 정보 수정 완료";
//			rttr.addFlashAttribute("message", messageLog);
//			
//		} else {
//			messageLog = "관리자 번호 " + adminMember.getId() + " 정보 수정 실패";
//			rttr.addFlashAttribute("message", messageLog);
//		}
//		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
//		adminLogService.registerAdminLogById(admin.getId(), messageLog, "modify");
//		return "redirect:/admin/list";
//	}
	
	
	// 관리자 정보 얻기
	@GetMapping("get")
	@PreAuthorize("hasAuthority('admin') or (authentication.name == #username)")
	public void get(String username, Model model) {
		AdminMemberDto adminMember = adminService.getAdminMemberByUserName(username);
		System.out.println(adminMember.getFileList());
		
		model.addAttribute("adminMember", adminMember);
	}
	
	@GetMapping("get/{id}")
	@PreAuthorize("hasAuthority('admin')")
	@ResponseBody
	public AdminMemberDto get(@PathVariable int id) {
		AdminMemberDto adminMember = adminService.getAdminMemberById(id);
		
		return adminMember;
	}
	
	
	// 관리자 등록
	@GetMapping("register")
	@PreAuthorize("hasAuthority('admin')")
	public void register() {
		
	}	
	
	@PostMapping("register")
	@PreAuthorize("hasAuthority('admin')")
	public String method(AdminMemberDto adminMember, 
			RedirectAttributes rttr,
			Authentication authentication) {
		int id = adminMapper.selectLastAdminMemberById();
		
		adminMember.setId(id + 1);
		int cnt = adminService.registerAdminMember(adminMember);
		
		String messageLog = "";
		if(cnt == 1) {
			messageLog = "관리자 번호 " + adminMember.getId() + " 등록 완료";
			rttr.addFlashAttribute("message", messageLog);
			
		} else {
			messageLog = "관리자 번호 " + adminMember.getId() + " 등록 실패";
			rttr.addFlashAttribute("message", messageLog);
		}
		// adminLog 등록
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		adminLogService.registerAdminLogById(admin.getId(), messageLog, "register");
		
		return "redirect:/admin/list";
	}
	
//	@PostMapping("register")
//	@PreAuthorize("hasAuthority('admin')")
//	public String method(AdminMemberDto adminMember, 
//			MultipartFile[] files,
//			RedirectAttributes rttr,
//			Authentication authentication) {
//		int id = adminMapper.selectLastAdminMemberById();
//		adminMember.setId(id + 1);
//		int cnt = adminService.registerAdminMember(adminMember, files);
//		
//		String messageLog = "";
//		if(cnt == 1) {
//			messageLog = "관리자 번호 " + adminMember.getId() + " 등록 완료";
//			rttr.addFlashAttribute("message", messageLog);
//			
//		} else {
//			messageLog = "관리자 번호 " + adminMember.getId() + " 등록 실패";
//			rttr.addFlashAttribute("message", messageLog);
//		}
//		// adminLog 등록
//		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
//		adminLogService.registerAdminLogById(admin.getId(), messageLog, "register");
//		
//		return "redirect:/admin/list";
//	}
	
	
	// 관리자 리스트
	@GetMapping("list")
	@PreAuthorize("hasAuthority('admin')")
	public void member(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int startNum = (page - 1) * count; 
		
		List<AdminMemberDto> list = adminService.getAdminMemberList(startNum, count);
		int totalNum = adminService.getCountAdminMemberAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
		model.addAttribute("adminMemberList", list);
	}
}
