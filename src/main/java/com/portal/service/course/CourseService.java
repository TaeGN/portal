package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.mapper.course.CourseMapper;

@Service
@Transactional
public class CourseService {
	
	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private DepartmentService departmentService;

	public List<CourseDto> getCourseAll() {
		
		return courseMapper.selectCourseAll();
	}

	public int registerCourse(CourseDto course, String departmentName) {
		int departmentId = departmentService.getDepartmentIdByName(departmentName);
		course.setDepartmentId(departmentId);
		
//		DepartmentDto department = departmentService.getDepartmentById(departmentId);
//		course.setDepartment(department);
		return courseMapper.insertCourse(course);
	}
}
