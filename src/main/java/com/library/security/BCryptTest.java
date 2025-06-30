package com.library.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

// 테스트용 : 비밀번호 수동 암호화
public class BCryptTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String[] passwords = {"testtest3", "testtest2", "testtest11", "testtest1", "testtest13"};

        for (String password : passwords) {
            String encPassword = encoder.encode(password);
            System.out.println(password + " -> " + encPassword);
        }
    }
}
