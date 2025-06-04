package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.MemberMapper;
import com.library.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	private final MemberMapper memberMapper;

	public List<Member> findAllMembers() {
		return memberMapper.findAllMembers();
	}

	public Member findMemberById(int membersId) {
		return memberMapper.findMemberById(membersId);
	}

	public int updateMember(int membersId) {
		return memberMapper.updateMember(membersId);
	}

	public int deleteMember(int membersId) {
		return memberMapper.deleteMember(membersId);
	}
	
	public int insertMember() {
		return memberMapper.insertMember();
	}


}