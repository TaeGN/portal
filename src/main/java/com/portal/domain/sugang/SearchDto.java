package com.portal.domain.sugang;

import java.util.List;

import lombok.Data;

@Data
public class SearchDto {
	private int organizationId;
	private int collegeId;
	private int departmentId;
	private int year;
	private String semester;
	private String grade;
	private String courseClassification;
	private String classNumber;
	private String courseName;
	private String professorName;
	private String classroom;
	private int page;
	private String buildingStr;
	
	private List<String> building;
	private String studentId;
	private int studentNumber;
	private int startNum;
	private int endNum;
	private int count;
}
