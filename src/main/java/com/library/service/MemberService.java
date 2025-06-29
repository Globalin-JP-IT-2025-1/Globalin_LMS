package com.library.service;

import com.library.model.member.Member;
import com.library.model.member.MemberListResponse;

public interface MemberService {

	// 조회
	// 1) 회원 목록 조회
	public MemberListResponse getMemberList(int page);
	
	// 2) 회원 전체 수
	public int getMemberListCount();

	// 3) 회원 정보 조회
	// membersId 기반
	public Member getMemberById(int membersId);

	// username 기반
	public Member getMemberByUsername(String username);

	// email 기반
	public Member getMemberByEmail(String email);

	// 회원 정보 수정
	// 1) 회원 - 내 정보 수정 (password, email, mobile, zipcode, address, addressDetail)
	public int updateMemberInfo(Member member);

	// 2) 회원 - 탈퇴 (status, leaveDate)
	public int updateMemberLeave(int membersId);

	// 3) 관리자 - 회원카드 등록 (status, cardnum)
	public int updateMemberCardnum(int membersId, String cardNum);

	// 4) 도서 시스템 - 도서 연체 (status)
	public int updateMemberOverdue(Member member);

	// 5) 도서 시스템 - 도서 대출 (loanCount)
	public int updateMemberLoanCountUp(int membersId);
	
	// 6) 도서 시스템 - 도서 반납 (loanCount)
	public int updateMemberLoanCountDown(int membersId);

	// 회원 삭제 - 관리자
	public int deleteMember(int membersId);

	// 회원 등록 - 회원
	public int insertMember(Member member);

	// 비밀번호 초기화
	public String resetPassword(Member member);

}