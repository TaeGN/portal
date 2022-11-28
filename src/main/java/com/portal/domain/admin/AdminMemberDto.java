package com.portal.domain.admin;

import java.util.List;

import lombok.Data;

@Data
public class AdminMemberDto {
	private int id;
	private String adminMemberId;
	private String password;
	private List<String> authority;
}
