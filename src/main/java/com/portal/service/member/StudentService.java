package com.portal.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.member.StudentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.mapper.courseSignUp.CourseSignUpMapper;
import com.portal.mapper.member.StudentMapper;

@Service
@Transactional
public class StudentService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private CourseSignUpMapper courseSignUpMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;	

	public int registerStudent(StudentDto student) {
		
		// 비밀번호 암호화
		if(student.getPassword() == null || student.getPassword().equals("")) {
			student.setPassword(student.getFirstResidentId());
		}
		student.setPassword(passwordEncoder.encode(student.getPassword()));
		
		// 권한 부여
//		adminMapper.insertAdminAuthority(student.getStudentNumber(), "student");
		
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

	public int setStudentNumberByDepartmentId(int departmentId) {
		int minStudentNumber = 2022000000 + (departmentId - 1) * 1000;
		int maxStudentNumber = minStudentNumber + 999;
		StudentDto student = studentMapper.selectMinStudentNumberByDepartmentId(minStudentNumber);
		int studentNumber = 0;
		if(student != null && student.getStudentNumber() < maxStudentNumber) {
			studentNumber = student.getStudentNumber() + 1;
		} else {
			studentNumber = minStudentNumber;
		}
		return studentNumber;
		
	}

	public int modifyStudent(StudentDto student) {
		// 비밀번호 암호화
		if(student.getPassword() == null || student.getPassword().equals("")) {
			student.setPassword(student.getFirstResidentId());
		}
		student.setPassword(passwordEncoder.encode(student.getPassword()));
		
		// 
		
		return studentMapper.updateStudent(student);
	}

	public int removeStudent(int studentNumber) {
		// 수강신청 테이블 정보 삭제
		courseSignUpMapper.deleteSignUpByStudentNumber(studentNumber);
		
		return studentMapper.deleteStudent(studentNumber);
	}

	
	
}
