package com.library.model.status;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BookHistoryStatus {

    ENABLE(0, "정상"),
    DISABLE(1, "비공개"),
    LOANING(2, "대출 중"),
    LOAN_RESERVING(3, "대출 예약 중"),
	RETURNED(4, "반납 완료"),
	LOAN_RESERVE_CANCEL(5, "대출 예약 취소"),
	LIKE(6, "찜 등록"),
	LIKE_CANCEL(7, "찜 등록 취소");

    private final int code;
    private final String description;

}

