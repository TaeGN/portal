package com.portal.mapper.course;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseTimeDto;

@Mapper
public interface CourseMapper {

	List<CourseDto> selectCourseAll(int startNum, int count);

	int insertCourse(CourseDto course);

	CourseDto selectLastCourse();

	List<CourseTimeDto> selectCourseTimeAll();

	CourseDto selectCourseByClassCode(int classCode);

	List<Integer> selectCourseByProfessorNumber(int professorNumber);

	int deleteCourseByClassCode(int classCode);

	int selectCountCourseAll();

	List<CourseTimeDto> selectCourseTimeByStartTimeid(int i);

	List<Integer> selectCourseByClassNumber(String classNumber);

	int updateCourseByClassCode(CourseDto course);


}
