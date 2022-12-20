package com.portal.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
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
import com.portal.domain.member.StudentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.course.DepartmentService;
import com.portal.service.member.StudentService;

@Controller
@RequestMapping("student")
public class StudentController {

	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private AdminMapper adminMapper;
	
//	@GetMapping("register")
//	@PreAuthorize("hasAnyAuthority('admin','member')")
//	public void register(Model model) {
//		List<DepartmentDto> departmentList = departmentService.getDepartmentAll();
//		model.addAttribute("departmentList", departmentList);
//	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	@ResponseBody
	public Map<String, Object> register() {
		Map<String, Object> map = new HashMap<>();
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		int studentNumber = studentService.setStudentNumberByDepartmentId(1);
		map.put("studentNumber", studentNumber);
		map.put("organizationList", organizationList);
		return map;
	}
	
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public String register(StudentDto student, Authentication authentication) {
	int cnt = studentService.registerStudent(student);
	
	String messageLog = "";
	int studentNumber = student.getStudentNumber();
	if(cnt == 1) {
		messageLog = "학생번호 " + studentNumber + " 학생 추가 성공";
	} else {
		messageLog = "학생번호 " + studentNumber + " 학생 추가 실패";
	}
	
	String category = "register";
	
	AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
	adminLogService.registerStudentLogById(admin.getId(), messageLog, category);
	
		return "redirect:/student/list";
	}
	
	@GetMapping("list")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public void list(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		List<StudentDto> studentList = studentService.getStudentByPageInfo(startNum, count);
		int totalNum = studentService.getCountCourseAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
		model.addAttribute("studentList", studentList);
	}
	
	@GetMapping("getInfo/{studentNumber}")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	@ResponseBody
	public StudentDto getInfo(@PathVariable int studentNumber) {
		StudentDto student = studentService.getStudentByStudentNumber(studentNumber);
		return student;
	}
	
	@PostMapping("setStudentNumber")
	@ResponseBody
	public Map<String, Object> setStudentNumber(@RequestBody Map<String, String> req) {
		Map<String, Object> map = new HashMap<>();
		int departmentId = Integer.parseInt(req.get("departmentId"));
		System.out.println(departmentId);
		int studentNumber = studentService.setStudentNumberByDepartmentId(departmentId);
		map.put("studentNumber", studentNumber);
		return map;
	}
	
	@GetMapping("modify/{studentNumber}")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	@ResponseBody
	public Map<String, Object> modify(@PathVariable int studentNumber) {
		Map<String, Object> map = new HashMap<>();
		StudentDto student = studentService.getStudentByStudentNumber(studentNumber);
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		map.put("organizationList", organizationList);
		map.put("student", student);
		return map;
	}
	
	@PostMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public String modify(StudentDto student, Authentication authentication) {
		
		int cnt = studentService.modifyStudent(student);
		
		String messageLog = "";
		int studentNumber = student.getStudentNumber();
		if(cnt == 1) {
			messageLog = "학생번호 " + studentNumber + " 학생 정보 수정 성공";
		} else {
			messageLog = "학생번호 " + studentNumber + " 학생 정보 수정 실패";
		}
		
		String category = "modify";
		
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		adminLogService.registerStudentLogById(admin.getId(), messageLog, category);
		
			return "redirect:/student/list";		
	}
	
	@PostMapping("remove")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public String modify(int studentNumber, Authentication authentication) {
		
		int cnt = studentService.removeStudent(studentNumber);
		
		String messageLog = "";
		
		if(cnt == 1) {
			messageLog = "학생번호 " + studentNumber + " 학생 정보 삭제 성공";
		} else {
			messageLog = "학생번호 " + studentNumber + " 학생 정보 삭제 실패";
		}
		
		String category = "remove";
		
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		adminLogService.registerStudentLogById(admin.getId(), messageLog, category);
		
			return "redirect:/student/list";		
	}
	
}
