package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Article;

@Mapper
public interface ArticleMapper {
	
	List<Article> getAllArticles(); // 글 전체 조회
    Article getArticleById(int articleId); // 글 상세 조회 (id 기반)
    int insertArticle(Article article); // 글 등록
    int updateArticle(Article article); // 글 수정
    int deleteArticleById(int articleId); // 글 삭제 (id 기반)
    
}
