package com.library.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class AdminDetailsService implements UserDetailsService {
	@Value("${admin.username}")
	private String adminUsername; // 관리자 id
	@Value("${admin.password}")
	private String adminPassword; // 관리자 pw

    @Override
    public UserDetails loadUserByUsername(String username) {
    	
    	if (!username.equals(adminUsername)) {
    		throw new UsernameNotFoundException("관리자 계정을 찾을 수 없습니다!");
    	}
    	
        return new AdminLogin(adminUsername, adminPassword);
        
    }
}
