package com.portal.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.sugang.SignUpNoticeDto;
import com.portal.mapper.signUpNotice.SignUpNoticeMapper;

@Service
@Transactional
public class SignUpNoticeService {
	
	@Autowired
	private SignUpNoticeMapper signUpNoticeMapper;

	public List<SignUpNoticeDto> getSignUpNoticeAllByPage(int startNum, int count) {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.selectSignUpNoticeAllByPage(startNum, count);
	}

	public int getCountSignUpNoticeAll() {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.selectCountSignUpNoticeAll();
	}

	public SignUpNoticeDto getSignUpNoticeById(int id) {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.selectSignUpNoticeById(id);
	}

	public int registerSignUpNotice(SignUpNoticeDto signUpNotice) {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.insertSignUpNotice(signUpNotice);
	}

	public int modifySignUpNotice(SignUpNoticeDto signUpNotice) {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.updateSignUpNotice(signUpNotice);
	}

	public int getLastSignUpNoticeId() {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.selectLastSignUpNoticeId();
	}

	public int removeSignUpNotice(int id) {
		// TODO Auto-generated method stub
		return signUpNoticeMapper.deleteSignUpNoticeById(id);
	}

	
	
}
