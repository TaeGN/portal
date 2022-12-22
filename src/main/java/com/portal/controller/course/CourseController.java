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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.classroom.ClassroomDto;
import com.portal.domain.classroom.RoomDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseInfoDto;
import com.portal.domain.course.CourseTimeDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;
import com.portal.domain.member.ProfessorDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.service.admin.AdminLogService;
import com.portal.service.course.ClassroomService;
import com.portal.service.course.CourseInfoService;
import com.portal.service.course.CourseScheduleService;
import com.portal.service.course.CourseService;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.course.DepartmentService;
import com.portal.service.member.ProfessorService;
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
	private ProfessorService professorService;
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@Autowired
	private CourseScheduleService courseScheduleService;
	
	@Autowired
	private AdminLogService adminLogService;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@GetMapping("getSyllabus/{classCode}")
	public String getSyllabus(@PathVariable int classCode, RedirectAttributes rttr) {
		CourseDto syllabus = courseService.getCourseByClassCode(classCode);
		
		rttr.addFlashAttribute("syllabus", syllabus);
		return "redirect:/course/syllabus";
	}
	
	@GetMapping("syllabus")
	public void syllabus(HttpServletRequest req, Model model) {
		CourseDto syllabus = (CourseDto)RequestContextUtils.getInputFlashMap(req).get("syllabus");
		System.out.println(syllabus);
		model.addAttribute("syllabus", syllabus);
	}
	
	
	@PostMapping("getClassroom")
	@ResponseBody
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public List<RoomDto> getRooms(@RequestBody Map<String, String> req) {
		String[] building = req.get("building").split(":");
		String campus = building[0];
		int buildingId = Integer.parseInt(building[1]);
		
		List<RoomDto> roomList = classroomService.getClassroomByBuildingId(buildingId, campus);
		return roomList;
	}
	
	@GetMapping("list")
	@PreAuthorize("@adminSecurity.checkAdminAuthority(authentication)")
	public void list(Model model, Authentication authentication,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		List<CourseDto> courseList = courseService.getCourseAll(startNum, count);
		int totalNum = courseService.getCountCourseAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		model.addAttribute("courseList", courseList);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
	}
	
	@GetMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void register(Model model) {
		
		List<BuildingDto> buildingList = classroomService.getBuildingAll();
		List<RoomDto> roomListByFirstBuilding = classroomService.getClassroomByBuildingId(buildingList.get(0).getId(), buildingList.get(0).getCampus());
		List<DepartmentDto> departmentList = departmentService.getDepartmentAll();
		List<CourseTimeDto> courseTimeList = courseService.getCourseTimeAll();
		List<CourseInfoDto> courseInfoList = courseInfoService.getCourseInfoAll(); 
		List<ProfessorDto> professorList = professorService.getProfessorAll();
		
		model.addAttribute("buildingList", buildingList);
		model.addAttribute("roomListByFirstBuilding", roomListByFirstBuilding);
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("courseTimeList", courseTimeList);
		model.addAttribute("courseInfoList", courseInfoList);
		model.addAttribute("professorList", professorList);
	}
	
	@PostMapping("register")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public String register(CourseDto course, Authentication authentication) {
		CourseDto lastCourse = courseService.getLastCourse();
		int classCode = lastCourse.getClassCode() + 1;
		course.setClassCode(classCode);
		
		// course 등록
		int cnt = courseService.registerCourse(course);
		
		String messageLog = "";
		
		
		// 수업시간 등록
		for(int i = 0; i < course.getDay().size(); i++) {
			String day = course.getDay().get(i);
			int startTimeId = course.getStartTimeId().get(i);
			int endTimeId = course.getEndTimeId().get(i);
			courseScheduleService.registerScheduleByClassCode(classCode, day, startTimeId, endTimeId);
		}
		
		
		if(cnt == 1) {
			messageLog = "수업번호 " + classCode + " 강의 추가 성공";
		}	else {
			messageLog = "강의 추가 실패";
		}
		
		String category = "register";
		AdminMemberDto admin = adminMapper.selectAdminMemberByUserName(authentication.getName());
		int cnt2 = adminLogService.registerCourseLogById(admin.getId(), messageLog, category);
		
		return "redirect:/course/list";
	}
	
	@GetMapping("get")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void get(int classCode, Model model) {
		CourseDto course = courseService.getCourseByClassCode(classCode);
		List<CourseTimeDto> courseTimeList = courseService.getCourseTimeAll();
		model.addAttribute("courseTimeList", courseTimeList);
		model.addAttribute("course", course);
	}
	
	
	
	@GetMapping("modify/{classCode}")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	@ResponseBody
	public Map<String, Object> modify(@PathVariable int classCode) {
		Map<String, Object> map = new HashMap<>();
		CourseDto course = courseService.getCourseByClassCode(classCode);
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		List<BuildingDto> buildingList = classroomService.getBuildingAll();
		List<ProfessorDto> professorList = professorService.getProfessorAll();
		List<CourseInfoDto> courseInfoList = courseInfoService.getCourseInfoAll();
		List<RoomDto> roomListByFirstBuilding = classroomService.getClassroomByBuildingId(buildingList.get(0).getId(), buildingList.get(0).getCampus());
		
		map.put("roomListByFirstBuilding", roomListByFirstBuilding);
		map.put("professorList", professorList);
		map.put("courseInfoList", courseInfoList);
		map.put("buildingList", buildingList);
		map.put("course", course);
		map.put("organizationList", organizationList);
		return map;
	}
	
	@PostMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public String modify(CourseDto course, Authentication authentication) {
		
		// course 수정
		int cnt = courseService.modifyCourse(course, authentication.getName());

		
		return "redirect:/course/list";
	}
	
/*	@GetMapping("modify")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public void modify(int classCode, Model model) {
		CourseDto course = courseService.getCourseByClassCode(classCode);
		model.addAttribute("course", course);
	}*/
	
	@GetMapping("getEndTime/{startTimeId}")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	@ResponseBody
	public Map<String, Object> getEndTime(@PathVariable int startTimeId) {
		List<CourseTimeDto> courseTimeList = courseService.getCourseTimeByStartTimeId(startTimeId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("courseTimeList", courseTimeList);
		
		return map;
	}
	
	@PostMapping("remove")
	@PreAuthorize("hasAnyAuthority('admin','course')")
	public String remove(int classCode, Authentication authentication) {
		
		// course 수정
		int cnt = courseService.removeCourseByClassCode(classCode, authentication.getName());

		
		return "redirect:/course/list";
	}
}
