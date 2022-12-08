package com.portal.domain.member;

import java.time.LocalDateTime;

import com.portal.domain.course.DepartmentDto;

import lombok.Data;

@Data
public class ProfessorDto {
	private int professorNumber;
	private String name;
	private String contact;
	private String email;
	private String homepage;
	private String firstResidentId;
	private String lastResidentId;
	private int departmentId;
	private String loginId;
	private String password;
	private LocalDateTime inserted;
	private DepartmentDto department;
}
