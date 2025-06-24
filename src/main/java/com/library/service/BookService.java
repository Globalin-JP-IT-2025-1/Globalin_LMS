package com.library.service;

import java.util.List;
import java.util.Map;

import com.library.model.Book;

public interface BookService {

    // ===== DB 직접 연동 =====

    /** 전체 도서 목록(관리자/회원 공통) */
    List<Book> getAllBooks();

    /** 도서 상세 조회 (PK) */
    Book getBookById(int booksId);

    /** 도서 추가(관리자) */
    int insertBook(Book book);

    /** 도서 정보 수정(관리자) */
    int updateBookInfo(Book book);

    /** 도서 상태 '대여불가'로 변경(관리자) */
    int updateBookDisable(int booksId);

    /** 도서 상태 '대여가능'으로 변경(관리자) */
    int updateBookEnable(int booksId);

    /** 도서 삭제(관리자) */
    int deleteBook(int booksId);

    /** 내 DB에 등록된 모든 ISBN 리스트 반환 */
    List<String> getAllIsbnList();

    /** 내 DB의 ISBN별 대여상태 Map 반환 (0:대여가능, 1:대여중, 2:예약중 등) */
    Map<String, Integer> getDbStatusMap();

    /** ISBN 완전일치로 한 권 조회 (DB) */
    Book getBookByIsbn(String isbn);

    /** 주제별(classNo) 페이징 목록 (DB) */
    List<Book> getBooksByClassNo(String classNo, int pageNo, int pageSize);

    /** 주제별(classNo) 전체 도서 개수 (DB) */
    int getBooksCountByClassNo(String classNo);

    /** 대출 횟수 순 TOP 100 (DB) */
    List<Book> getBestBooksByLoan100();

    /** 찜(좋아요) 순 TOP 100 (DB) */
    List<Book> getPopularBooksByLike100();


    // ===== 외부 도서정보나루 API 연동 =====

    /** 외부 API 통합검색 (실시간, 페이징) */
    List<Book> searchBooksByNaru(String type, String keyword, int pageNo, int pageSize);

    /** 외부 API 검색 결과 총 개수 */
    int getSearchBookCount(String type, String keyword);

}
