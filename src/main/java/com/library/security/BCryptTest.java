package com.library.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        String[] passwords = {"library123"};

        for (String password : passwords) {
            String hashedPassword = encoder.encode(password);
            System.out.println(password + " -> " + hashedPassword);
        }
    }
}
