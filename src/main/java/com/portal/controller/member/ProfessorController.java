package com.portal.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;
import com.portal.domain.member.ProfessorDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.course.DepartmentService;
import com.portal.service.member.ProfessorService;

@Controller
@RequestMapping("professor")
public class ProfessorController {
	
	@Autowired
	private ProfessorService professorService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@GetMapping("list")
	public void list(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		List<ProfessorDto> professorList = professorService.getProfessorByPageInfo(startNum, count);
		int totalNum = professorService.getCountProfessorAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
		model.addAttribute("professorList", professorList);
	}
	
	@GetMapping("modify/{professorNumber}")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	@ResponseBody
	public Map<String, Object> modify(@PathVariable int professorNumber) {
		Map<String, Object> map = new HashMap<>();
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		ProfessorDto professor = professorService.getProfessorByProfessorNumber(professorNumber);
		map.put("professor", professor);
		map.put("organizationList", organizationList);
		return map;
	}
	
	@PostMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public String modify(ProfessorDto professor, Authentication authentication) {
		System.out.println(professor);
			int cnt = professorService.modifyProfessor(professor);
			String messageLog = "";
			int professorNumber = professor.getProfessorNumber();
			if(cnt == 1) {
				messageLog = "교수번호 " + professorNumber + " 교수 정보 수정 성공";
			} else {
				messageLog = "교수번호 " + professorNumber + " 교수 정보 수정 실패";
			}
			
			String category = "modify";
			
			AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
			adminLogService.registerProfessorLogById(admin.getId(), messageLog, category);
			
			return "redirect:/professor/list";			
		
	}
	
	@PostMapping("remove")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public String modify(int professorNumber, Authentication authentication) {
			int cnt = professorService.removeProfessor(professorNumber, authentication.getName());
			
			String messageLog = "";
			if(cnt == 1) {
				messageLog = "교수번호 " + professorNumber + " 교수 삭제 성공";
			} else {
				messageLog = "교수번호 " + professorNumber + " 교수 삭제 실패";
			}
			
			String category = "remove";
			
			AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
			adminLogService.registerProfessorLogById(admin.getId(), messageLog, category);
			
			return "redirect:/professor/list";				

	}
	
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	@ResponseBody
	public Map<String, Object> register() {
		Map<String, Object> map = new HashMap<>();
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		int professorNumber = professorService.setProfessorNumberByDepartmentId(1);
		map.put("professorNumber", professorNumber);
		map.put("organizationList", organizationList);
		return map;
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public String register(ProfessorDto professor, Authentication authentication) {
	int cnt = professorService.registerProfessor(professor);
	
	String messageLog = "";
	int professorNumber = professor.getProfessorNumber();
	if(cnt == 1) {
		messageLog = "교수번호 " + professorNumber + " 교수 등록 성공";
	} else {
		messageLog = "교수번호 " + professorNumber + " 교수 등록 실패";
	}
	
	String category = "register";
	
	AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
	adminLogService.registerProfessorLogById(admin.getId(), messageLog, category);
	
	return "redirect:/professor/list";
	}
	
	@PostMapping("setProfessorNumber")
	@ResponseBody
	public Map<String, Object> setStudentNumber(@RequestBody Map<String, String> req) {
		Map<String, Object> map = new HashMap<>();
		int departmentId = Integer.parseInt(req.get("departmentId"));
		int professorNumber = professorService.setProfessorNumberByDepartmentId(departmentId);
		map.put("professorNumber", professorNumber);
		return map;
	}
	
	@GetMapping("getInfo/{professorNumber}")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	@ResponseBody
	public ProfessorDto getInfo(@PathVariable int professorNumber) {
		ProfessorDto professor = professorService.getProfessorByProfessorNumber(professorNumber);
		return professor;
	}
	
}
