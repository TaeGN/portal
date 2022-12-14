package com.portal.service.course;

import java.util.List;

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
//		
//		int collegeId = department.getCollegeId();
//		CollegeDto college = departmentMapper.selectCollegeById(collegeId);
//		department.setCollege(college);
//		
//		int organizationId = college.getOrganizationId();
//		OrganizationDto organization = departmentMapper.selectOrganizationById(organizationId);
//		department.getCollege().setOrganization(organization);
		
		return department;
	}

	public int getDepartmentIdByName(String departmentName) {
		// TODO Auto-generated method stub
		DepartmentDto department = departmentMapper.selectDepartmentIdByName(departmentName);
		return department.getId();
		
	}

	public List<DepartmentDto> getDepartmentAll() {
		// TODO Auto-generated method stub
		return departmentMapper.selectDepartmentAll();
	}

	public List<OrganizationDto> getOrganizationAll() {
		// TODO Auto-generated method stub
		return departmentMapper.selectOrganizationAll();
	}

	public List<CollegeDto> getCollegeByOrganizationId(int organizationId) {
		// TODO Auto-generated method stub
		return departmentMapper.selectCollegeByOrganizationId(organizationId);
	}

	public List<DepartmentDto> getDepartmentByCollegeId(int collegeId) {
		// TODO Auto-generated method stub
		return departmentMapper.selectDepartmentByCollegeId(collegeId);
	}

}
