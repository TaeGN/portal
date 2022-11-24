package com.portal.domain.sugang;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class InfoDto {
	private int id;
	private String campus;
	private String title;
	private String text;
	private String writer;
	
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime inserted;
}
