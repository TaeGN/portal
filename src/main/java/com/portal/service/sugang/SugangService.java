package com.portal.service.sugang;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.sugang.CourseDto;
import com.portal.domain.sugang.InfoDto;
import com.portal.domain.sugang.SearchDto;
import com.portal.mapper.sugang.SugangMapper;

@Service
@Transactional
public class SugangService {
	
	@Autowired
	private SugangMapper sugangMapper;
	
	
	public List<CourseDto> getCourseList(CourseDto course) {
		List<CourseDto> list = new ArrayList<>();
		
		if(course == null) {
			list = sugangMapper.selectCourseAll();
		} else {
			list = sugangMapper.selectCourseBySearchDto(course);
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
