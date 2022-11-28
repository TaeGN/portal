package com.portal.mapper.admin;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.admin.AdminMemberDto;

@Mapper
public interface AdminMapper {

	int insertAdminMember(AdminMemberDto adminMember);

	int insertAdminAuthority(int adminId, String authority);

	void selectLastAdminMember();

	int selectLastAdminMemberId();

}