package com.library.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 회원 정보 수정 요청 객체
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberInfo {
	
	private int membersId; // 회원 ID
    
    private String password; // 비밀번호
    private String email; // 이메일
    private String mobile; // 전화번호
    private String zipcode; // 우편번호
    private String address; // 주소
    private String addressDetail; // 상세주소

}
