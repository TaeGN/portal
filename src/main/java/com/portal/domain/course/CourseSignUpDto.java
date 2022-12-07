package com.portal.domain.course;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CourseSignUpDto {
	private int studentNumber;
	private int classCode;
	private LocalDateTime inserted;
	private String signUp;
	private LocalDateTime signUpInserted;
}
