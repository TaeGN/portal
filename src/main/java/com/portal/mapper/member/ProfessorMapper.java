package com.portal.mapper.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.member.ProfessorDto;

@Mapper
public interface ProfessorMapper {

	List<ProfessorDto> selectProfessorAll();

	int insertProfessor(ProfessorDto professor);

	ProfessorDto selectMinProfessorNumberByDepartmentId(int minProfessorNumber);

	ProfessorDto selectProfessorById(String loginId);

}