package com.library.security;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.library.dto.Member;

public class MemberDetails implements UserDetails {
	private static final long serialVersionUID = 1L;
	private Member member;
	private final Collection<SimpleGrantedAuthority> authorities;
	
	public MemberDetails(Member member) {
	    this.member = member;
	    this.authorities = Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));
	}
	
	// 계정 활성 여부
    private boolean isActive() {
        return member.getStatus() != 3;
    }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}
	
	@Override
	public String getPassword() {
		return member.getPassword();
	}

	@Override
	public String getUsername() {
		return member.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {
		return isActive();
	}

	@Override
	public boolean isAccountNonLocked() {
		return isActive();
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return isActive();
	}

	@Override
	public boolean isEnabled() {
		return isActive();
	}

}
