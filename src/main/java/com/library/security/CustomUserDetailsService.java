package com.library.security;

import java.util.Arrays;
import java.util.List;

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

	public CustomUserDetailsService(MemberService memberService) {
        this.memberService = memberService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	log.info("### {} - 진입", this.getClass().getSimpleName());
    	
    	Member member = memberService.getMemberByUsername(username);
    	if (member == null) {
    		throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
    	}
    	
    	System.out.println("CustomUserDetailsService - " + member.getUsername() + " : " + member.getPassword());
    	
    	List<SimpleGrantedAuthority> authorities = 
    		    username.equals("admin") ? 
    		    Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN"), new SimpleGrantedAuthority("ROLE_USER")) : 
    		    Arrays.asList(new SimpleGrantedAuthority("ROLE_USER"));

    		return new CustomUserDetails(
    		    member.getUsername(),
    		    member.getPassword(),
    		    authorities,
    		    member.getName(),
    		    member.getMembersId(),
    		    member.getStatus()
    		);

    }

}
