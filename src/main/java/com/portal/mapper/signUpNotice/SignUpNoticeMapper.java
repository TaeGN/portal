package com.portal.mapper.signUpNotice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.sugang.SignUpNoticeDto;

@Mapper
public interface SignUpNoticeMapper {

	List<SignUpNoticeDto> selectSignUpNoticeAllByPage(int startNum, int count);

	int selectCountSignUpNoticeAll();

	SignUpNoticeDto selectSignUpNoticeById(int id);

	int insertSignUpNotice(SignUpNoticeDto signUpNotice);

	int updateSignUpNotice(SignUpNoticeDto signUpNotice);

	int selectLastSignUpNoticeId();

	int deleteSignUpNoticeById(int id);

	List<Integer> selectSignUpNoticeIdByWriterId(int id);

}
