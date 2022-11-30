package com.portal.controller.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.portal.domain.member.StudentDto;
import com.portal.service.member.StudentService;

@Controller
@RequestMapping("student")
public class StudentController {

	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private StudentService studentService;
	
	@GetMapping("login")
	public void login() {
		
	}
	
	@GetMapping("admin")
	public void admin() {
		
	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public void register() {
		
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public void register(StudentDto student) {
		int cnt = studentService.registerStudent(student);
	}
	
	@GetMapping("list")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public void list(Model model) {
		List<StudentDto> list= studentService.studentList();
		model.addAttribute("studentList", list);
	}
	
	@GetMapping("get")
	@PreAuthorize("hasAnyAuthority('admin','member')")
	public void modify(@RequestParam(name = "q") int studentNumber, Model model, String username) {
		StudentDto student = studentService.getStudentByStudentNumber(studentNumber);
		model.addAttribute("student", student);
	}
}
