package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.BookMapper;
import com.library.mapper.MemberMapper;
import com.library.model.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	private final MemberMapper memberMapper;

	public List<Member> findAllMembers() {
		return memberMapper.findAllMembers();
	}


}