package com.portal.service.sugang;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.portal.domain.course.CourseDto;
import com.portal.domain.member.StudentDto;
import com.portal.domain.sugang.SignUpNoticeDto;
import com.portal.domain.sugang.SearchDto;
import com.portal.mapper.sugang.SugangMapper;
import com.portal.service.member.StudentService;

@Service
@Transactional
public class SugangService {
	
	@Autowired
	private SugangMapper sugangMapper;
	
	
	public List<CourseDto> getSearchCourseList(SearchDto search) {
		// TODO Auto-generated method stub
		return sugangMapper.selectCourseBySearchDto(search);
	}
	
	public List<CourseDto> getSearchCourseListByStudentNumber(SearchDto search) {
		// TODO Auto-generated method stub
		return sugangMapper.selectSearchCourseListByStudentNumber(search);
	}

	public List<SignUpNoticeDto> getSignUpNoticeList() {
		// TODO Auto-generated method stub
		return sugangMapper.selectSignUpNoticeAll();
	}


	public String getSignUpNoticeText(int id) {
		// TODO Auto-generated method stub
		return sugangMapper.selectSignUpNoticeTextById(id);
	}

	public int getTotalNumBySearchCourseList(SearchDto search) {
		// TODO Auto-generated method stub
		return sugangMapper.selectSearchCourseAll(search);
	}



}
