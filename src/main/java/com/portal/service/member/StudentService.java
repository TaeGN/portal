package com.portal.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.mapper.member.StudentMapper;

@Service
@Transactional
public class StudentService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	
}
