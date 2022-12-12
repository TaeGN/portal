package com.portal.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.member.ProfessorDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.member.ProfessorMapper;

@Service
@Transactional
public class ProfessorService {
	
	@Autowired
	private ProfessorMapper professorMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	public List<ProfessorDto> getProfessorAll() {
		// TODO Auto-generated method stub
		return professorMapper.selectProfessorAll();
	}

	public int registerProfessor(ProfessorDto professor) {
		// loginId == null이면 professorNumber로 설정
		if(professor.getLoginId() == null || professor.getLoginId().length() == 0) {
			professor.setLoginId("" + professor.getProfessorNumber());
		}
		
		// password == null이면 주민번호 앞자리로 설정
		if(professor.getPassword() == null || professor.getPassword().length() == 0) {
			professor.setPassword(professor.getFirstResidentId());
		}
		
		// 비밀번호 암호화해서 db에 저장
		professor.setPassword(passwordEncoder.encode(professor.getPassword()));
		return professorMapper.insertProfessor(professor);
	}
	
	public int setProfessorNumberByDepartmentId(int departmentId) {
		int minProfessorNumber = 202200000 + (departmentId - 1) * 100;
		int maxProfessorNumber = minProfessorNumber + 999;
		ProfessorDto professor = professorMapper.selectMinProfessorNumberByDepartmentId(minProfessorNumber);
		int professorNumber = 0;
		if(professor != null && professor.getProfessorNumber() < maxProfessorNumber) {
			professorNumber = professor.getProfessorNumber() + 1;
		} else {
			professorNumber = minProfessorNumber;
		}
		return professorNumber;
		
	}
}
