package com.library.model;

import java.sql.Timestamp;

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
public class Member {
	
	private int membersId; // 회원 ID
    private String username; // 아이디
    private String password; // 비밀번호
    
    private String name; // 이름
    private String email; // 이메일
    private String mobile; // 전화번호
    private String zipcode; // 우편번호
    private String address; // 주소
    private String addressDetail; // 상세주소
    
    private int status; // 회원 등급 (0:준회원, 1:정회원, 2:연체 대출정지, 3: 탈퇴회원, 9: 관리자)
    private String cardNum; // 회원 카드번호
    private int loanCount; // 현재 대출 중인 도서 권수 (0~9)
    
    private Timestamp joinDate; // 가입일자
    private Timestamp leaveDate; // 탈퇴일자
    
}