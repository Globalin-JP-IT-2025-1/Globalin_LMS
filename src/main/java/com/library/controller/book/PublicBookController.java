package com.library.controller.book;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.book.BookDetailResponse;
import com.library.model.book.BookListResponse;
import com.library.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/public/books")
@AllArgsConstructor
public class PublicBookController {
    private final BookService bookService;
    private PageInfo pageInfo;

    public void setPageInfo(Model model) {
        model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
        model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 1) 통합검색 전체 목록 + 키워드 검색 목록
    @GetMapping("/total")
    public String getBookListByTotal(@RequestParam(value = "type", required = false, defaultValue = "title") String type,
							         @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
							         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
							         Model model) {
        
    	BookListResponse bookListResponse = null;
    	
    	if (keyword != null && !keyword.trim().isEmpty()) { // 키워드 검색
    		bookListResponse = bookService.getBookListByKeywordByDB(type, keyword, page);
    	} else { // 전체 목록
    		bookListResponse = bookService.getBookList(page);
    	}
    	
    	model.addAttribute("totalCount", bookListResponse.getTotalCount());
    	model.addAttribute("totalPage", bookListResponse.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	if (bookListResponse.getTotalCount() > 0) {
    		model.addAttribute("bookList", bookListResponse.getBookList());
    	} else {
    		model.addAttribute("bookList", null);
    	}

        pageInfo = PageInfo.builder()
                .pageTitleCode("11")
                .pagePath("page/2-book/bookList_total.jsp")
                .build();
        
        setPageInfo(model);

        return "layout";
    }

    // 2) 주제별(카테고리별) 전체 목록
    @GetMapping("/class")
    public String getBookListByClassNo(@RequestParam(value = "class_no", required = false, defaultValue = "000") String classNo,
					          		   @RequestParam(value = "page", required = false, defaultValue = "1") int page,
					          		   Model model) {
    	
    	BookListResponse bookListResponse = bookService.getBookListByClassNo(classNo, page);
    	
    	model.addAttribute("totalCount", bookListResponse.getTotalCount());
    	model.addAttribute("totalPage", bookListResponse.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	if (bookListResponse.getTotalCount() > 0) {
    		model.addAttribute("bookList", bookListResponse.getBookList());
    	} else {
    		model.addAttribute("bookList", null);
    	}

        pageInfo = PageInfo.builder()
                .pageTitleCode("12")
                .pagePath("page/2-book/bookList_class.jsp")
                .build();
        
        setPageInfo(model);

        return "layout";
    }

    // 3) 대출 베스트 100 도서 목록
    @GetMapping("/loan")
    public String getBookListByLoan100(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
									   Model model) {
    	
    	BookListResponse bookListResponse = bookService.getBookListByLoanCount(page);
    	
    	model.addAttribute("totalCount", bookListResponse.getTotalCount());
    	model.addAttribute("totalPage", bookListResponse.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	if (bookListResponse.getTotalCount() > 0) {
    		model.addAttribute("bookList", bookListResponse.getBookList());
    	} else {
    		model.addAttribute("bookList", null);
    	}

        pageInfo = PageInfo.builder()
                .pageTitleCode("13")
                .pagePath("page/2-book/bookList_loan.jsp")
                .build();
        
        setPageInfo(model);

        return "layout";
    }

    // 4) 인기 도서 100 목록
    @GetMapping("/like")
    public String getBookListByLike100(@RequestParam(defaultValue = "1") int page,
		   							   Model model) {
    	
    	BookListResponse bookListResponse = bookService.getBookListByLikeCount(page);
    	
    	model.addAttribute("totalCount", bookListResponse.getTotalCount());
    	model.addAttribute("totalPage", bookListResponse.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	if (bookListResponse.getTotalCount() > 0) {
    		model.addAttribute("bookList", bookListResponse.getBookList());
    	} else {
    		model.addAttribute("bookList", null);
    	}

        pageInfo = PageInfo.builder()
                .pageTitleCode("14")
                .pagePath("page/2-book/bookList_like.jsp")
                .build();
        
        setPageInfo(model);

        return "layout";
    }

    // 도서 상세 조회 페이지
    @GetMapping("/{category}/{booksId}")
    public String getBookDetail(@PathVariable("category") int category, 
    							@PathVariable("booksId") int booksId, 
					 		    @RequestParam(defaultValue = "1") int page,
							    RedirectAttributes redirectAttributes,
							    Model model) {
    	
    	try {
			BookDetailResponse bookDetailResponse = bookService.getBookWithReviewListById(booksId, page);
			
			model.addAttribute("book", bookDetailResponse.getBook()); // 도서 상세 정보
	    	model.addAttribute("currentPage", page); // 북 리뷰 페이징
	    	
	    	if (bookDetailResponse.getReviewListResponse() != null) {
				model.addAttribute("replyList", bookDetailResponse.getReviewListResponse().getReviewList()); // 북 리뷰 리스트
				model.addAttribute("totalCount", bookDetailResponse.getReviewListResponse().getTotalCount());
				model.addAttribute("totalPages", bookDetailResponse.getReviewListResponse().getTotalPages());
			} else {
				model.addAttribute("replyList", null);
				model.addAttribute("totalCount", 0);
				model.addAttribute("totalPages", 0);
			}
			
		} catch (Exception e) {
			log.error("도서 상세 조회 실패 : " + e);
			
			redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "도서 상세 조회에 실패하였습니다.");
			
			return "redirect:/public/books/" + category;
		}
		
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("11")
    			.pagePath("page/2-book/bookDetail.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
}
