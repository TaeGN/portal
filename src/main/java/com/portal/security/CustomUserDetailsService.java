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

import com.portal.domain.member.StudentDto;
import com.portal.mapper.member.StudentMapper;

@Component
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		StudentDto student = studentMapper.selectStudentById(username);
		
		if (student == null) {
			return null;
		}
//		
		List<SimpleGrantedAuthority> authorityList = new ArrayList<>();
//		
//		if(student.getAuth() != null) {
//			for(String auth : student.getAuth()) {
//				authorityList.add(new SimpleGrantedAuthority(auth));
//			}
//		}
		// 세번째 칸 = 권한
		User user = new User(student.getId(), passwordEncoder.encode(student.getPassword()), authorityList);
		return user;
	}

}





