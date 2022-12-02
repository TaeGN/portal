package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.admin.AdminLogDto;
import com.portal.domain.admin.AdminMemberDto;
import com.portal.mapper.admin.AdminLogMapper;
import com.portal.mapper.admin.AdminMapper;

@Service
@Transactional
public class AdminLogService {
	
	@Autowired
	private AdminLogMapper adminLogMapper;
	
	@Autowired
	private AdminMapper adminMapper;

//	public int registerAdminLog(String adminMemberId, String messageLog, String category) {
//		String menu = "adminMember";
//		AdminMemberDto adminMember = adminMapper.selectAdminMemberByUserName(adminMemberId);
//		return adminLogMapper.insertAdminLog(adminMember, messageLog, menu, category);
//	}

	public int registerAdminLogById(int id, String messageLog, String category) {
		String menu = "adminMember";
		return adminLogMapper.insertAdminLogById(id, messageLog, menu, category);
	}
	
	
	public List<AdminLogDto> getAdminLogAll() {
		// TODO Auto-generated method stub
		return adminLogMapper.selectAdminLogAll();
	}


	public int registerCourseLogById(int adminId, String log, String category) {
		String menu = "course";
		return adminLogMapper.insertCourseLogById(adminId, log, menu, category);
	}

	
	
}
