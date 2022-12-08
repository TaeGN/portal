package com.portal.domain.course;

import java.util.List;

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
	private List<Integer> startTimeId;
	private List<Integer> endTimeId;
	private List<String> day;
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
	private List<CourseScheduleDto> courseSchedule;
}
