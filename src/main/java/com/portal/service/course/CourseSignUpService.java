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
	
	// signUp true??? ??????
	public String courseSignUp(int studentNumber, int classCode) {
		String message = "";
		CourseDto newCourse = courseMapper.selectCourseByClassCode(classCode);
		
		// ?????? ????????? ????????? ??? ??????
		int countSignUpCredit = courseSignUpMapper.selectCountSignUpCredit(studentNumber);
		
		// ?????? ????????? ????????? ??????
		int newSignUpCredit = newCourse.getCourseInfo().getCredit();
		
		if(countSignUpCredit + newSignUpCredit > 20) {
			return "???????????? ??????(?????? ?????? ?????? ??????)";
		}
		
		// ?????? classCode ????????? ?????? ?????? ?????? ?????? ???
		int countSignUp = courseSignUpMapper.selectCountSignUpByClassCode(classCode);
		
		// ?????? classCode ????????? ?????? ??????
		int maxPersonnel = newCourse.getMaxPersonnel();
		
		int cnt = 0;
		
		// ?????? ?????? ?????? ?????? ?????? ?????? ???????????? ?????? ??? ??????
		if(countSignUp < maxPersonnel) {
			CourseSignUpDto courseSignUp = courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
			
			// signUp??? false????????? ??????
			if(courseSignUp.getSignUp().equals("false")) {
				
				
				// ????????? ????????? ????????????
				List<CourseScheduleDto> newCourseScheduleList = courseScheduleMapper.selectCourseScheduleByClassCode(classCode);
				
				// ?????? ????????? ???????????? ????????????
				List<CourseScheduleDto> oldCourseScheduleList = courseScheduleMapper.selectCourseScheduleByStudentSignUp(studentNumber);
				System.out.println(newCourseScheduleList);
				System.out.println(oldCourseScheduleList);
				// ???????????? ?????? ??????
				boolean duplicationCheck = DuplicationCheck(newCourseScheduleList, oldCourseScheduleList);
				System.out.println(duplicationCheck);
				if(duplicationCheck) {
					cnt = courseSignUpMapper.updateCourseSignUpTrue(studentNumber, classCode);
					if(cnt == 1) {
						message = "???????????? ??????";
					} else {
						message = "???????????? ??????";
					}
				} else {
					message = "???????????? ??????(?????? ?????? ??????)";
				}
			} else {
				message = "???????????? ??????(?????? ?????? ??????)";
			}
			
		} else {
			message = "???????????? ??????(?????? ?????? ??????)";
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

	// signUp false??? ??????
	public int cancelCourseSignUp(int studentNumber, int classCode) {
		CourseSignUpDto courseSignUp = courseSignUpMapper.selectCourseSignUpById(studentNumber, classCode);
		int cnt = 0;
		System.out.println(courseSignUp);
		// signUp??? true????????? ??????
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
