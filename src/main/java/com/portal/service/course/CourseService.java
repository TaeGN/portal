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
import com.portal.mapper.courseSchedule.CourseScheduleMapper;
import com.portal.mapper.courseSignUp.CourseSignUpMapper;

@Service
@Transactional
public class CourseService {
	
	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private ClassroomService classroomService;
	
	@Autowired
	private CourseScheduleMapper courseScheduleMapper;
	
	@Autowired
	private CourseSignUpMapper courseSignUpMapper;

	public List<CourseDto> getCourseAll() {
		List<CourseDto> courseList = courseMapper.selectCourseAll();
		return courseList;
	}

	public int registerCourse(CourseDto course) {
		
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

	public CourseDto getCourseByClassCode(int classCode) {
		// TODO Auto-generated method stub
		return courseMapper.selectCourseByClassCode(classCode);
	}
	
	// professorNumber에 해당하는 Course 삭제 (CourseSchedule, CourseSignUp도 같이 삭제)
	public int removeCourseByProfessorNumber(int professorNumber) {
		List<Integer> classCodeList = courseMapper.selectCourseByProfessorNumber(professorNumber);
		int cnt = 1;
		for(int classCode : classCodeList) {
			// CourseSchedule 삭제 
			courseScheduleMapper.deleteCourseScheduleByClassCode(classCode);
			// CourseSignUp 삭제
			courseSignUpMapper.deleteCourseSignUpByClassCode(classCode);
			// Course 삭제
			cnt *= courseMapper.deleteCourseByClassCode(classCode);
		}
		
		return cnt;
	}
}
