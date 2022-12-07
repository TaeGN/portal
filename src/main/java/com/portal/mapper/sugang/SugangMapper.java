package com.portal.mapper.sugang;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.portal.domain.course.CourseDto;
import com.portal.domain.sugang.InfoDto;
import com.portal.domain.sugang.SearchDto;

@Mapper
public interface SugangMapper {
	
	List<CourseDto> selectCourseAll();

	List<InfoDto> selectInfoAll();

	String selectInfoTextByInfoId(int id);

	List<CourseDto> selectCourseBySearchDto(SearchDto search);

	List<CourseDto> selectSearchCourseListByStudentNumber(SearchDto search);

	List<CourseDto> selectCourseAllByStudentNumber(int studentNumber);

}
