package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseScheduleDto;
import com.portal.domain.course.CourseSignUpDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.course.CourseMapper;
import com.portal.mapper.courseSchedule.CourseScheduleMapper;
import com.portal.mapper.courseSignUp.CourseSignUpMapper;
import com.portal.service.member.StudentService;

@Service
@Transactional
public class CourseSignUpService {
	
	@Autowired
	private CourseSignUpMapper courseSignUpMapper;
	
	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private CourseScheduleMapper courseScheduleMapper;
	
	@Autowired
	private StudentService studentService;
	

	public int registerCourseSignUp(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.insertCourseSignUp(studentNumber, classCode);
	}

	public int removeCourseSignUp(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.deleteCourseSignUp(studentNumber, classCode);
	}
	
	public CourseSignUpDto getCourseSignUpById(int studentNumber, int classCode) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
	}

	public List<Integer> getClassCodeByUserId(String userId) {
		StudentDto student = studentService.getStudentByStudentId(userId);
		return courseSignUpMapper.selectClassCodeByStudentNumber(student.getStudentNumber());
	}

	public List<CourseDto> getCourseByStudentNumber(int studentNumber, int startNum, int count) {
		return courseSignUpMapper.selectCourseByStudentNumber(studentNumber, startNum, count);
	}
	
	public List<CourseDto> getSignUpAllByStudentNumber(int studentNumber, int startNum, int count) {
		return courseSignUpMapper.selectSignUpAllByStudentNumber(studentNumber, startNum, count);
	}
	
	// signUp true로 변경
	public String courseSignUp(int studentNumber, int classCode) {
		String message = "";
		CourseDto newCourse = courseMapper.selectCourseByClassCode(classCode);
		
		// 현재 수강한 과목의 총 학점
		int countSignUpCredit = courseSignUpMapper.selectCountSignUpCredit(studentNumber);
		
		// 새로 수강할 과목의 학점
		int newSignUpCredit = newCourse.getCourseInfo().getCredit();
		
		if(countSignUpCredit + newSignUpCredit > 20) {
			return "수강신청 실패(신청 가능 학점 초과)";
		}
		
		// 해당 classCode 수업의 현재 수강 신청 인원 수
		int countSignUp = courseSignUpMapper.selectCountSignUpByClassCode(classCode);
		
		// 해당 classCode 수업의 수강 정원
		int maxPersonnel = newCourse.getMaxPersonnel();
		
		int cnt = 0;
		
		// 현재 수강 신청 인원 수가 수강 정원보다 작을 때 실행
		if(countSignUp < maxPersonnel) {
			CourseSignUpDto courseSignUp = courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
			
			// signUp이 false일때만 실행
			if(courseSignUp.getSignUp().equals("false")) {
				
				
				// 신청할 수업의 수업시간
				List<CourseScheduleDto> newCourseScheduleList = courseScheduleMapper.selectCourseScheduleByClassCode(classCode);
				
				// 이미 신청한 수업들의 수업시간
				List<CourseScheduleDto> oldCourseScheduleList = courseScheduleMapper.selectCourseScheduleByStudentSignUp(studentNumber);
				System.out.println(newCourseScheduleList);
				System.out.println(oldCourseScheduleList);
				// 수업시간 중복 확인
				boolean duplicationCheck = DuplicationCheck(newCourseScheduleList, oldCourseScheduleList);
				System.out.println(duplicationCheck);
				if(duplicationCheck) {
					cnt = courseSignUpMapper.updateCourseSignUpTrue(studentNumber, classCode);
					if(cnt == 1) {
						message = "수강신청 완료";
					} else {
						message = "수강신청 실패";
					}
				} else {
					message = "수강신청 실패(수업 시간 중복)";
				}
			} else {
				message = "수강신청 실패(이미 신청 완료)";
			}
			
		} else {
			message = "수강신청 실패(수강 정원 초과)";
		}
		
		return message;
	}
	
	private boolean DuplicationCheck(List<CourseScheduleDto> newCourseScheduleList,
			List<CourseScheduleDto> oldCourseScheduleList) {
		
		for(CourseScheduleDto newCourseSchedule : newCourseScheduleList) {			
			for(CourseScheduleDto oldCourseSchedule : oldCourseScheduleList) {
				if(newCourseSchedule.getDay().equals(oldCourseSchedule.getDay())) {
					int newStart = newCourseSchedule.getStartTimeId();
					int newEnd = newCourseSchedule.getEndTimeId();
					int oldStart = oldCourseSchedule.getStartTimeId();
					int oldEnd = oldCourseSchedule.getEndTimeId();
					if(newStart == oldStart || newEnd == oldEnd) {
						return false;
					} else if(newStart < oldStart) {
						if(newEnd > oldStart) {
							return false;
						}
					} else {
						if(newStart < oldEnd) {
							return false;
						}
					}
				}
			}
		}
		return true;
	}

	// signUp false로 변경
	public int cancelCourseSignUp(int studentNumber, int classCode) {
		CourseSignUpDto courseSignUp = courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
		int cnt = 0;
		System.out.println(courseSignUp);
		// signUp이 true일때만 실행
		if(courseSignUp.getSignUp().equals("true")) {
			cnt = courseSignUpMapper.updateCourseSignUpFalse(studentNumber, classCode);
		}
		return cnt;
	}

	public int getCountDesireByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCountDesireByStudentNumber(studentNumber);
	}

	public int getCountSignUpByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCountSignUpByStudentNumber(studentNumber);
	}

	public List<CourseScheduleDto> getSignUpScheduleByStudentId(String studentId) {
		int studentNumber  = studentService.getStudentByStudentId(studentId).getStudentNumber();
		
		return courseSignUpMapper.selectSignUpScheduleByStudentNumber(studentNumber);
	}

	public int getCountSignUpCreditByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCountSignUpCredit(studentNumber);
	}

	public int getCountDesireCreditByStudentNumber(int studentNumber) {
		// TODO Auto-generated method stub
		return courseSignUpMapper.selectCountDesireCredit(studentNumber);
	}

	
}
