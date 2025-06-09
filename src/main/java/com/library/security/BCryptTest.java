package com.library.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String[] passwords = {"test1", "test2", "test3", "test4", "test5"};

        for (String password : passwords) {
            String hashedPassword = encoder.encode(password);
            System.out.println(password + " -> " + hashedPassword);
        }
    }
}
