package com.portal.domain.sugang;

import lombok.Data;

@Data
public class SearchDto {
	private String organization;
	private int year;
	private String semester;
	private int grade;
	private String courseClassification;

}
