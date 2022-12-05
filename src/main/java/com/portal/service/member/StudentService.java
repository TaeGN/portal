package com.portal.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.member.StudentDto;
import com.portal.mapper.member.StudentMapper;

@Service
@Transactional
public class StudentService {
	
	@Autowired
	private StudentMapper studentMapper;

	public int registerStudent(StudentDto student) {
		// TODO Auto-generated method stub
		return studentMapper.insertStudent(student);
	}

	public List<StudentDto> studentList() {
		// TODO Auto-generated method stub
		return studentMapper.selectStudentAll();
	}

	public StudentDto getStudentByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return studentMapper.selectStudentByStudentNumber(studentNumber);
	}

	public StudentDto getStudentByStudentId(String studentId) {
		// TODO Auto-generated method stub
		return studentMapper.selectStudentByStudentId(studentId);
	}

	
	
}
