package com.portal.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.admin.AdminLogDto;
import com.portal.domain.admin.AdminMemberDto;

@Mapper
public interface AdminLogMapper {

//	int insertAdminLog(AdminMemberDto adminMember, String log, String menu, String category);

	List<AdminLogDto> selectAdminLogAll();

	int insertAdminLogById(int adminId, String log, String menu, String category);

	int insertCourseLogById(int adminId, String log, String menu, String category);

}
