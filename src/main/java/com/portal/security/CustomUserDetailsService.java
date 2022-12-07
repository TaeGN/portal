package com.portal.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.portal.domain.admin.AdminMemberDto;
import com.portal.domain.member.ProfessorDto;
import com.portal.domain.member.StudentDto;
import com.portal.mapper.admin.AdminMapper;
import com.portal.mapper.member.ProfessorMapper;
import com.portal.mapper.member.StudentMapper;

@Component
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private ProfessorMapper professorMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		List<SimpleGrantedAuthority> authorityList = new ArrayList<>();
		String userId = "";
		String password = ""; 
		
		AdminMemberDto adminMember = adminMapper.selectAdminMemberByUserName(username);
		StudentDto student = studentMapper.selectStudentById(username);
		ProfessorDto professor = professorMapper.selectProfessorById(username);
		System.out.println(adminMember);
		System.out.println(student);
		
		// 관리자 로그인의 경우
		if(adminMember != null && adminMember.getId() < 100000000) {
			userId = adminMember.getAdminMemberId();
			password = adminMember.getPassword();
			
			if(adminMember.getAuthorityList() != null) {
				for(String authority : adminMember.getAuthorityList()) {
					authorityList.add(new SimpleGrantedAuthority(authority));
				}
			}
		} else if(professor != null && professor.getLoginId() < 1000000000) {
			 // 학생 로그인의 경우
			userId = professor.getLoginId();
			password = professor.getPassword();
			authorityList.add(new SimpleGrantedAuthority("professor"));

		} else if(student != null) {
			 // 학생 로그인의 경우
			userId = student.getId();
			password = student.getPassword();
			authorityList.add(new SimpleGrantedAuthority("student"));
//			if(student.getAuth() != null) {
//				for(String auth : student.getAuth()) {
//					authorityList.add(new SimpleGrantedAuthority(auth));
//				}
//			}

		} else {
			return null;
		}
		// 세번째 칸 = 권한
		User user = new User(userId, password, authorityList);
		System.out.println(user);
		return user;
	}

}





