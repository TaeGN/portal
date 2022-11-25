package com.portal.domain.member;

import lombok.Data;

@Data
public class StudentDto {
	private int studentNumber;
	private String studentName;
	private String id;
	private String password;
	private String firstResidentId;
	private String lastResidentId;
	private int grade;
	private String department;
}
