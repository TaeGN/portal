package com.portal.domain.course;

import lombok.Data;

@Data
public class CourseSignUpScheduleDto {
	private int classCode;
	private String classNumber;
	private String time;
	private String Monday;
	private String Tuesday;
	private String Wednesday;
	private String Thursday;
	private String Friday;
	private String Saturday;
	private String Sunday;
}
