package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Article;
import com.library.model.ArticleWithAuthor;
import com.library.model.ArticleListRequest;

@Mapper
public interface ArticleMapper {
	
	// 게시글 조회
	List<ArticleWithAuthor> getArticleList(ArticleListRequest articleListRequest); // 1) 목록 전체 조회 - 관리자
	List<ArticleWithAuthor> getArticleListByCategory(ArticleListRequest articleListRequest); // 2) 게시글 목록 조회 (카테고리 기준)
	List<ArticleWithAuthor> getArticleListByReqByMembersId(ArticleListRequest articleListRequest); // 3) 희망 도서 신청 게시글 목록 조회 (회원ID 기준)
	
	int getArticleListCount(); // 4) 전체 게시글 수
	int getArticleListCountByCategory(String category); // 5) 게시글 수 (카테고리 기준)
	int getArticleListCountByReqByMembersId(int membersId); // 6) 희망 도서 신청 게시글 수 (회원ID 기준)
	
	ArticleWithAuthor getArticleByArticlesId(int articleId); // 7) 게시글 상세 조회
    
    // 게시글 수정
    int updateArticleInfo(Article article); // 1) 제목 & 내용 수정
    int updateArticleDisable(int articleId); // 2) 비공개글 전환
    int updateArticleEnable(int articleId); // 3) 공개글 전환
    int updateArticleSecret(int articleId); // 4) 비밀글 전환
    
    int updateArticleViewCountUp(int articleId); // 5) view count 증가
    int updateArticleReplyCountUp(int articleId); // 6) reply count 증가
    int updateArticleReplyCountDown(int articleId); // 7) reply count 감소
    
    // 게시글 등록
    int insertArticle(Article article);
    
    // 게시글 삭제
    int deleteArticleById(int articleId);


    
}
