package com.library.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.ResourceAccessException;

import com.library.mapper.ArticleMapper;
import com.library.mapper.ReplyMapper;
import com.library.model.Article;
import com.library.model.Member;
import com.library.model.Reply;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ArticleService {
	private final ArticleMapper articleMapper; // 게시글
	private final ReplyMapper replyMapper; // 댓글
	private final MemberService memberService; // 작성자
	
	// 게시글 전체 조회 - admin
	public List<Article> getAllArticles() {
		return articleMapper.getAllArticles();
	}
	
	// 게시글 목록 조회
	public List<Article> getAllArticlesByCategory(String category) {
		return articleMapper.getAllArticlesByCategory(category);
	}
	
	// 게시글 목록 및 작성자 목록 조회
	public Map<String, Object> getAllArticlesByCategoryWithAuthor(String category) {
		
		Map<String, Object> articleListWithAuthor = new HashMap<>();
		
		List<Article> articleList = getAllArticlesByCategory(category);
		List<Member> authorList = new ArrayList<>();
		
		for (Article a : articleList) {
			Member m = memberService.getMemberById(a.getAuthorId());
			authorList.add(m);
		}
		
		articleListWithAuthor.put("articleList", articleList);
		articleListWithAuthor.put("authorList", authorList);
		
		return articleListWithAuthor;
	}

	// 회원별 희망 도서 신청 목록 조회 - book-req
	public List<Article> getArticlesReqByMembersId(int membersId) {
		return articleMapper.getAllBookReqsByMembersId(membersId);
	}
	
	// 게시글 상세 조회
	public Article getArticleById(int articlesId) {
		return articleMapper.getArticleById(articlesId);
	}
	
	// 게시글 상세 조회 (게시글, 게시글 작성자) - fnq
	public Map<String, Object> getArticleByIdWithAuthor(int articlesId) {
		Map<String, Object> articleWithAuthor = new HashMap<>();
		
		// 게시글 가져오기
		Article article = articleMapper.getArticleById(articlesId);
		if (article == null) {
	        throw new ResourceAccessException("게시글을 찾을 수 없습니다.");
	    }
		articleWithAuthor.put("article", article);

		// 작성자 가져오기
		Member member = memberService.getMemberById(article.getAuthorId());
		articleWithAuthor.put("a_author", member);
		
		
		return articleWithAuthor;
	}
	
	// 게시글 상세 조회 (게시글, 게시글 작성자, 댓글 목록, 댓글 작성자 목록) - not, qna, req
	@Transactional
	public Map<String, Object> getArticleWithAuthorAndReplies(int articlesId) {
		// 게시글 + 작성자 정보
		Map<String, Object> articleWithAuthorAndReplies = getArticleByIdWithAuthor(articlesId);
		Article article = (Article) articleWithAuthorAndReplies.get("article");
		
		// 댓글 + 댓글 작성자 목록 가져오기
		if (article.getReplyCount() > 0) {
			List<Reply> replyList = replyMapper.getAllRepliesByArticlesId(articlesId);
			articleWithAuthorAndReplies.put("replyList", replyList);
			
			List<Member> r_authorList = new ArrayList<>();
			for (Reply r : replyList) {
				Member m = memberService.getMemberById(r.getAuthorId());
				r_authorList.add(m);
			}
			articleWithAuthorAndReplies.put("r_authorList", r_authorList);
		}
		
		return articleWithAuthorAndReplies;
	}
	
	// 게시글 등록 - 카테고리에 따라 다름
	public int insertArticle(Article article) {
		return articleMapper.insertArticle(article);
    }
    
    // 게시글 수정 (제목, 내용, Q의 경우: 비밀글 여부) - 작성자
	public int updateArticleInfo(Article article) {
		return articleMapper.updateArticleInfo(article);
	}
	
	// 게시글 수정 (비활성화) - 작성자
	public int updateArticleDisable(int articlesId) {
		return articleMapper.updateArticleDisable(articlesId);
	}
	
	// 게시글 수정 (활성화) - 작성자
	public int updateArticleEnable(int articlesId) {
		return articleMapper.updateArticleEnable(articlesId);
	}
    
    // 게시글 삭제 - 관리자
	public int deleteArticleById(int articleId) {
		return articleMapper.deleteArticleById(articleId);
	}


}