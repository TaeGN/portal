package com.portal.domain.member;

import com.portal.domain.course.CollegeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;

import lombok.Data;

@Data
public class StudentDto {
	private int studentNumber;
	private String studentName;
	private String id;
	private String password;
	private String firstResidentId;
	private String lastResidentId;
	private String grade;
	private int departmentId;
	private DepartmentDto department;
}
