package com.library.service;

// Redis - 회원 관리 (비밀번호 오류 횟수)
public interface MemberRedisService {
	
	// 비밀번호 오류 횟수 조회
	public int getLoginFailCount(int membersId);
	
	// 비밀번호 오류 횟수 갱신
	public void updateLoginFailCount(int membersId);
    
    // 로그인이 가능한 지 확인 (실패 횟수 5회 이상인 경우 차단)
    public boolean isLoginAllowed(int memberId);

}
