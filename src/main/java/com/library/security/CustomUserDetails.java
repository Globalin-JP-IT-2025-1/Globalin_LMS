package com.library.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@SuppressWarnings("serial")
@Setter
@Getter
@AllArgsConstructor
public class CustomUserDetails implements UserDetails {
	private final String username; // 아이디
    private final String password; // 비밀번호
    private final Collection<? extends GrantedAuthority> authorities; // 권한 목록
    
    private String fullname; // 이름
    private int membersId; // DB 식별키
    private int status; // 회원 등급 (0:준회원, 1:정회원, 2:연체 대출정지, 3: 탈퇴회원, 9: 관리자)
//    private Member member; // 회원 객체

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

