package com.portal.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.admin.AdminLogDto;
import com.portal.domain.admin.AdminMemberDto;

@Mapper
public interface AdminLogMapper {

	List<AdminLogDto> selectAdminLogAll(int startNum, int count);

	int insertLog(int adminId, String log, String menu, String category);

	int selectCountAdminLogAll();

	int deleteAdminLogByAdminId(int id);

}
