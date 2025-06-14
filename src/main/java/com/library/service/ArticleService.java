package com.library.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.ResourceAccessException;

import com.library.mapper.ArticleMapper;
import com.library.mapper.ReplyMapper;
import com.library.model.Article;
import com.library.model.Reply;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ArticleService {
	private final ArticleMapper articleMapper;
	private final ReplyMapper replyMapper;
	
	// 게시글 목록 조회
	public List<Article> getAllArticlesByCategory(String category) {
		return articleMapper.getAllArticlesByCategory(category);
	}

	// 회원별 희망도서 신청 목록 조회
	public List<Article> getArticlesReqByMembersId(int membersId) {
		return articleMapper.getAllBookReqsByMembersId(membersId);
	}
	
	// 게시글 상세 조회 (+댓글) - faq 제외
	@Transactional
	public Map<String, Object> getArticleWithReply(int articlesId) {
		Map<String, Object> articleWithReply = new HashMap<>();
		
		Article article = articleMapper.getArticleById(articlesId);
		if (article == null) {
	        throw new ResourceAccessException("게시글을 찾을 수 없습니다.");
	    }
		
		articleWithReply.put("article", article);
		
		if (article.getReplyCount() > 0) {
			List<Reply> replyList = replyMapper.getAllRepliesByArticlesId(articlesId);
			articleWithReply.put("replyList", replyList);
		}
		
		return articleWithReply;
	}
	
	// 게시글 등록 - 카테고리에 따라 다름
	public int insertArticle(Article article) {
		return articleMapper.insertArticle(article);
    }
    
    // 게시글 수정 (제목, 내용, Q의 경우: 비밀글 여부) - 작성자
	public int updateArticleInfo(Article article) {
		return articleMapper.updateArticle(article);
	}
	
	// 게시글 수정 (활성화/비활성화) - 작성자
	public int updateArticleDisable(Article article) {
		return articleMapper.updateArticle(article);
	}
    
    // 게시글 삭제 - 관리자
	public int deleteArticleById(int articleId) {
		return articleMapper.deleteArticleById(articleId);
	}

}