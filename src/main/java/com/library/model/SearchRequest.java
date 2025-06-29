package com.library.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 검색타입, 검색어 DB Request 객체 (Service --> MyBatis)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SearchRequest {
	
	private String type; // 검색타입
	private String keyword; // 검색어

}
