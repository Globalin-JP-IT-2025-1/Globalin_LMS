package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Member;

@Mapper
public interface MemberMapper {
	// 조회
	List<Member> getAllMembers(); // 회원 목록 조회
	Member getMemberById(int membersId); // 회원 상세 조회 (membersId 기반)
	Member getMemberByUsername(String username); // 회원 상세 조회 (username 기반)
	Member getMemberByEmail(String email); // 회원 상세 조회 (email 기반)
	
	// 수정
	int updateMemberInfo(Member member); // 1) 회원 - 내 정보 수정
	int updateMemberLeave(Member member); // 2) 회원 - 탈퇴
	int updateMemberCardnum(Member member); // 3) 관리자 - 회원카드 등록
	int updateMemberOverdue(Member member); // 4) 도서 시스템 - 도서 연체
	int updateMemberLoanCount(Member member); // 5) 도서 시스템 - 도서 대출
	
	// 등록&삭제
	int insertMember(Member member); // 회원 등록
	int deleteMember(int membersId); // 회원 삭제

}