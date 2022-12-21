package com.portal.controller.course;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseScheduleDto;
import com.portal.domain.course.CourseSignUpDto;
import com.portal.domain.course.CourseSignUpScheduleDto;
import com.portal.domain.course.CourseTimeDto;
import com.portal.domain.member.StudentDto;
import com.portal.service.course.CourseScheduleService;
import com.portal.service.course.CourseService;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.member.StudentService;

@Controller
@RequestMapping("courseSignUp")
public class CourseSignUpController {
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private CourseScheduleService courseScheduleService;
			
	
	@GetMapping("getSignUpSchedule/{studentId}")
	@PreAuthorize("hasAnyAuthority('admin','student')")
	public String signUpSchedule(@PathVariable String studentId, Model model,
			Authentication authentication) {
		if(authentication.getName().equals(studentId)) {
			
		}
		
		List<String> emptyList = new ArrayList<>();
		for(int i = 0; i < 24; i++) {
			emptyList.add(""); 
		}
		Map<String, List<String>> map = new HashMap<>();
		map.put("Monday", emptyList);
		map.put("Tuesday", emptyList);
		map.put("Wednesday", emptyList);
		map.put("Thursday", emptyList);
		map.put("Friday", emptyList);
		map.put("Saturday", emptyList);
		map.put("Sunday", emptyList);
		
		List<CourseScheduleDto> signUpScheduleList = courseSignUpService.getSignUpScheduleByStudentId(studentId);
		for(CourseScheduleDto courseSchedule : signUpScheduleList) {
			String day = courseSchedule.getDay();

			List<String> list = new ArrayList<>(map.get(day));
			for(int i = courseSchedule.getStartTimeId(); i < courseSchedule.getEndTimeId(); i++) {
				list.set(i - 1, courseSchedule.getCourseName());
			}
			System.out.println("list : "+list +" :" + day);
			map.put(day, list);
		}
		
		List<CourseTimeDto> courseTimeList2 = courseScheduleService.getCourseTimeList();
		List<String> courseTimeList = new ArrayList<>();
		for(int i = 0; i < 24; i++) {
			CourseTimeDto courseTime1 = courseTimeList2.get(i);
			CourseTimeDto courseTime2 = courseTimeList2.get(i + 1);
			String time = courseTime1.getTime() + " - " + courseTime2.getTime();
			courseTimeList.add(time);
		}
		map.put("courseTimeList", courseTimeList);
		for(String key : map.keySet()) {
			System.out.println(key + " : " + map.get(key).size());
		}
		
		System.out.println("map : " + map);
		
		List<CourseSignUpScheduleDto> signUpSchedule = new ArrayList<>();
		for(int i = 0; i < 24; i++) {
			CourseSignUpScheduleDto courseSignUpSchedule = new CourseSignUpScheduleDto();
			
			courseSignUpSchedule.setTime(map.get("courseTimeList").get(i));
			courseSignUpSchedule.setMonday(map.get("Monday").get(i));
			courseSignUpSchedule.setTuesday(map.get("Tuesday").get(i));
			courseSignUpSchedule.setWednesday(map.get("Wednesday").get(i));
			courseSignUpSchedule.setThursday(map.get("Thursday").get(i));
			courseSignUpSchedule.setFriday(map.get("Friday").get(i));
			courseSignUpSchedule.setSaturday(map.get("Saturday").get(i));
			courseSignUpSchedule.setSunday(map.get("Sunday").get(i));
			
			System.out.println("courseSignUpSchedule : " + courseSignUpSchedule);
			signUpSchedule.add(courseSignUpSchedule);
		}
		
		System.out.println("signUpSchedule : " + signUpSchedule);
		
		model.addAttribute("signUpSchedule", signUpSchedule);
		return "courseSignUp/signUpSchedule";
	}
	
	@PostMapping("register")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('student')")
	public Map<String, Object> register(@RequestBody Map<String, String> req) {
		Map<String, Object> map = new HashMap<>();
		System.out.println(req);
		int classCode = Integer.parseInt(req.get("classCode"));
		String studentId = req.get("studentId");
		StudentDto student = studentService.getStudentByStudentId(studentId);
		int studentNumber = student.getStudentNumber();
		
		int cnt = courseSignUpService.registerCourseSignUp(studentNumber, classCode);
		String message = "";
		if(cnt == 1) {
			message = "희망수업 등록 완료";
		} else {
			message = "희망수업 등록 실패";
		}
		
		map.put("message", message);
		map.put("studentNumber", studentNumber);
		map.put("classCode", classCode);
		return map;
	}
	
	@DeleteMapping("remove")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('student')")
	public Map<String, Object> remove(@RequestBody Map<String, String> req) {
		Map<String, Object> map = new HashMap<>();
		int classCode = Integer.parseInt(req.get("classCode"));
		String studentId = req.get("studentId");
		StudentDto student = studentService.getStudentByStudentId(studentId);
		int studentNumber = student.getStudentNumber();
		
		int cnt = courseSignUpService.removeCourseSignUp(studentNumber, classCode);
		String message = "";
		if(cnt == 1) {
			message = "희망수업 삭제 완료";
		} else {
			message = "희망수업 삭제 실패";
		}
		
		int desireCredit = courseSignUpService.getCountDesireCreditByStudentNumber(studentNumber);
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(studentNumber);
		
		map.put("signUpCredit", signUpCredit);		
		map.put("desireCredit", desireCredit);		
		map.put("message", message);
		map.put("studentNumber", studentNumber);
		map.put("classCode", classCode);
		
		
		return map;
	}
	
	@PutMapping("signUp")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('student')")
	public Map<String, Object> signUp(@RequestBody Map<String, String> req) {
		Map<String, Object> map = new HashMap<>();
		int classCode = Integer.parseInt(req.get("classCode"));
		String studentId = req.get("studentId");
		StudentDto student = studentService.getStudentByStudentId(studentId);
		int studentNumber = student.getStudentNumber();
		
		String message = courseSignUpService.courseSignUp(studentNumber, classCode);

		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(studentNumber);
		
		
		
		map.put("signUpCredit", signUpCredit);
		map.put("message", message);
		map.put("studentNumber", studentNumber);
		map.put("classCode", classCode);
		return map;
	}
	
	
	@PutMapping("cancelSignUp")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('student')")
	public Map<String, Object> cancelSignUp(@RequestBody Map<String, String> req, 
			Authentication authentication) {
		Map<String, Object> map = new HashMap<>();
		int classCode = Integer.parseInt(req.get("classCode"));
		String studentId = req.get("studentId");
		StudentDto student = studentService.getStudentByStudentId(studentId);
		int studentNumber = student.getStudentNumber();
		
		int cnt = courseSignUpService.cancelCourseSignUp(studentNumber, classCode);
		String message = "";
		if(cnt == 1) {
			message = "수강신청 취소 완료";
		} else {
			message = "수강신청 취소 실패";
		}
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(studentNumber);
		
		map.put("signUpCredit", signUpCredit);
		map.put("message", message);
		map.put("studentNumber", studentNumber);
		map.put("classCode", classCode);
		return map;
	}
	
	
}
