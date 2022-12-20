package com.portal.mapper.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.member.StudentDto;

@Mapper
public interface StudentMapper {
	
	StudentDto selectStudentById(String id);

	int insertStudent(StudentDto student);

	List<StudentDto> selectStudentAll();

	StudentDto selectStudentByStudentNumber(int studentNumber);

	StudentDto selectStudentByStudentId(String studentId);

	StudentDto selectMinStudentNumberByDepartmentId(int minStudentNumber);

	int updateStudent(StudentDto student);

	int deleteStudent(int studentNumber);

	List<StudentDto> selectStudentByPageInfo(int startNum, int count);

	int selectCountStudentAll();
}
