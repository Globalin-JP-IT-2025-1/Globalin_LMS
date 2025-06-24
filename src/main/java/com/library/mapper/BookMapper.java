package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.library.model.Book;

@Mapper
public interface BookMapper {
    /**
     * [1] 내 DB 전체 도서 목록 반환
     * @return 전체 Book 리스트
     */
    List<Book> getAllBooks(); // 도서 전체 조회

    /**
     * [2] ISBN으로 단일 도서 상세 조회 (정확히 일치하는 ISBN)
     * @param isbn ISBN (문자열)
     * @return Book 객체 (없으면 null)
     */
    Book getBookByIsbn(String isbn);

    /**
     * [3] 주제별(카테고리)로 도서 페이징 목록 조회
     * @param classNo  분류코드(예: "000", "100", ...)
     * @param offset   결과 시작 위치 (0부터 시작)
     * @param limit    가져올 개수(한 페이지 크기)
     * @return Book 리스트
     */
    List<Book> getBooksByClassNo(
        @Param("classNo") String classNo,
        @Param("offset") int offset,
        @Param("limit") int limit
    );

    /**
     * [4] 주제별(카테고리별) 전체 도서 개수 반환
     * @param classNo 분류코드 또는 카테고리명
     * @return 해당 카테고리의 도서 개수
     */
    int getBooksCountByClassNo(String classNo);

    // ======================== 추가 ========================
    /**
     * [5] 인기도서(찜 많은 순) TOP 100 반환
     * @return LIKE_COUNT 내림차순 Book 리스트(100개)
     */
    List<Book> getPopularBooksByLike();

    /**
     * [6] 대출베스트(대출 많은 순) TOP 100 반환
     * @return LOAN_COUNT 내림차순 Book 리스트(100개)
     */
    List<Book> getBestBooksByLoan();
    
    /**
     * [상세조회] PK(booksId)로 BOOK 한 권 조회
     */
    Book getBookById(@Param("booksId") int booksId);
    
    // 도서 등록 (관리자)
    int insertBook(Book book);

    // 도서 정보 수정 (관리자)
    int updateBookInfo(Book book);

    // 도서 상태 비활성화 (관리자)
    int updateBookDisable(@Param("booksId") int booksId);

    // 도서 상태 활성화 (관리자)
    int updateBookEnable(@Param("booksId") int booksId);

    // 도서 삭제 (관리자)
    int deleteBook(@Param("booksId") int booksId);

}
