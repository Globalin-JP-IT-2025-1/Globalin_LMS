package com.library.security;

public class SecurityConstants {
    // 로그인 인증 URL 정의
    public static final String AUTH_LOGIN_URL = "/public/auth/login";

    // JWT 토큰 기본 상수값 정의
    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer "; // 띄어쓰기 지우면 안됨
    public static final String TOKEN_TYPE = "JWT";
}
