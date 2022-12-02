package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseTimeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.mapper.course.CourseMapper;

@Service
@Transactional
public class CourseService {
	
	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private ClassroomService classroomService;
	
	@Autowired
	private DepartmentService departmentService;

	public List<CourseDto> getCourseAll() {
		List<CourseDto> courseList = courseMapper.selectCourseAll();
		return courseList;
	}

	public int registerCourse(CourseDto course) {
//		int departmentId = departmentService.getDepartmentIdByName(departmentName);
//		course.setDepartmentId(departmentId);
		
//		DepartmentDto department = departmentService.getDepartmentById(departmentId);
//		course.setDepartment(department);
		
		// building 구하기
		int buildingId = Integer.parseInt(course.getBuilding().split(":")[1]);
		String campus = course.getBuilding().split(":")[0];
		BuildingDto building = classroomService.getBuildingById(buildingId, campus);
		String classroom = building.getCampus() 
				+ " " + building.getName()
				+ " " + course.getRoom();
		
		course.setClassroom(classroom);
		return courseMapper.insertCourse(course);
	}

	public CourseDto getLastCourse() {
		// TODO Auto-generated method stub
		return courseMapper.selectLastCourse();
	}

	public List<CourseTimeDto> getCourseTimeAll() {
		// TODO Auto-generated method stub
		return courseMapper.selectCourseTimeAll();
	}
}
