package com.portal.domain.sugang;

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
	private int studentNumber;
	private int startNum;
	private int count;
}
