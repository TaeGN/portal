package com.portal.domain.course;

import lombok.Data;

@Data
public class CourseScheduleDto {
	private int classCode;
	private String day;
	private String startTime;
	private String endTime;
	private int startTimeId;
	private int endTimeId;
	private String courseName;
}
