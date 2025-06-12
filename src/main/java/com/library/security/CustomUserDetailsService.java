package com.library.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.library.mapper.MemberMapper;
import com.library.model.Member;

import lombok.RequiredArgsConstructor;

// 사용자 정보 조회 (스프링 시큐리티)
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
	private final MemberMapper memberMapper;
	
	@Value("${admin.username}")
	private String adminUsername; // 관리자 id
	@Value("${admin.password}")
	private String adminPassword; // 관리자 pw
	
	@Override
	public UserDetails loadUserByUsername(String username) {
		System.out.println("CustomUserDetailsService - 진입 성공");
		
		if (username.equals(adminUsername)) {
			return new AdminLogin(adminUsername, adminPassword);
		}
		
        Member member = memberMapper.getMemberByUsername(username);
		
        if (member == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
        }
		
		return new MemberLogin(member);
    }

}
