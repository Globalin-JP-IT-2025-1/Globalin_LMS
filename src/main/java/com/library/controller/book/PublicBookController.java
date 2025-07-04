package com.library.controller.book;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.book.Book;
import com.library.model.book.BookListResponse;
import com.library.model.status.BookStatus;
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
    public String getBookListByTotal(
            @RequestParam(value = "searchType", required = false, defaultValue = "title") String type,
            @RequestParam(value = "searchKeyword", required = false, defaultValue = "") String keyword,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            Model model) {

        BookListResponse bookListResponse;

        // 검색 여부 판단
        boolean isSearching = keyword != null && !keyword.trim().isEmpty();

        if (isSearching) {
            bookListResponse = bookService.getBookListByKeywordByDB(type, keyword, page);
        } else {
            bookListResponse = bookService.getBookList(page);
        }

        // 검색 조건은 무조건 model에 넣어줘야 JSP에서 유지됨
        model.addAttribute("searchType", type);
        model.addAttribute("searchKeyword", keyword);

        // 페이징 관련 정보
        model.addAttribute("totalCount", bookListResponse.getTotalCount());
        model.addAttribute("totalPages", bookListResponse.getTotalPages());
        model.addAttribute("currentPage", page);

        if (bookListResponse.getTotalCount() > 0) {
            model.addAttribute("bookList", bookListResponse.getBookList());
        } else {
            model.addAttribute("bookList", null);
        }

        // 페이지 정보 설정
        pageInfo = PageInfo.builder()
                .pageTitleCode("11")
                .pagePath("page/2-book/bookList_total.jsp")
                .build();

        setPageInfo(model);

        return "layout";
    }


    // 2) 주제별(카테고리별) 전체 목록
    @GetMapping("/class")
    public String getBookListByClassNo(
            @RequestParam(value = "class_no", required = false, defaultValue = "0") String classNo,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            Model model) {

        BookListResponse bookListResponse = bookService.getBookListByCategory(classNo, page);

        // 페이징 링크 유지를 위해
        model.addAttribute("classNo", classNo);

        // 페이징 정보
        model.addAttribute("totalCount", bookListResponse.getTotalCount());
        model.addAttribute("totalPages", bookListResponse.getTotalPages());
        model.addAttribute("currentPage", page);

        // 도서 목록
        if (bookListResponse.getTotalCount() > 0) {
            model.addAttribute("bookList", bookListResponse.getBookList());
        } else {
            model.addAttribute("bookList", null);
        }

        // 페이지 정보 설정
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
    	model.addAttribute("totalPages", bookListResponse.getTotalPages());
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
    	model.addAttribute("totalPages", bookListResponse.getTotalPages());
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
    @GetMapping("/{booksId}")
    public String getBookDetail(@PathVariable("booksId") int booksId, 
					 		    HttpServletRequest request,
							    RedirectAttributes redirectAttributes,
							    Model model) {
    	
    	try {
			Book book = bookService.getBookById(booksId);
			
			// 비활성화된 도서인 경우 실패 처리
			if (book.getStatus() == BookStatus.DISABLE.getCode()) {
				redirectAttributes.addFlashAttribute("alertType", "error");
				redirectAttributes.addFlashAttribute("alertMesssage", "도서 상세 조회에 실패하였습니다.");
				
				String referer = request.getHeader("Referer");
				return "redirect:" + (referer != null ? referer : "/public/books/total");
			}
			
			model.addAttribute("book", book); // 도서 상세 정보
	    	
		} catch (Exception e) {
			log.error("도서 상세 조회 실패 : " + e);
			
			redirectAttributes.addFlashAttribute("alertType", "error");
			redirectAttributes.addFlashAttribute("alertMesssage", "도서 상세 조회에 실패하였습니다.");
			
			String referer = request.getHeader("Referer");
			return "redirect:" + (referer != null ? referer : "/public/books/total");
		}
		
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("11")
    			.pagePath("page/2-book/bookDetail.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
}
