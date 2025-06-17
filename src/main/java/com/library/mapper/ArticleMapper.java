package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Article;

@Mapper
public interface ArticleMapper {
	
	// 게시글 목록 전체 조회 - 관리자
	List<Article> getAllArticles();
	
	// 카테고리별 게시글 목록 조회
	List<Article> getAllArticlesByCategory(String category);
	
	// 희망도서 신청 목록 전체 조회 - 회원
	List<Article> getAllBookReqsByMembersId(int membersId);
	
	// 게시글 상세 조회
    Article getArticleById(int articleId);
    
    // 게시글 수정
    int updateArticleInfo(Article article); // 제목, 내용 수정
    int updateArticleDisable(int articleId); // 비공개글 전환
    int updateArticleEnable(int articleId); // 공개글 전환
    int updateArticleSecret(int articleId); // 비밀글 전환
    
    // 게시글 등록
    int insertArticle(Article article);
    
    // 게시글 삭제
    int deleteArticleById(int articleId);

    
}
