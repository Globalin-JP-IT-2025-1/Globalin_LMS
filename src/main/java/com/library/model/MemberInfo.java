package com.library.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 스프링 시큐리티용
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberInfo {
	
	private int membersId; // 회원 ID (MEMBERS_ID, PK)
    private String username; // 회원 username (USERNAME)
    private String name; // 이름 (NAME)

}