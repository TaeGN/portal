package com.portal.controller.sugang;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
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

import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.course.CollegeDto;
import com.portal.domain.course.CourseDto;
import com.portal.domain.course.CourseScheduleDto;
import com.portal.domain.course.DepartmentDto;
import com.portal.domain.course.OrganizationDto;
import com.portal.domain.member.StudentDto;
import com.portal.domain.sugang.SignUpNoticeDto;
import com.portal.domain.sugang.SearchDto;
import com.portal.service.course.ClassroomService;
import com.portal.service.course.CourseSignUpService;
import com.portal.service.course.DepartmentService;
import com.portal.service.member.ProfessorService;
import com.portal.service.member.StudentService;
import com.portal.service.sugang.SugangService;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
@RequestMapping("sugang")
public class SugangController {
	
	@Autowired
	private SugangService sugangService;
	
	@Autowired
	private CourseSignUpService courseSignUpService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private ClassroomService classroomService;
	
	@Autowired
	private ProfessorService professorService;
	
	@GetMapping("login")
	public void login() {
		
	}
	
	// 로그인 후 권한에 따른 페이지 이동
	@GetMapping("success")
	@PreAuthorize("isAuthenticated()")
	public String success(Authentication authentication) {
		String url = "";
		if(authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("student"))) {
			url = "/sugang/list";
		} else if(authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("professor"))) {
			url = "/sugang/list";
		} else {
			url = "/admin/board";
		}
		
		return "redirect:" + url;
	}
	
	@GetMapping("signUpNotice")
	public void info(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			Authentication authentication) {
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		List<SignUpNoticeDto> signUpNoticeList = sugangService.getSignUpNoticeListByPage(startNum, count);
		int totalNum = sugangService.getCountSignUpNoticeAll();
		int maxPage = (totalNum - 1) / count + 1;
		
		StudentDto student = studentService.getStudentByStudentId(authentication.getName());
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(student.getStudentNumber());
		
		model.addAttribute("signUpCredit", signUpCredit);	
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
		model.addAttribute("signUpNoticeList", signUpNoticeList);
	}
	
	@GetMapping("signUpNoticeText")
	public void signUpNoticeText(int id, Model model, Authentication authentication) {
		String signUpNoticeText = sugangService.getSignUpNoticeText(id);
		StudentDto student = studentService.getStudentByStudentId(authentication.getName());
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(student.getStudentNumber());
		
		model.addAttribute("signUpCredit", signUpCredit);			
		model.addAttribute("signUpNoticeText", signUpNoticeText);
	}		

	// 수강편람
	@GetMapping("list")
	public void list(SearchDto search, Model model, Authentication authentication,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		int count = 10;
		int startNum = (page - 1) * count; 
		search.setStartNum(startNum);
		search.setCount(count);
		
		if(search.getBuilding() != null && search.getBuilding().size() == 2) {
			search.setClassroom("%" + search.getBuilding().get(0) + " " + search.getBuilding().get(1) + "%");
		}
		
		if(search.getCourseName() != null && !search.getCourseName().equals("")) {
			search.setCourseName("%" + search.getCourseName() + "%");
		}
		
		if(search.getProfessorName() != null && !search.getProfessorName().equals("")) {
			search.setProfessorName("%" + search.getProfessorName() + "%");
		}
		
		List<CourseDto> courseList = new ArrayList<>();
		StudentDto student = new StudentDto();
		
		if(authentication.getName() != null) {
			student = studentService.getStudentByStudentId(authentication.getName());
			search.setStudentNumber(student.getStudentNumber());
			// 로그인 상태
			courseList = sugangService.getSearchCourseListByStudentNumber(search); 
		} else {
			// 비로그인 상태
			courseList = sugangService.getSearchCourseList(search); 
		}
		
		
		int totalNum = sugangService.getTotalNumBySearchCourseList(search);
		int maxPage = (totalNum - 1) / count + 1;
		
		List<OrganizationDto> organizationList = departmentService.getOrganizationAll(); 
		List<BuildingDto> buildingList = classroomService.getBuildingAll();
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(student.getStudentNumber());
		
		model.addAttribute("signUpCredit", signUpCredit);		
		model.addAttribute("courseList", courseList);
		model.addAttribute("buildingList", buildingList);
		model.addAttribute("organizationList", organizationList);
		model.addAttribute("search", search);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
	}
	
	@PostMapping("getSearchCourse")
	@ResponseBody
	public Map<String, Object> getSearchCourse(@RequestBody Map<String, String> req,
			Authentication authentication) {
		Map<String, Object> map = new HashMap<>(req);
		
		System.out.println(req);
		ObjectMapper mapper = new ObjectMapper();
		SearchDto search = mapper.convertValue(req,SearchDto.class);
		System.out.println(search);
		
		
		int count = 10;
		int startNum = (Integer.parseInt(req.get("page")) - 1) * count; 
		int endNum = startNum + count - 1; 
		search.setStartNum(startNum);
		search.setEndNum(endNum);
		search.setCount(count);
		
			
			String[] buildings = search.getBuildingStr().split(",");
			if(search.getBuildingStr() != null && buildings.length == 2) {
				search.setClassroom("%" + buildings[0] + " " + buildings[1] + "%");
			}
			
			if(search.getCourseName() != null && !search.getCourseName().equals("")) {
				search.setCourseName("%" + search.getCourseName() + "%");
			}
			
			if(search.getProfessorName() != null && !search.getProfessorName().equals("")) {
				search.setProfessorName("%" + search.getProfessorName() + "%");
			}
			
			if(search.getClassNumber() != null && !search.getClassNumber().equals("")) {
				search.setClassNumber("%" + search.getClassNumber() + "%");
			}
			
			List<CourseDto> courseList = new ArrayList<>();
			
			if(authentication.getName() != null) {
				StudentDto student = studentService.getStudentByStudentId(authentication.getName());
				search.setStudentNumber(student.getStudentNumber());
				// 로그인 상태
				courseList = sugangService.getSearchCourseListByStudentNumber(search); 
			} else {
				// 비로그인 상태
				courseList = sugangService.getSearchCourseList(search); 
			}
			
			
			int totalNum = sugangService.getTotalNumBySearchCourseList(search);
			int maxPage = (totalNum - 1) / count + 1;
			
			map.put("courseList", courseList);
			map.put("search", search);
			map.put("maxPage", maxPage);
		
		
		return map;
	}
	
	
	
	// 희망수업 리스트
	@GetMapping("desireList")
	@PreAuthorize("hasAnyAuthority('student')")
	public void desireList(Model model, Authentication authentication,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		StudentDto student = studentService.getStudentByStudentId(authentication.getName());
		int studentNumber = student.getStudentNumber();
		List<CourseDto> desireList = courseSignUpService.getCourseByStudentNumber(studentNumber, startNum, count);
		
		int totalNum = courseSignUpService.getCountDesireByStudentNumber(studentNumber);
		int maxPage = (totalNum - 1) / count + 1;
		
		int desireCredit = courseSignUpService.getCountDesireCreditByStudentNumber(studentNumber);
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(studentNumber);
		
		model.addAttribute("signUpCredit", signUpCredit);
		model.addAttribute("desireCredit", desireCredit);
		model.addAttribute("desireList", desireList);
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);
	}
	
	@PostMapping("getDesireList")
	@PreAuthorize("hasAnyAuthority('student')")
	@ResponseBody
	public Map<String, Object> getSearchCourse(@RequestBody Map<String, String> req) {
		String studentId = req.get("studentId");
		int page = Integer.parseInt(req.get("page"));
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		StudentDto student = studentService.getStudentByStudentId(studentId);
		int studentNumber = student.getStudentNumber();
		List<CourseDto> desireList = courseSignUpService.getCourseByStudentNumber(studentNumber, startNum, count);
		
		int totalNum = courseSignUpService.getCountDesireByStudentNumber(studentNumber);
		int maxPage = (totalNum - 1) / count + 1;
		Map<String, Object> map = new HashMap<>();
		int desireCredit = courseSignUpService.getCountDesireCreditByStudentNumber(studentNumber);
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(studentNumber);

		map.put("signUpCredit", signUpCredit);
		map.put("desireCredit", desireCredit);
		map.put("totalNum", totalNum);
		map.put("desireList", desireList);
		map.put("maxPage", maxPage);
		return map;
	}
	
	@GetMapping("signUpList")
	@PreAuthorize("hasAnyAuthority('student')")
	public void signUpList(Model model, Authentication authentication,
			@RequestParam(name = "page", defaultValue = "1") int page) {
		
		
		int count = 10;
		int startNum = (page - 1) * count; 
		
		StudentDto student = studentService.getStudentByStudentId(authentication.getName());
		int studentNumber = student.getStudentNumber();
		List<CourseDto> signUpList = courseSignUpService.getSignUpAllByStudentNumber(studentNumber, startNum, count);
		
		int totalNum = courseSignUpService.getCountSignUpByStudentNumber(studentNumber);
		int maxPage = (totalNum - 1) / count + 1;
		
		int signUpCredit = courseSignUpService.getCountSignUpCreditByStudentNumber(studentNumber);
		
		model.addAttribute("signUpCredit", signUpCredit);
		model.addAttribute("signUpList", signUpList);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("page", page);		
	}
	
	
	@GetMapping("getCollege/{organizationId}")
	@ResponseBody
	public Map<String, Object> getCollege(@PathVariable int organizationId) {
		Map<String, Object> map = new HashMap<>();
		
		List<CollegeDto> collegeList = departmentService.getCollegeByOrganizationId(organizationId);
		
		map.put("collegeList", collegeList);
		return map;
	}
	
	@GetMapping("getDepartment/{collegeId}")
	@ResponseBody
	public Map<String, Object> getDepartment(@PathVariable int collegeId) {
		Map<String, Object> map = new HashMap<>();
		
		List<DepartmentDto> departmentList = departmentService.getDepartmentByCollegeId(collegeId);
		
		map.put("departmentList", departmentList);
		return map;
	}
	
}
