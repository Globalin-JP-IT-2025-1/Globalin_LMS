package com.library.controller.book;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.library.model.Book;
import com.library.model.PageInfo;
import com.library.service.BookService;
import com.library.service.MemberBookHistoryService;
import com.library.service.MemberBookLikeService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/public/books")
@AllArgsConstructor
public class PublicBookController {
    private final BookService bookService;
    private final MemberBookHistoryService memberBookHistoryService; // 대출 서비스
    private final MemberBookLikeService memberBookLikeService;       // 찜 서비스
    private PageInfo pageInfo;

    // 카테고리 한글명 변환용
    private static final Map<String, String> CLASS_NO_MAP = new HashMap<>();
    static {
        CLASS_NO_MAP.put("000", "총류");
        CLASS_NO_MAP.put("100", "철학");
        CLASS_NO_MAP.put("200", "종교");
        CLASS_NO_MAP.put("300", "사회과학");
        CLASS_NO_MAP.put("400", "자연과학");
        CLASS_NO_MAP.put("500", "기술과학");
        CLASS_NO_MAP.put("600", "예술");
        CLASS_NO_MAP.put("700", "언어");
        CLASS_NO_MAP.put("800", "문학");
        CLASS_NO_MAP.put("900", "역사");
    }

    /** pageInfo 세팅 공통 함수 */
    public void setPageInfo(Model model) {
        model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
        model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    /** [1] 통합검색(외부 API+내DB ISBN 중복방지) */
    @GetMapping("/total")
    public String getAllBooksTotal(
        Model model,
        @RequestParam(value = "type", required = false, defaultValue = "title") String type,
        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
        @RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo
    ) {
        List<Book> bookList;
        int totalCount = 0;
        if (keyword == null || keyword.trim().isEmpty()) {
            bookList = java.util.Collections.emptyList();
        } else {
            bookList = bookService.searchBooksByNaru(type, keyword, pageNo, 10);
            totalCount = bookService.getSearchBookCount(type, keyword);
            if ("isbn".equalsIgnoreCase(type)) {
                Book dbBook = bookService.getBookByIsbn(keyword);
                if (dbBook != null) {
                    boolean notExists = bookList.stream()
                        .noneMatch(b -> b.getIsbn() != null && b.getIsbn().equals(dbBook.getIsbn()));
                    if (notExists) {
                        bookList.add(0, dbBook);
                    }
                }
            }
        }
        int pageSize = 10;
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        // DB에 등록된 ISBN 배열로 변환해서 전달
        List<String> dbIsbnList = bookService.getAllIsbnList();
        for (int i = 0; i < dbIsbnList.size(); i++) {
            dbIsbnList.set(i, dbIsbnList.get(i).replaceAll("-", "").trim());
        }
        String[] dbIsbnArr = dbIsbnList.toArray(new String[0]);
        model.addAttribute("dbIsbnList", dbIsbnArr);

        model.addAttribute("bookList", bookList);
        model.addAttribute("dbStatusMap", bookService.getDbStatusMap());
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("currentPage", pageNo);

        pageInfo = PageInfo.builder()
                .pageTitleCode("11")
                .pagePath("page/2-book/bookList_total.jsp")
                .build();
        setPageInfo(model);

        return "layout";
    }

    /** [2] 주제별(카테고리별) 검색 */
    @GetMapping("/class")
    public String getAllBooksClass(
        Model model,
        @RequestParam(value = "class_no", required = false, defaultValue = "") String classNo,
        @RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo
    ) {
        String categoryKeyword = CLASS_NO_MAP.containsKey(classNo) ? CLASS_NO_MAP.get(classNo) : classNo;
        List<Book> bookList = bookService.getBooksByClassNo(categoryKeyword, pageNo, 10);

        Map<String, Integer> dbStatusMap = bookService.getDbStatusMap();
        model.addAttribute("bookList", bookList);
        model.addAttribute("dbStatusMap", dbStatusMap);
        model.addAttribute("classNo", classNo);
        model.addAttribute("currentPage", pageNo);

        int totalCount = bookService.getBooksCountByClassNo(categoryKeyword);
        int pageSize = 10;
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPage", totalPage);

        pageInfo = PageInfo.builder()
                .pageTitleCode("12")
                .pagePath("page/2-book/bookList_class.jsp")
                .build();
        setPageInfo(model);

        return "layout";
    }

    /** [3] 대출 순 도서 목록 (대출베스트: 대출횟수순 TOP 100) */
    @GetMapping("/loan")
    public String getAllBooksLoan(Model model) {
        List<Book> bookList = bookService.getBestBooksByLoan100(); // TOP 100
        model.addAttribute("bookList", bookList);
        model.addAttribute("dbStatusMap", bookService.getDbStatusMap());

        pageInfo = PageInfo.builder()
                .pageTitleCode("13")
                .pagePath("page/2-book/bookList_loan.jsp")
                .build();

        setPageInfo(model);
        return "layout";
    }

    /** [4] 찜(좋아요) 순 도서 목록 (인기도서: 찜순 TOP 100) */
    @GetMapping("/like")
    public String getAllBooksLike(Model model) {
        List<Book> bookList = bookService.getPopularBooksByLike100(); // TOP 100
        model.addAttribute("bookList", bookList);
        model.addAttribute("dbStatusMap", bookService.getDbStatusMap());

        pageInfo = PageInfo.builder()
                .pageTitleCode("14")
                .pagePath("page/2-book/bookList_like.jsp")
                .build();

        setPageInfo(model);
        return "layout";
    }

    // 도서 상세 조회 페이지 (책 PK로)
    @GetMapping("/detail")
    public String getBookDetail(
        Model model,
        @RequestParam("booksId") int booksId
    ) {
        if (booksId == 0) {
            model.addAttribute("errorMsg", "등록된 책만 상세조회가 가능합니다.");
            model.addAttribute("book", null);
        } else {
            Book book = bookService.getBookById(booksId);
            if (book == null) {
                model.addAttribute("errorMsg", "등록된 책 정보를 찾을 수 없습니다.");
                model.addAttribute("book", null);
            } else {
                model.addAttribute("book", book);
            }
        }

        pageInfo = PageInfo.builder()
                .pageTitleCode("15")
                .pagePath("page/2-book/bookDetail.jsp")
                .build();
        setPageInfo(model);

        return "layout";
    }

    /*** === 대출/찜 버튼 동작용 POST 매핑 === ***/

    // 도서 대출 (BookHistory 테이블에 insert)
    @PostMapping("/loan")
    public String loanBook(@RequestParam("booksId") int booksId, HttpSession session) {
        Integer membersId = (Integer) session.getAttribute("loginMemberId"); // 세션명은 실제 프로젝트에 맞게!
        if (membersId == null) {
        	return "redirect:/public/auth/login";
        }
        // 실제 대출 기록
        memberBookHistoryService.insertBookHistory(membersId, booksId);
        return "redirect:/public/books/detail?booksId=" + booksId;
    }

    // 도서 찜(Like) (BookLike 테이블에 insert)
    @PostMapping("/like")
    public String likeBook(@RequestParam("booksId") int booksId, HttpSession session) {
        Integer membersId = (Integer) session.getAttribute("loginMemberId"); // 세션명은 실제 프로젝트에 맞게!
        if (membersId == null) {
        	return "redirect:/public/auth/login";
        }
        // 실제 찜 기록
        memberBookLikeService.insertBookLike(membersId, booksId);
        return "redirect:/public/books/detail?booksId=" + booksId;
    }
}
