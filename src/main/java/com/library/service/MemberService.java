package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.MemberMapper;
import com.library.vo.Member;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberService {
	private final MemberMapper memberMapper;
	private final TokenService tokenService;

	public List<Member> getAllMembers() {
		return memberMapper.getAllMembers();
	}

	public Member getMemberById(int membersId) {
		return memberMapper.getMemberById(membersId);
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

	public int leaveMember(int membersId) {
		// 해당 회원의 리프레쉬, 액세스토큰을 브라우저 세션과 쿠키에서 삭제하고 블랙 리스트에 등록하는 코드
		// 회원을 블랙리스트에 등록하는 로직이 있다면 추가
		tokenService.addToBlacklist(membersId);
		
		// 회원 브라우저상의 리프레시 & 액세스 토큰 삭제
        tokenService.invalidateTokens(membersId);
        
		return memberMapper.leaveMember(membersId);
	}

	public int getMemberByEmail() {
		
		// 이메일 기준으로 모바일, 성함이 일치하는지 DB에서 확인하는 코드
		// 맞으면0 : 비밀번호 재발급 메일 보내기
		// 틀리면-1 : 해당 정보와 일치하는 회원이 없습니다. 알림만 띄우기
		
		return 0;
	}


}