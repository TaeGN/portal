package com.portal.domain.course;

import lombok.Data;

@Data
public class CourseDto {
	private String grade;
	private int classCode;
	private String classNumber;
	private String professor;
	private int maxPersonnel;
	private int departmentId;
	private int year;
	private String semester;
	private int startTimeId;
	private String startTime;
	private int endTimeId;
	private String endTime;
	private String classroom;
	private String building;
	private String room;
	private DepartmentDto department;
	private CourseInfoDto courseInfo;
}
