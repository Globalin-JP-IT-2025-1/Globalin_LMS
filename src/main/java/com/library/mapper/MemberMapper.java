package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.dto.CardnumSerial;
import com.library.dto.Member;

@Mapper
public interface MemberMapper {
	// 조회
	List<Member> getAllMembers(); // 회원 목록 조회
	Member getMemberById(int membersId); // 회원 상세 조회 (membersId 기반)
	Member getMemberByUsername(String username); // 회원 상세 조회 (username 기반)
	Member getMemberByEmail(String email); // 회원 상세 조회 (email 기반)
	
	// 수정
	int updateMemberInfo(Member member); // 회원 정보 수정 (유저 / 내정보 / 회원 정보 수정)
	int updateMemberLeave(Member member); // 회원 정보 수정 (유저 / 내정보 / 탈퇴 처리)
	int updateMemberGrade(Member member); // 회원 정보 수정 (관리자 / 회원 관리 / 회원카드 등록)
	
	// 등록&삭제
	int insertMember(Member member); // 회원 등록
	int deleteMember(int membersId); // 회원 삭제
	
	// 회원카드 관련
	CardnumSerial getCardnumSerial(); // 마지막 시리얼 조회
	int updateCardnumSerial(CardnumSerial cardnumSerial); // 업데이트

}