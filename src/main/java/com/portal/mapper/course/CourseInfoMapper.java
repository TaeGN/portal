package com.portal.mapper.course;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.course.CourseInfoDto;

@Mapper
public interface CourseInfoMapper {

	int insertCourseInfo(CourseInfoDto courseInfo);

}
