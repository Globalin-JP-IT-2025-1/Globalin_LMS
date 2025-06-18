package com.library.service;

import java.util.List;
import java.util.Map;

import com.library.model.Member;

public interface MemberService {

	// 회원 목록 조회
	public List<Member> getAllMembers();

	// 회원 정보 조회
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
	public int updateMemberLeave(Member member);

	// 회원 탈퇴 토큰 처리
	public int updateMemberLeave(int membersId, Map<String, String> tokens);

	// 3) 관리자 - 회원카드 등록 (status, cardnum)
	public int updateMemberCardnum(int membersId, String cardNum);

	// 4) 도서 시스템 - 도서 연체 (status)
	public int updateMemberOverdue(Member member);

	// 5) 도서 시스템 - 도서 대출 (loanCount)
	public int updateMemberLoanCount(Member member);

	// 회원 삭제 - 관리자
	public int deleteMember(int membersId);

	// 회원 등록 - 회원
	public int insertMember(Member member);

	// 비밀번호 초기화
	public String resetPassword(Member member);

}