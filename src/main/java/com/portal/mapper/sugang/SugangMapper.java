package com.portal.mapper.sugang;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.portal.domain.course.CourseDto;
import com.portal.domain.sugang.SignUpNoticeDto;
import com.portal.domain.sugang.SearchDto;

@Mapper
public interface SugangMapper {

	List<SignUpNoticeDto> selectSignUpNoticeAll();

	String selectSignUpNoticeTextById(int id);

	List<CourseDto> selectCourseBySearchDto(SearchDto search);

	List<CourseDto> selectSearchCourseListByStudentNumber(SearchDto search);

	int selectSearchCourseAll(SearchDto search);

	List<SignUpNoticeDto> selectSignUpNoticeAllByPage(int startNum, int count);

	int selectCountSignUpNoticeAll();

}
