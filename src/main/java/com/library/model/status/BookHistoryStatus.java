package com.library.model.status;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BookHistoryStatus {

    STANDARD(0, "정상"),
    OVERDUE(1, "연체중");

    private final int code;
    private final String description;

}

