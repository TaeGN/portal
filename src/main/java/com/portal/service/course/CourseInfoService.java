package com.portal.service.course;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.course.CourseInfoDto;
import com.portal.mapper.course.CourseInfoMapper;

@Service
@Transactional
public class CourseInfoService {
	
	@Autowired
	private CourseInfoMapper courseInfoMapper;

	public int registerCourseInfo(CourseInfoDto courseInfo) {
		
		return courseInfoMapper.insertCourseInfo(courseInfo);
	}

	public List<CourseInfoDto> getCourseInfoAll() {
		// TODO Auto-generated method stub
		return courseInfoMapper.selectCourseInfoAll();
	}

	public CourseInfoDto getCourseInfoByClassNumber(String classNumber) {
		// TODO Auto-generated method stub
		return courseInfoMapper.selectCourseInfoByClassNumber(classNumber);
	}
}
