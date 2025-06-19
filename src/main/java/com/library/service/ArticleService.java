package com.library.service;

import java.util.List;
import java.util.Map;

import com.library.model.Article;

public interface ArticleService {
	
	// 게시글 전체 조회 - admin
	public List<Article> getAllArticles();
	
	// 게시글 목록 조회
	public List<Article> getAllArticlesByCategory(String category);
	
	// 게시글 목록 및 작성자 목록 조회
	public Map<String, Object> getAllArticlesByCategoryWithAuthor(String category);

	// 회원별 희망 도서 신청 목록 조회 - book-req
	public List<Article> getArticlesReqByMembersId(int membersId);
	
	// 게시글 상세 조회
	public Article getArticleById(int articlesId);
	
	// 게시글 상세 조회 (게시글, 게시글 작성자) - fnq
	public Map<String, Object> getArticleByIdWithAuthor(int articlesId);
	
	// 게시글 상세 조회 (게시글, 게시글 작성자, 댓글 목록, 댓글 작성자 목록) - not, qna, req
	public Map<String, Object> getArticleWithAuthorAndReplies(int articlesId);
	
	// 게시글 등록
	public int insertArticle(Article article);
    
	// 게시글 수정 
    // 1) 내용 수정 (제목, 내용) - 작성자
	public int updateArticleInfo(Article article);
	
	// 2) 비공개글 전환 - 작성자 삭제 시
	public int updateArticleDisable(int articlesId);
	
	// 3) 공개글 전환 - 작성자 복구 요청 또는 비밀글 해제 시
	public int updateArticleEnable(int articlesId);
	
	// 4) 비밀글 전환(Q&A만) - 작성자 설정
	public int updateArticleSecret(int articlesId);
    
	// 5) view count 증가
	public int updateArticleViewCountUp(int articlesId);
	
	// 6) reply count 증가
	public int updateArticleReplyCountUp(int articlesId);
	
	// 7) reply count 감소
	public int updateArticleReplyCountDown(int articlesId);
	
    // 게시글 삭제 - 관리자 삭제
	public int deleteArticleById(int articlesId);

}