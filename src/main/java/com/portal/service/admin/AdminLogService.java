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

	
	public List<AdminLogDto> getAdminLogAll() {
		// TODO Auto-generated method stub
		return adminLogMapper.selectAdminLogAll();
	}

	public int registerAdminLogById(int adminId, String log, String category) {
		String menu = "adminMember";
		return adminLogMapper.insertLog(adminId, log, menu, category);
	}
	

	public int registerCourseLogById(int adminId, String log, String category) {
		String menu = "course";
		return adminLogMapper.insertLog(adminId, log, menu, category);
	}


	public int registerStudentLogById(int adminId, String log, String category) {
		String menu = "student";
		return adminLogMapper.insertLog(adminId, log, menu, category);
	}

	public int registerProfessorLogById(int adminId, String log, String category) {
		String menu = "professor";
		return adminLogMapper.insertLog(adminId, log, menu, category);
	}

	public int registerCourseInfoLogById(int adminId, String log, String category) {
		String menu = "courseInfo";
		return adminLogMapper.insertLog(adminId, log, menu, category);
	}

	
	
}
