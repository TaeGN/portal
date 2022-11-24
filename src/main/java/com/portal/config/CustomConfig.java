package com.portal.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@MapperScan("com.portal.mapper")
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class CustomConfig {
	
	

	@Bean
	public PasswordEncoder passwordEncoder() {
		
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		// defaultSuccessUrl 설정 하지 않으면, 로그인 완료 후 직전 요청으로 redirect
		http.formLogin().loginPage("/student/login").defaultSuccessUrl("/port/home", true);
		http.logout().logoutUrl("/student/logout");
		http.rememberMe();
		http.csrf().disable();
		
		return http.build();
	}
}
