package com.portal.service.course;

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
}
