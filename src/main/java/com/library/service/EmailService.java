package com.library.service;

import com.library.model.Member;

public interface EmailService {
	
	// 회원 가입 여부 성공 메일 보내기
	public void sendRegisterMember(Member member);
	
	// 아이디 찾기 메일 보내기
	public void sendFindUsername(Member member);
	
	// 비밀번호 재발급 메일 보내기
	public void sendResetPassword(Member member, String randomPassword);

}
