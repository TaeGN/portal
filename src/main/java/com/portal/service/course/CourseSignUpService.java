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

	public int removeCourseSignUp(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.deleteCourseSignUp(studentNumber, classCode);
	}
	
	public CourseSignUpDto getCourseSignUpById(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
	}

	public List<Integer> getClassCodeByUserId(String userId) {
		StudentDto student = studentService.getStudentByStudentId(userId);
		return courseSignUpMapper.selectClassCodeByStudentNumber(student.getStudentNumber());
	}

	public List<CourseDto> getCourseByStudentNumber(int studentNumber, int startNum, int count) {
		return courseSignUpMapper.selectCourseByStudentNumber(studentNumber, startNum, count);
	}
	
	public List<CourseDto> getSignUpAllByStudentNumber(int studentNumber, int startNum, int count) {
		return courseSignUpMapper.selectSignUpAllByStudentNumber(studentNumber, startNum, count);
	}
	
	// signUp true로 변경
	public int courseSignUp(int studentNumber, int classCode) {
		CourseSignUpDto courseSignUp = courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
		int cnt = 0;
		
		// signUp이 false일때만 실행
		if(courseSignUp.getSignUp().equals("false")) {
			cnt = courseSignUpMapper.updateCourseSignUpTrue(studentNumber, classCode);
		}
		return cnt;
	}
	
	// signUp false로 변경
	public int cancelCourseSignUp(int studentNumber, int classCode) {
		CourseSignUpDto courseSignUp = courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
		int cnt = 0;
		System.out.println(courseSignUp);
		// signUp이 true일때만 실행
		if(courseSignUp.getSignUp().equals("true")) {
			cnt = courseSignUpMapper.updateCourseSignUpFalse(studentNumber, classCode);
		}
		return cnt;
	}

	public int getCountDesireByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCountDesireByStudentNumber(studentNumber);
	}

	public int getCountSignUpByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCountSignUpByStudentNumber(studentNumber);
	}



	
}
