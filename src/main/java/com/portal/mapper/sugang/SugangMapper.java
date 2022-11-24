package com.portal.mapper.sugang;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.sugang.CourseDto;
import com.portal.domain.sugang.InfoDto;

@Mapper
public interface SugangMapper {
	
	List<CourseDto> selectCourseAll();

	List<InfoDto> selectInfoAll();

	String selectInfoTextByInfoId(int id);
}
