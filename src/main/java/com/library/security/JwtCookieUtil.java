package com.library.security;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class JwtCookieUtil {
	
    public static String getJwtFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("aToken".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    
}

