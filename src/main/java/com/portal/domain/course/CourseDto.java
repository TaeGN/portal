package com.portal.domain.course;

import lombok.Data;

@Data
public class CourseDto {
	private int grade;
	private int classCode;
	private String classNumber;
	private String professor;
	private int maxPersonnel;
	private int departmentId;
	private int year;
	private String semester;
	private DepartmentDto department;
	private CourseInfoDto courseInfo;
}
