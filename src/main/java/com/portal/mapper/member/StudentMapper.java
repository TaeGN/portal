package com.portal.mapper.member;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.member.StudentDto;

@Mapper
public interface StudentMapper {
	
	StudentDto selectStudentById(String id);
}
