package com.portal.controller.course;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseSignUpDto;
import com.portal.domain.member.StudentDto;
import com.portal.service.course.CourseService;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.member.StudentService;

@Controller
@RequestMapping("courseSignUp")
public class CourseSignUpController {
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private StudentService studentService;
		
	
	@PostMapping("register")
	@ResponseBody
	public Map<String, Object> register(@RequestBody Map<String, String> req) {
		Map<String, Object> map = new HashMap<>();
		System.out.println(req);
		int classCode = Integer.parseInt(req.get("classCode"));
		String studentId = req.get("studentId");
		StudentDto student = studentService.getStudentByStudentId(studentId);
		int studentNumber = student.getStudentNumber();
		
		int cnt = courseSignUpService.registerCourseSignUp(studentNumber, classCode);
		String message = "";
		if(cnt == 1) {
			message = "희망수업 등록 완료";
			CourseSignUpDto courseSignUp = courseSignUpService.getCourseSignUpById(studentNumber, classCode);
//			map.put("courseSignUp", courseSignUp);
		} else {
			message = "희망수업 등록 실패";
		}
		
		map.put("message", message);
		map.put("studentNumber", studentNumber);
		map.put("classCode", classCode);
		System.out.println(map);
		return map;
	}
}
