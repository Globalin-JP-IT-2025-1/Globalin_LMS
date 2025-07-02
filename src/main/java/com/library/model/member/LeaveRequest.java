package com.library.model.member;

import java.sql.Timestamp;

import lombok.Builder;
import lombok.Data;

//service --> mybatis
@Data
@Builder
public class LeaveRequest {
	
	private int membersId; // 회원 ID
	private Timestamp leaveDate; // 탈퇴일자
}
