package com.library.model;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Component
public class PageInfo {
	@Builder.Default
	private String pageTitleCode = "0"; // 현재 페이지 코드
	@Builder.Default
    private String pagePath = "page/home.jsp"; // jsp 파일경로
	
}