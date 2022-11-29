package com.portal.domain.admin;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AdminLogDto {
	private int id;
	private String adminMemberId;
	private String log;
	private LocalDateTime inserted;
	private String menu;
	private String category;
}
