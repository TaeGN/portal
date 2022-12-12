package com.portal.mapper.courseSignUp;

import java.util.List;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseSignUpDto;

public interface CourseSignUpMapper {

	int insertCourseSignUp(int studentNumber, int classCode);

	CourseSignUpDto selectCourseSignUpById(int studentNumber, int classCode);

	List<Integer> selectClassCodeByStudentNumber(int studentNumber);

	List<CourseDto> selectCourseByStudentNumber(int studentNumber);

	int deleteCourseSignUp(int studentNumber, int classCode);

	int updateCourseSignUpTrue(int studentNumber, int classCode);

	int updateCourseSignUpFalse(int studentNumber, int classCode);

	List<CourseDto> selectSignUpAllByStudentNumber(int studentNumber);

	int deleteSignUpByStudentNumber(int studentNumber);

}
