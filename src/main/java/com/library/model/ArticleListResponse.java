package com.library.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 게시글 목록 (작성자 포함) Service Response 객체 (Service --> Controller)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArticleListResponse {
	
	private List<ArticleWithAuthor> articleWithAuthorList; // 게시글 목록 (작성자 포함)
    private int totalCount; // 전체 개수
    private int totalPages; // 전체 페이지
	
}