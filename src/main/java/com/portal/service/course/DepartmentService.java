package com.portal.service.course;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.course.CollegeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;
import com.portal.mapper.course.DepartmentMapper;

@Service
@Transactional
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;

	public DepartmentDto getDepartmentById(int departmentId) {
		DepartmentDto department = departmentMapper.selectDepartmentById(departmentId);
		
		int collegeId = department.getCollegeId();
		CollegeDto college = departmentMapper.selectCollegeById(collegeId);
		department.setCollege(college);
		
		int organizationId = college.getOrganizationId();
		OrganizationDto organization = departmentMapper.selectOrganizationById(organizationId);
		department.setOrganization(organization);
		
		return department;
	}

	public int getDepartmentIdByName(String departmentName) {
		// TODO Auto-generated method stub
		DepartmentDto department = departmentMapper.selectDepartmentIdByName(departmentName);
		return department.getId();
		
	}

}
