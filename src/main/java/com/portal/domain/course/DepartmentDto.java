package com.portal.domain.course;

import lombok.Data;

@Data
public class DepartmentDto {
	private int id;
	private String name;
	private int collegeId;
	private CollegeDto college;
}
