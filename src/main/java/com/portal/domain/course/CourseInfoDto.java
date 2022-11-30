package com.portal.domain.course;

import lombok.Data;

@Data
public class CourseInfoDto {
	private String courseClassification;
	private String classNumber;
	private String courseName;
	private int credit;
	private int theory;
	private int practice;
	private String summary;
}
