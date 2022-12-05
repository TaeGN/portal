package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseSignUpDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.courseSignUp.CourseSignUpMapper;
import com.portal.service.member.StudentService;

@Service
@Transactional
public class CourseSignUpService {
	
	@Autowired
	private CourseSignUpMapper courseSignUpMapper;
	
	@Autowired
	private StudentService studentService;
	

	public int registerCourseSignUp(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.insertCourseSignUp(studentNumber, classCode);
	}

	public CourseSignUpDto getCourseSignUpById(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
	}

	public List<Integer> getClassCodeByUserId(String userId) {
		StudentDto student = studentService.getStudentByStudentId(userId);
		return courseSignUpMapper.selectClassCodeByStudentNumber(student.getStudentNumber());
	}

	public List<CourseDto> getCourseByUserId(String userId) {
		StudentDto student = studentService.getStudentByStudentId(userId);
		return courseSignUpMapper.selectCourseByStudentNumber(student.getStudentNumber());
	}
	
}
