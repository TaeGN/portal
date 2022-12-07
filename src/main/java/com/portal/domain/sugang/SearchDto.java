package com.portal.domain.sugang;

import lombok.Data;

@Data
public class SearchDto {
	private String organization;
	private int year;
	private String semester;
	private String grade;
	private String courseClassification;
	private int studentNumber;
}
