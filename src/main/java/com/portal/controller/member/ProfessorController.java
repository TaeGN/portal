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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.course.DepartmentDto;
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
	public void list(Model model) {
		List<ProfessorDto> professorList = professorService.getProfessorAll();
		model.addAttribute("professorList", professorList);
	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public void register(Model model) {
		List<DepartmentDto> departmentList = departmentService.getDepartmentAll();
		model.addAttribute("departmentList", departmentList);
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
		int departmentId = Integer.parseInt(req.get("department"));
		int professorNumber = professorService.setProfessorNumberByDepartmentId(departmentId);
		map.put("professorNumber", professorNumber);
		return map;
	}
	
}
