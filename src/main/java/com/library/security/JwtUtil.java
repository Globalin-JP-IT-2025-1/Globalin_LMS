package com.library.security;

import java.security.Key;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;

// JWT 생성 및 검증
@Slf4j
@Component
public class JwtUtil {
	private final long ACCESS_EXPIRATION_TIME = 600000; // 10분
	private final long REFRESH_EXPIRATION_TIME = 604800000; // 7일
	
	@Value("${jwt.secret}")
    private String secretKey;
    private Key key;
    
    // 초기 설정
    @PostConstruct
    public void init() {
		/*
		 * System.out.println("✅ 시크릿 키: " + secretKey);
		 * System.out.println("✅ 시크릿 키의 바이트 크기: " + secretKey.length());
		 */
        byte[] decodedKey = Base64.getDecoder().decode(secretKey); // Base64 디코딩
        
        if (decodedKey.length != 32) {
            throw new IllegalArgumentException("JWT Secret Key must be exactly 32 bytes (256 bits).");
        }
        this.key = Keys.hmacShaKeyFor(decodedKey);
    }	

	// JWT 생성
	public Map<String, String> generateTokens(String username) {
		Map<String, String> tokens = new HashMap<>();
		
		String accessToken = Jwts.builder()
				.setSubject(username)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + ACCESS_EXPIRATION_TIME)) // 10분
				.signWith(key, SignatureAlgorithm.HS256).compact();

		String refreshToken = Jwts.builder()
				.setSubject(username)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + REFRESH_EXPIRATION_TIME)) // 7일
				.signWith(key, SignatureAlgorithm.HS256).compact();
		
		tokens.put("aToken", accessToken);
		tokens.put("rToken", refreshToken);
		
		return tokens;
	}

	// 액세스 토큰 검증 (유효시간)
	public boolean isValidAccessToken(String aToken) {
		try {
			// 무결성 검사
			Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(aToken);
			
			// 유효시간 검사 : 현재 시간 > 리프레시 토큰 유효시간
			
			// 블랙리스트 검사
			
			return true;
		} catch (Exception e) {
			log.error("JWT 검증 실패: {}", e.getMessage());
			return false;
		}
	}
	
	// 리프레시 토큰 검증
	public boolean isValidRefreshToken(String rToken) {
		try {
			// 무결성 검사
			Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(rToken);
			
			// 유효시간 검사 : 현재 시간 > 리프레시 토큰 유효시간
			
			// 해당 회원이 존재하는지
			
			// 블랙리스트 검사
			
			
			return true;
		} catch (Exception e) {
			log.error("JWT 검증 실패: {}", e.getMessage());
			return false;
		}
	}

	// 토큰에서 Username 추출
	public String extractUsername(String token) {
		return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
				.getBody().getSubject();
	}
	
	// 토큰에서 ExpiresDate 추출
	public Timestamp extractExpiresDate(String token) {
		Date expiresDate = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
				.getBody().getExpiration();
		
		return new Timestamp(expiresDate.getTime());
	}

}
