package com.library.security;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.library.model.Member;
import com.library.service.MemberService;

import lombok.extern.slf4j.Slf4j;


// 사용자 정보 조회 (스프링 시큐리티)
@Slf4j
@Service
@Primary
public class CustomUserDetailsService implements UserDetailsService {
	private final MemberService memberService;
	
	@Value("${admin.password}")
	private String adminPassword; // 관리자 pw
	
	public CustomUserDetailsService(MemberService memberService) {
        this.memberService = memberService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	log.info("### {} - 진입", this.getClass().getSimpleName());
    	
    	if (username.equals("admin")) {
    		System.out.println("CustomUserDetailsService - admin : " + adminPassword);
    		return new CustomUserDetails(
    				"admin", 
    				adminPassword, 
    				Arrays.asList(
	                    new SimpleGrantedAuthority("ROLE_ADMIN"), // 권한 범위만 설정
	                    new SimpleGrantedAuthority("ROLE_USER")
    				),
    				"admin",
    				0
    		);
    	} else {
    		Member member = memberService.getMemberByUsername(username);
	        if (member == null) {
	            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
	        }
	        System.out.println("CustomUserDetailsService - " + member.getUsername() + ", " + member.getPassword());
	        return new CustomUserDetails(
	        		member.getUsername(), 
	        		member.getPassword(), 
	        		Arrays.asList(new SimpleGrantedAuthority("ROLE_USER")),
	        		member.getName(),
	        		member.getMembersId()
	        );
    	}
    }

}
