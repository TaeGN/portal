package com.portal.mapper.courseSignUp;

import java.util.List;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseSignUpDto;

public interface CourseSignUpMapper {

	int insertCourseSignUp(int studentNumber, int classCode);

	CourseSignUpDto selectCourseSignUpById(int studentNumber, int classCode);

	List<Integer> selectClassCodeByStudentNumber(int studentNumber);

	List<CourseDto> selectCourseByStudentNumber(int studentNumber, int startNum, int count);

	int deleteCourseSignUp(int studentNumber, int classCode);

	int updateCourseSignUpTrue(int studentNumber, int classCode);

	int updateCourseSignUpFalse(int studentNumber, int classCode);

	List<CourseDto> selectSignUpAllByStudentNumber(int studentNumber, int startNum, int count);

	int deleteSignUpByStudentNumber(int studentNumber);

	int deleteCourseSignUpByClassCode(int classCode);

	int selectCountDesireByStudentNumber(int studentNumber);

	int selectCountSignUpByStudentNumber(int studentNumber);

}
