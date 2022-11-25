package com.portal.domain.sugang;

import lombok.Data;

@Data
public class CourseDto {
	private int classCode;
	private String classNumber;
	private String courseName;
	private String organization;
	private int year;
	private String semester;
	private int grade;
	private String courseClassification;
}
