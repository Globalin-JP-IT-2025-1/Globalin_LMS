package com.library.dto;

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
	private String[] pageTitle = {"main", "home"}; // 타이틀
	@Builder.Default
    private String pagePath = "page/home.jsp"; // jsp 파일경로
    
}
