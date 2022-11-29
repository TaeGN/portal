package com.portal.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.admin.AdminLogDto;

@Mapper
public interface AdminLogMapper {

	int insertAdminLog(String adminMemberId, String log, String menu, String category);

	List<AdminLogDto> selectAdminLogAll();

}
