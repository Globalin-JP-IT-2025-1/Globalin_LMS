package com.library.util;

import java.security.Key;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.library.security.SecurityConstants;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;

// JWT 생성 및 정보 파싱
@Slf4j
@Component
public class JwtUtil {
	@Value("${jwt.secret}")
    private String secretKey;
    private Key key;
    
    // 초기 설정
    @PostConstruct
    public void init() {
        byte[] decodedKey = Base64.getDecoder().decode(secretKey); // Base64 디코딩
        
        if (decodedKey.length != 32) {
            throw new IllegalArgumentException("JWT Secret Key must be exactly 32 bytes (256 bits).");
        }
        this.key = Keys.hmacShaKeyFor(decodedKey);
    }	

	// 토큰 생성
	public Map<String, String> generateTokens(String username) {
		
		Map<String, String> tokens = new HashMap<>();
		
		List<String> roles = new ArrayList<>();
		roles.add("ROLE_USER");
		if (username.equals("admin")) { // 관리자일 경우
		    roles.add("ROLE_ADMIN");
		}
		
		String aToken = Jwts.builder()
				.setSubject(username)
				.claim("roles", roles)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + SecurityConstants.ACCESS_EXPIRATION_TIME * 1000)) // 30분
				.signWith(key, SignatureAlgorithm.HS256)
				.compact();
		
		String rToken = Jwts.builder()
				.setSubject(username)
				.claim("roles", roles)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + SecurityConstants.REFRESH_EXPIRATION_TIME * 1000)) // 15일
				.signWith(key, SignatureAlgorithm.HS256)
				.compact();
		
		
		tokens.put("aToken", aToken);
		tokens.put("rToken", rToken);

		return tokens;
	}

	// 토큰에서 Username 추출
	public String extractUsername(String token) {
		return Jwts.parserBuilder().setSigningKey(key)
				.build()
				.parseClaimsJws(token)
				.getBody()
				.getSubject();
	}
	
	// 토큰에서 ExpiresDate 추출
	public Timestamp extractExpiresDate(String token) {
		Date expiresDate = Jwts.parserBuilder()
				.setSigningKey(key)
				.build()
				.parseClaimsJws(token)
				.getBody()
				.getExpiration();
		
		return new Timestamp(expiresDate.getTime());
	}
	
	// 토큰에서 권한 추출
	public Collection<? extends GrantedAuthority> extractRoles(String token) {
		Claims claims = Jwts.parserBuilder()
				.setSigningKey(key)
				.build()
				.parseClaimsJws(token)
				.getBody();
		
		Object rolesClaim = claims.get("roles");

		if (rolesClaim instanceof List<?>) {
	        return ((List<?>) rolesClaim).stream()
	            .filter(String.class::isInstance)
	            .map(String.class::cast)
	            .map(SimpleGrantedAuthority::new)
	            .collect(Collectors.toList());
	    }

	    return Collections.emptyList();
	}

}
