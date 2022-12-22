package com.portal.domain.admin;

import java.util.List;

import com.portal.domain.member.FileDto;

import lombok.Data;

@Data
public class AdminMemberDto {
	private int id;
	private String name;
	private String adminMemberId;
	private String password;
	private String authority;
	private List<String> authorityList;
	private List<FileDto> fileList;
}
