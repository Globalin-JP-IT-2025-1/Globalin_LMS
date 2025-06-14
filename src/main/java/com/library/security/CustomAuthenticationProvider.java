package com.library.security;

import java.util.Arrays;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {
	private final CustomUserDetailsService userDetailService;
	private final PasswordEncoder passwordEncoder;

	public CustomAuthenticationProvider(CustomUserDetailsService userDetailService, PasswordEncoder passwordEncoder) {
		this.userDetailService = userDetailService;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
	    System.out.println("CustomAuthenticationProvider - 인증 시도: " + authentication.getName());

	    String username = authentication.getName();
	    String password = authentication.getCredentials().toString();

	    // 사용자 직접 조회 (UserDetailsService를 사용하지 않는다면 DB에서 조회 필요)
	    UserDetails user = userDetailService.loadUserByUsername(username);
	    if (user == null) {
	        throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + username);
	    }

	    // 비밀번호 검증 (UserDetailsService를 사용하지 않는다면 직접 검증)
	    if (!passwordEncoder.matches(password, user.getPassword())) {
	        throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
	    }

	    System.out.println("CustomAuthenticationProvider - 인증 성공! : " + username);
	    
	    if (username.equals("admin")) {
	    	return new UsernamePasswordAuthenticationToken(
	    			user, password, Arrays.asList(
		                    new SimpleGrantedAuthority("ROLE_ADMIN"),  // 실제 권한 부여
		                    new SimpleGrantedAuthority("ROLE_USER")
	    			)
	    	);
	    } else {
	    	return new UsernamePasswordAuthenticationToken(
	    			user, password, Arrays.asList(
	    					new SimpleGrantedAuthority("ROLE_USER")
	    			)
	    	);
	    }
	}


	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
}
