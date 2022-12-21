package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseTimeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.mapper.course.CourseMapper;
import com.portal.mapper.courseSchedule.CourseScheduleMapper;
import com.portal.mapper.courseSignUp.CourseSignUpMapper;
import com.portal.mapper.member.StudentMapper;
import com.portal.service.admin.AdminLogService;

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
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private StudentMapper studentMapper;

	public List<CourseDto> getCourseAll(int startNum, int count) {
		List<CourseDto> courseList = courseMapper.selectCourseAll(startNum, count);
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
	public int removeCourseByProfessorNumber(int professorNumber, String username) {
		List<Integer> classCodeList = courseMapper.selectCourseByProfessorNumber(professorNumber);
		int cnt = 1;
		for(int classCode : classCodeList) {
			// CourseSchedule 삭제 
			courseScheduleMapper.deleteCourseScheduleByClassCode(classCode);
			// CourseSignUp 삭제
			courseSignUpMapper.deleteCourseSignUpByClassCode(classCode);
			// Course 삭제
			int cnt2 = removeCourseByClassCode(classCode, username);
			

			cnt *= cnt2;
		}
		
		return cnt;
	}

	public int getCountCourseAll() {
		// TODO Auto-generated method stub
		return courseMapper.selectCountCourseAll();
	}


	public List<CourseTimeDto> getCourseTimeByStartTimeId(int startTimeId) {
		// TODO Auto-generated method stub
		return courseMapper.selectCourseTimeByStartTimeid(startTimeId);
	}

	public int removeCourseByClassCode(int classCode, String username) {
		int cnt = courseMapper.deleteCourseByClassCode(classCode);
		
		String messageLog = "";
		if(cnt == 1) {
			messageLog = "수업번호 " + classCode + " 강의 삭제 성공";
		}	else {
			messageLog = "수업번호 " + classCode + " 강의 삭제 실패";
		}
		
		String category = "remove";
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(username);
		adminLogService.registerCourseLogById(admin.getId(), messageLog, category);
		
		return cnt;
	}

	public int removeCourseByClassNumber(String classNumber, String username) {
		List<Integer> classCodeList = courseMapper.selectCourseByClassNumber(classNumber);
		int cnt = 1;
		
		for(int classCode : classCodeList) {
			// CourseSchedule 삭제 
			courseScheduleMapper.deleteCourseScheduleByClassCode(classCode);
			// CourseSignUp 삭제
			courseSignUpMapper.deleteCourseSignUpByClassCode(classCode);
			// Course 삭제
			int cnt2 = removeCourseByClassCode(classCode, username);
			

			cnt *= cnt2;
		}
		
		return cnt;
	}

	public int modifyCourse(CourseDto course, String username) {
		
		int classCode = course.getClassCode();
		// CourseSchedule 삭제 
		courseScheduleMapper.deleteCourseScheduleByClassCode(classCode);
		
		// classNumber가 수정되었을 경우만 CourseSignUp 삭제
		String oldClassNumber = courseMapper.selectCourseByClassCode(classCode).getClassNumber();
		String newClassNumber = course.getClassNumber();
		if(oldClassNumber != newClassNumber) {
			courseSignUpMapper.deleteCourseSignUpByClassCode(classCode);
		}
		
		// building 구하기
		int buildingId = Integer.parseInt(course.getBuilding().split(":")[1]);
		String campus = course.getBuilding().split(":")[0];
		BuildingDto building = classroomService.getBuildingById(buildingId, campus);
		String classroom = building.getCampus() 
				+ " " + building.getName()
				+ " " + course.getRoom();
		
		course.setClassroom(classroom);
		
		// Course 수정
		int cnt = UpdateCourseByClassCode(course, username);
		
		// CourseSchedule 추가
		for(int i = 0; i < course.getDay().size(); i++) {
			String day = course.getDay().get(i);
			int startTimeId = course.getStartTimeId().get(i);
			int endTimeId = course.getEndTimeId().get(i);
			courseScheduleMapper.insertScheduleByClassCode(classCode, day, startTimeId, endTimeId);
		}
		
		
		return cnt;
	}

	public int UpdateCourseByClassCode(CourseDto course, String username) {
		int cnt = courseMapper.updateCourseByClassCode(course);
		int classCode = course.getClassCode();
		
		String messageLog = "";
		if(cnt == 1) {
			messageLog = "수업번호 " + classCode + " 강의 수정 성공";
		}	else {
			messageLog = "수업번호 " + classCode + " 강의 수정 실패";
		}
		
		String category = "modify";
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(username);
		adminLogService.registerCourseLogById(admin.getId(), messageLog, category);
		
		return cnt;
	}

	public int removeCourse(int classCode, String name) {
		// TODO Auto-generated method stub
		return 0;
	}

}
