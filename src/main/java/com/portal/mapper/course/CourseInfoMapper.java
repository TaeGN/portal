package com.portal.mapper.course;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.course.CourseInfoDto;

@Mapper
public interface CourseInfoMapper {

	int insertCourseInfo(CourseInfoDto courseInfo);

	List<CourseInfoDto> selectCourseInfoAll();

	CourseInfoDto selectCourseInfoByClassNumber(String classNumber);

	int updateCourseInfo(CourseInfoDto courseInfo);

	int deleteCourseInfoByClassNumber(String classNumber);

	List<CourseInfoDto> selectCourseInfoAllByPageInfo(int startNum, int count);

	int selectCountCourseInfoAll();

}
