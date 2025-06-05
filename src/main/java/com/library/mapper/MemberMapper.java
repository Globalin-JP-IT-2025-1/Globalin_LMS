package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.vo.Member;

@Mapper
public interface MemberMapper {
	
	List<Member> getAllMembers(); // 회원 목록 조회
	Member getMemberById(int membersId); // 회원 상세 조회
	int updateMember(int membersId); // 회원 정보 수정 (회원 탈퇴 처리 포함)
	int deleteMember(int membersId); // 회원 삭제
	int insertMember(); // 회원 등록
	int leaveMember(int membersId); // 회원 탈퇴

}