package com.library.mapper;

import java.util.List;

import com.library.model.Article;

public interface ArticleMapper {
	
	List<Article> findAll(); // 글 전체 조회
    Article findById(int id); // 글 상세 조회 (id 기반)
    boolean save(Article article); // 글 등록 및 수정 : 글 없으면 등록, 글 있으면 수정
    boolean deleteById(int id); // 글 삭제 (id 기반)
    
}

