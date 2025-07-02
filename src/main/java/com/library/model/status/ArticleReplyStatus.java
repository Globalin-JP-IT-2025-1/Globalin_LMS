package com.library.model.status;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ArticleReplyStatus {

    ENABLE(0, "공개"),
    DISABLE(1, "비공개"),
    SECRET(2, "비밀글");

    private final int code;
    private final String description;

}

