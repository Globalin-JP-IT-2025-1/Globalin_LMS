package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.vo.Article;

@Mapper
public interface ArticleMapper {
	
	List<Article> findAllArticles(); // 글 전체 조회
    Article findArticleById(int id); // 글 상세 조회 (id 기반)
    boolean saveArticle(Article article); // 글 등록 및 수정 : 없으면 등록, 있으면 수정
    boolean deleteArticleById(int id); // 글 삭제 (id 기반)
    
}
