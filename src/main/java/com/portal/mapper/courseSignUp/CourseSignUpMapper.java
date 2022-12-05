package com.portal.mapper.courseSignUp;

import java.util.List;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseSignUpDto;

public interface CourseSignUpMapper {

	int insertCourseSignUp(int studentNumber, int classCode);

	CourseSignUpDto selectCourseSignUpById(int studentNumber, int classCode);

	List<Integer> selectClassCodeByStudentNumber(int studentNumber);

	List<CourseDto> selectCourseByStudentNumber(int studentNumber);

}
