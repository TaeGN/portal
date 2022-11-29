package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.admin.AdminLogDto;
import com.portal.mapper.admin.AdminLogMapper;

@Service
@Transactional
public class AdminLogService {
	
	@Autowired
	private AdminLogMapper adminLogMapper;

	public int registerAdminLog(String adminMemberId, String messageLog) {
		// TODO Auto-generated method stub
		String menu = "adminMember";
		String category = "register";
		return adminLogMapper.insertAdminLog(adminMemberId, messageLog, menu, category);
	}

	public List<AdminLogDto> getAdminLogAll() {
		// TODO Auto-generated method stub
		return adminLogMapper.selectAdminLogAll();
	}
	
	
}
