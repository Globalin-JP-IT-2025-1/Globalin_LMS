package com.library.mapper;

import java.util.List;

import com.library.vo.Member;

public interface MemberMapper {
	
	List<Member> findAllMembers(); // 회원 전체 조회

}