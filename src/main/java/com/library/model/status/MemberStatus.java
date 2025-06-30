package com.library.model.status;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum MemberStatus {

    JUNIOR(0, "준회원"),
    REGULER(1, "정회원"),
    LOAN_HOLD(2, "대출정지"),
    LEAVE(3, "탈퇴회원"),
    ADMIN(9, "관리자");

    private final int code;
    private final String description;

}

