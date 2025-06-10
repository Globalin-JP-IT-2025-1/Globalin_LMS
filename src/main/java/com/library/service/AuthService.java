package com.library.service;

import java.rmi.NotBoundException;
import java.util.Map;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.library.mapper.MemberMapper;
import com.library.model.Member;
import com.library.security.JwtUtil;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AuthService {
	private final MemberMapper memberMapper;
	private final JwtUtil jwtUtil;
	private final PasswordEncoder passwordEncoder;
	
	// 회원 등록
    public int registerMember(Member member) {
        String encodedPassword = passwordEncoder.encode(member.getPassword());
        member.setPassword(encodedPassword);
        return memberMapper.insertMember(member);
    }
    
    // DB 로그인 검증
    public int verifyMemberDB(String username, String password) {
    	Member member = memberMapper.getMemberByUsername(username);
    	
    	if (member == null) {
    		throw new UsernameNotFoundException("회원 정보가 존재하지 않습니다 :" + username);
    	}
    	
    	System.out.println("membersId : " + member.getMembersId());
    	System.out.println(password + " : " + member.getPassword());
    	
    	if (!passwordEncoder.matches(password, member.getPassword())) {
    		throw new BadCredentialsException("비밀번호가 일치하지 않습니다!");
    	}
    	
    	return member.getMembersId();
    }
    
    // 액세스 토큰 검증 (무결성, 유효시간)
    public boolean verifyAccessToken(String aToken) {

    	return true;
    }
    
    // 리프레시 토큰 검증 (무결성, 유효시간, 회원 존재 여부, 블랙리스트)
    public boolean verifyRefreshToken(String rtoken) {

    	return true;
    }
	
    // 액세스 토큰 발급 & 리프레시 토큰 발급
    public Map<String, String> generateTokens(String membersId) {
    	return jwtUtil.generateTokens(membersId);
    }

}
