package com.portal.service.course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.portal.mapper.courseSchedule.CourseScheduleMapper;

@Service
public class CourseScheduleService {
	
	@Autowired
	private CourseScheduleMapper courseScheduleMapper;

	public int registerScheduleByClassCode(int classCode, String day, int startTimeId, int endTimeId) {
		// TODO Auto-generated method stub
		return courseScheduleMapper.insertScheduleByClassCode(classCode, day, startTimeId, endTimeId);
	}
	
	
}
