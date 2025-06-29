package com.library.model.status;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BookStatus {

    LOANABLE(0, "정상(대출 가능)"),
    DISABLE(1, "비공개"),
    LOANING(2, "대출 중"),
    LOAN_RESERVING(3, "대출 예약 중");

    private final int code;
    private final String description;

}

