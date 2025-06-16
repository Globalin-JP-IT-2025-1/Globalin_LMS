package com.library.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;

@SuppressWarnings("serial")
@Setter
@Getter
public class CustomUserDetails implements UserDetails {
	private final String username;
    private final String password;
    private final Collection<? extends GrantedAuthority> authorities;
    
    private String fullname;
    private int membersId;

    public CustomUserDetails(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        this.username = username;
        this.password = password;
        this.authorities = authorities;
    }
    
    public CustomUserDetails(String username, String password, Collection<? extends GrantedAuthority> authorities, 
    		String fullname, int membersId) {
        this.username = username; // 쿠키 저장 + 인증
        this.password = password; // 인증
        this.authorities = authorities; // 권한
        this.fullname = fullname; // 쿠키 저장용
        this.membersId = membersId; // 쿠키 저장용
    }
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}

