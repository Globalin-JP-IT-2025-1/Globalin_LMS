package com.library.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.PageInfo;
import com.library.model.article.Article;
import com.library.model.book.Book;
import com.library.model.member.Member;
import com.library.model.status.MemberStatus;
import com.library.security.CustomUserDetails;
import com.library.service.ArticleService;
import com.library.service.BookService;
import com.library.service.MemberBookHistoryService;
import com.library.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/")
@AllArgsConstructor
public class HomeController {
	private PageInfo pageInfo;
	private final ArticleService articleService;
	private final BookService bookService;
	private final MemberService memberService;
	private final MemberBookHistoryService memberBookHistoryService;
    
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
	@GetMapping
    public String showHome(@RequestParam(value="status", defaultValue="1") Integer status, 
						   @RequestParam(value="book", defaultValue="1") Integer book,
						   Authentication authentication,
    					   HttpServletRequest request, 
    					   Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
		// 공지사항 최신 5건
		List<Article> articleList = articleService.getNoticeListForHome();
		List<Book> bookList = null;
		
		// 추천 도서, 인기 도서, 신착 도서
		if (book == 1) { // 추천 도서 3건
			bookList = bookService.getRecBookListForHome();
		} else if (book == 2) { // 인기 도서 3건
			bookList = bookService.getPopBookListForHome();
		} else if (book == 3) { // 신착 도서 3건
			bookList = bookService.getNewBookListForHome();
		}
		
		// 정회원, 대출정지인 경우 : 연체 일수, 연체 건수 계산 후 뷰로 전달
		int totalOverdueDay = 0;
		int totalOverdueCount = 0;
		
		if (authentication != null) {
			CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
			int membersId = user.getMembersId();
			Member member = memberService.getMemberById(membersId);
			int mStatus = member.getStatus();
			
			if (mStatus == MemberStatus.REGULER.getCode() 
				|| mStatus == MemberStatus.LOAN_HOLD.getCode()) {
				
				Map<String, Integer> totalOverdues = memberBookHistoryService.getTotalOverdue(membersId);
				
				if (totalOverdues != null) {
					totalOverdueDay = totalOverdues.getOrDefault("day", 0);
					totalOverdueCount = totalOverdues.getOrDefault("count", 0);
				}
			}
			
			// 정회원인 경우 : 연체일 때 status 갱신
			if (mStatus == MemberStatus.REGULER.getCode()) {
				if (totalOverdueDay > 0 || totalOverdueCount > 0) {
					memberService.updateMemberOverdue(membersId); // 반 실시간 반영
				}
				
			}
			System.out.println("membersId : " + membersId 
					+ ", totalOverdueCount : " + totalOverdueDay 
					+ ", totalOverdueCount : " + totalOverdueCount);
			
		}
		
		// 뷰로 전달
		model.addAttribute("articleList", articleList);
		model.addAttribute("bookList", bookList);
		
		model.addAttribute("totalOverdueDay", totalOverdueDay);
		model.addAttribute("totalOverdueCount", totalOverdueCount);
		
    	setPageInfo(model);
    	
    	if (status == -1) {
    		model.addAttribute("alertType", "fail");
    		model.addAttribute("alertMessage", "접근 권한이 없습니다.");
    	}
    	
        return "layout";
    }
    
}