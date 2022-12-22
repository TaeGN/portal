package com.portal.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.admin.AdminLogDto;
import com.portal.domain.admin.AdminMemberDto;

@Mapper
public interface AdminMapper {
	// adminMember
	int insertAdminMember(AdminMemberDto adminMember);

	int insertAdminAuthority(int adminId, String authority);

	int selectLastAdminMemberById();

	List<AdminMemberDto> selectAdminMemberAll(int startNum, int count);
	
	AdminMemberDto selectAdminMemberByUserName(String username);

	int updateAdminMember(AdminMemberDto adminMember);

	int deleteAdminMemberById(int id);

	int deleteAdminAuthorityByAdminId(int id);

	int insertFile(int id, String fileName);

	int deleteFileByBoardIdAndFileName(int memberId, String fileName);

	AdminMemberDto selectAdminMemberById(int id);

	int selectCountAdminMemberAll();

	
}
