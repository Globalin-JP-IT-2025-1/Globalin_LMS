package com.library.security;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.library.model.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberLogin implements UserDetails {
	private static final long serialVersionUID = 1L;
	private Member member;

    @Override
    public Collection<? extends SimpleGrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"));
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
        return member.getStatus() != 3;
    }

    @Override
    public boolean isAccountNonLocked() {
        return member.getStatus() != 3;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return member.getStatus() != 3;
    }

    @Override
    public boolean isEnabled() {
        return member.getStatus() != 3;
    }
}

