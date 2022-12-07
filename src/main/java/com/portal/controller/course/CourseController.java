package com.portal.controller.course;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.classroom.ClassroomDto;
import com.portal.domain.classroom.RoomDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseInfoDto;
import com.portal.domain.course.CourseTimeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.SyllabusDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.course.ClassroomService;
import com.portal.service.course.CourseInfoService;
import com.portal.service.course.CourseService;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.course.DepartmentService;
import com.portal.service.member.StudentService;

@Controller
@RequestMapping("course")
public class CourseController {
	
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private ClassroomService classroomService;
	
	@Autowired
	private CourseInfoService courseInfoService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@GetMapping("getSyllabus/{classCode}")
	public void getSyllabus(@PathVariable int classCode, Model model) {
		SyllabusDto syllabus = null;
	}
	
	
	@PostMapping("getClassroom")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public List<RoomDto> getRooms(@RequestBody Map<String, String> req) {
//		Map<String, Object> map = new HashMap<>();
		String[] building = req.get("building").split(":");
		String campus = building[0];
		int buildingId = Integer.parseInt(building[1]);
		
		System.out.println(building);
		List<RoomDto> roomList = classroomService.getClassroomByBuildingId(buildingId, campus);
		System.out.println(roomList);
		return roomList;
	}
	
	@GetMapping("list")
	@PreAuthorize("@adminSecurity.checkAdminAuthority(authentication)")
	public void list(Model model, Authentication authentication) {
		List<CourseDto> courseList = courseService.getCourseAll();
		System.out.println(courseList);
		// 희망수업 내역
//		List<Integer> classCodeList = courseSignUpService.getClassCodeByUserId(authentication.getName());
//		List<Object[]> signUpList = new ArrayList<>();
//		Object[] signUp = new Object[2];
//		for(CourseDto course : courseList) {
//			signUp[0] = course;
//			if(classCodeList.contains(course.getClassCode())) {
//				signUp[1] = true;
//			} else {
//				signUp[1] = false;
//			}
//			signUpList.add(signUp);
//		}
//		System.out.println(signUpList);
		model.addAttribute("courseList", courseList);
//		model.addAttribute("signUpList", signUpList);
	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void register(Model model) {
		
//		List<ClassroomDto> classroomList = classroomService.getClassroom();
		List<BuildingDto> buildingList = classroomService.getBuildingAll();
		List<RoomDto> roomListByFirstBuilding = classroomService.getClassroomByBuildingId(buildingList.get(0).getId(), buildingList.get(0).getCampus());
		List<DepartmentDto> departmentList = departmentService.getDepartmentAll();
		List<CourseTimeDto> courseTimeList = courseService.getCourseTimeAll();
		List<CourseInfoDto> courseInfoList = courseInfoService.getCourseInfoAll(); 
		
//		model.addAttribute("classroomList", classroomList);
		model.addAttribute("buildingList", buildingList);
		model.addAttribute("roomListByFirstBuilding", roomListByFirstBuilding);
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("courseTimeList", courseTimeList);
		model.addAttribute("courseInfoList", courseInfoList);
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public String register(CourseDto course, Authentication authentication) {
		int cnt = courseService.registerCourse(course);
		
		String messageLog = "";
		
		
		if(cnt == 1) {
			CourseDto newCourse = courseService.getLastCourse();
			int classCode = newCourse.getClassCode();
			messageLog = "수업번호 " + classCode + " 강의 추가 성공";
		}	else {
			messageLog = "강의 추가 실패";
		}
		
		String category = "register";
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		int cnt2 = adminLogService.registerCourseLogById(admin.getId(), messageLog, category);
		
		return "redirect:/course/list";
	}
	
	@GetMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void modify() {
		
	}
}
