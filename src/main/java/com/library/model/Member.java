package com.library.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	
	private int membersId; // 회원 ID (MEMBERS_ID, PK)
    private int status; // 회원 등급 (STATUS, 0:준회원, 1:정회원, 2:대출정지)
    private String cardNum; // 회원 카드번호 (CARD_NUM, UUID 형식)
    private String email; // 이메일 (EMAIL, UNIQUE)
    private String password; // 비밀번호 (PASSWORD)
    private String name; // 이름 (NAME)
    private String mobile; // 전화번호 (MOBILE)
    private String zipcode; // 우편번호 (ZIPCODE)
    private String address; // 상세주소 (ADDRESS)
    private Date joinDate; // 가입일자 (JOIN_DATE)
    private Date leaveDate; // 탈퇴일자 (LEAVE_DATE)

}