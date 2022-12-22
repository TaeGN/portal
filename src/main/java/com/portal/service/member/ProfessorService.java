package com.portal.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.member.ProfessorDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.member.ProfessorMapper;
import com.portal.service.course.CourseService;

@Service
@Transactional
public class ProfessorService {
	
	@Autowired
	private ProfessorMapper professorMapper;
	
	@Autowired
	private CourseService courseService;
	
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
		int maxProfessorNumber = minProfessorNumber + 99;
		ProfessorDto professor = professorMapper.selectMinProfessorNumberByDepartmentId(minProfessorNumber, maxProfessorNumber);
		int professorNumber = 0;
		if(professor != null && professor.getProfessorNumber() < maxProfessorNumber) {
			professorNumber = professor.getProfessorNumber() + 1;
		} else {
			professorNumber = minProfessorNumber;
		}
		return professorNumber;
		
	}

	public ProfessorDto getProfessorByProfessorNumber(int professorNumber) {
		// TODO Auto-generated method stub
		return professorMapper.selectProfessorByProfessorNumber(professorNumber);
	}

	public int modifyProfessor(ProfessorDto professor) {
		
		// 비밀번호 암호화 (변경될 비밀번호 없으면 기존 비밀번호 그대로)
		if(professor.getPassword().isEmpty() || professor.getPassword().equals("")) {
			ProfessorDto pro = professorMapper.selectProfessorByProfessorNumber(professor.getProfessorNumber());
			
			String pw = pro.getPassword();
			professor.setPassword(pw);
		} else {
			professor.setPassword(passwordEncoder.encode(professor.getPassword()));
		}
		
		// 
		
		return professorMapper.updateProfessor(professor);
	}

	public int removeProfessor(int professorNumber, String username) {
		// professorNumber에 해당하는 Course 삭제 (CourseSchedule, CourseSignUp도 같이 삭제)
		int cnt = courseService.removeCourseByProfessorNumber(professorNumber, username);
		
		return professorMapper.deleteProfessorByProfessorNumber(professorNumber);
	}

	public List<ProfessorDto> getProfessorByPageInfo(int startNum, int count) {
		// TODO Auto-generated method stub
		return professorMapper.selectProfessorByPageInfo(startNum, count);
	}

	public int getCountProfessorAll() {
		// TODO Auto-generated method stub
		return professorMapper.selectCountProfessorAll();
	}
}
