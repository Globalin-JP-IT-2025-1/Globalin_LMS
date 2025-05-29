package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.MemberMapper;
import com.library.model.Member;

@Service
public class MemberService {
	private final MemberMapper memberMapper;
	
	public MemberService(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	
	public List<Member> findAllMembers() {
		return memberMapper.findAllMembers();
	}


}
