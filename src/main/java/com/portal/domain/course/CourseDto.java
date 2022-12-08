package com.portal.domain.course;

import com.portal.domain.member.ProfessorDto;

import lombok.Data;

@Data
public class CourseDto {
	private String grade;
	private int classCode;
	private String classNumber;
	private int maxPersonnel;
	private int departmentId;
	private int year;
	private String semester;
	private int startTimeId;
	private String startTime;
	private int endTimeId;
	private String endTime;
	private String classroom;
	private String building;
	private String room;
	private String desire;
	private String signUp;
	private int countDesire;
	private int countSignUp;
	private int professorNumber;
	private DepartmentDto department;
	private CourseInfoDto courseInfo;
	private ProfessorDto professor;
}
