package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.course.CourseInfoDto;
import com.portal.mapper.course.CourseInfoMapper;

@Service
@Transactional
public class CourseInfoService {
	
	@Autowired
	private CourseInfoMapper courseInfoMapper;
	
	@Autowired
	private CourseService courseService;

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

	public int modifyCourseInfo(CourseInfoDto courseInfo) {
		// TODO Auto-generated method stub
		return courseInfoMapper.updateCourseInfo(courseInfo);
	}

	public int removeCourseInfoByClassNumber(String classNumber, String username) {
		// classNumber에 해당하는 course 먼저 삭제
		int cnt = courseService.removeCourseByClassNumber(classNumber, username);
		
		// courseInfo 삭제
		return courseInfoMapper.deleteCourseInfoByClassNumber(classNumber);
	}

	public List<CourseInfoDto> getCourseInfoByPageInfo(int startNum, int count) {
		// TODO Auto-generated method stub
		return courseInfoMapper.selectCourseInfoAllByPageInfo(startNum, count);
	}

	public int getCountCourseInfoAll() {
		// TODO Auto-generated method stub
		return courseInfoMapper.selectCountCourseInfoAll();
	}
}
