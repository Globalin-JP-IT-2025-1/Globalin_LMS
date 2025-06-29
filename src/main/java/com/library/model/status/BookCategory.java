package com.library.model.status;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum BookCategory {

	GENERAL("000", "총류"),
    PHILOSOPHY("100", "철학"),
    RELIGION("200", "종교"),
    SOCIAL_SCIENCE("300", "사회과학"),
    NATURAL_SCIENCE("400", "자연과학"),
    TECHNOLOGY("500", "기술과학"),
    ART("600", "예술"),
    LANGUAGE("700", "언어"),
    LITERATURE("800", "문학"),
    HISTORY("900", "역사");

    private final String code;
    private final String koreanName;

}