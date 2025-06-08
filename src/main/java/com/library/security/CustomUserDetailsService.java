package com.library.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.library.dto.Member;
import com.library.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
	private final MemberMapper memberMapper;
	@Value("${admin.username}")
	private String adminUsername;

	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		if (username.equals(adminUsername)) {
			return new AdminDetails();
		}
		
        Member member = memberMapper.getMemberById(Integer.parseInt(username));
        
        if (member == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
        }

        return new MemberDetails(member);
    }

}
