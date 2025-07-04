package com.library.controller.book;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.library.model.PageInfo;
import com.library.model.book.BookListResponse;
import com.library.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/admin/books")
@AllArgsConstructor
public class AdminBookAPIController {
    private final BookService bookService;
    private PageInfo pageInfo;

    public void setPageInfo(Model model) {
        model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
        model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 외부API 통합검색 전체 목록 + 키워드 검색 목록
    @GetMapping("/api")
    public ResponseEntity<BookListResponse> getBooksFromAPI(
            @RequestParam String type,
            @RequestParam String keyword,
            @RequestParam(defaultValue = "1") int currentPage) {

        BookListResponse response = bookService.getBookListByKeywordByExtAPI(type, keyword, currentPage);
        return ResponseEntity.ok(response);
    }

}
