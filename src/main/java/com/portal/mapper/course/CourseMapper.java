package com.portal.mapper.course;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.course.CourseDto;

@Mapper
public interface CourseMapper {

	List<CourseDto> selectCourseAll();

	int insertCourse(CourseDto course);

	CourseDto selectLastCourse();

}
