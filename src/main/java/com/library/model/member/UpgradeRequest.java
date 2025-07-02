package com.library.model.member;

import lombok.Builder;
import lombok.Data;

// service --> mybatis
@Data
@Builder
public class UpgradeRequest {
	private int membersId; // 회원 id
	private String cardNum; // 카드 번호
}
