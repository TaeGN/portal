package com.portal.mapper.course;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.course.CollegeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;

@Mapper
public interface DepartmentMapper {

	DepartmentDto selectDepartmentById(int id);

	CollegeDto selectCollegeById(int id);

	OrganizationDto selectOrganizationById(int id);

	DepartmentDto selectDepartmentIdByName(String departmentName);

	List<DepartmentDto> selectDepartmentAll();

	List<OrganizationDto> selectOrganizationAll();

	List<CollegeDto> selectCollegeByOrganizationId(int organizationId);

	List<DepartmentDto> selectDepartmentByCollegeId(int collegeId);
	
	
}
