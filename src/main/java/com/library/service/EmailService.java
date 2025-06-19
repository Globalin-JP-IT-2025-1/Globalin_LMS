package com.library.service;

import com.library.model.Member;

public interface EmailService {
	
	// 회원 가입 여부 성공 메일 보내기
	public void sendUsername(Member member);
	
	// 비밀번호 초기화 메일 보내기
	public void sendResetPassword(Member member, String randomPassword);

	// 회원 가입 축하 메일 보내기
	public void sendRegister(Member member);
	
}
