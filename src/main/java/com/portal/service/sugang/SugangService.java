package com.portal.service.sugang;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.portal.domain.course.CourseDto;
import com.portal.domain.member.StudentDto;
import com.portal.domain.sugang.InfoDto;
import com.portal.domain.sugang.SearchDto;
import com.portal.mapper.sugang.SugangMapper;
import com.portal.service.member.StudentService;

@Service
@Transactional
public class SugangService {
	
	@Autowired
	private SugangMapper sugangMapper;
	
	@Autowired
	private StudentService studentService;
	
	
	public List<CourseDto> getSearchCourseList(SearchDto search) {
		List<CourseDto> list = new ArrayList<>();
		
		if(search.getYear() == 0) {
			list = sugangMapper.selectCourseAll();
		} else {
			list = sugangMapper.selectCourseBySearchDto(search);
		}
		return list;
	}

	public List<CourseDto> getSearchCourseListByUserId(SearchDto search, String userId) {
		StudentDto student = studentService.getStudentByStudentId(userId);
		int studentNumber = student.getStudentNumber();
		List<CourseDto> list = new ArrayList<>();
		if(search.getYear() == 0) {
			list = sugangMapper.selectCourseAllByStudentNumber(studentNumber);
		} else {
			search.setStudentNumber(studentNumber);
			list = sugangMapper.selectSearchCourseListByStudentNumber(search);
		}
		return list;
	}

	public List<InfoDto> getInfoList() {
		// TODO Auto-generated method stub
		return sugangMapper.selectInfoAll();
	}


	public String getInfoText(int id) {
		// TODO Auto-generated method stub
		return sugangMapper.selectInfoTextByInfoId(id);
	}



}
