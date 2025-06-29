package com.library.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.library.exception.LoanNotAllowedException;
import com.library.mapper.BookMapper;
import com.library.model.SearchRequest;
import com.library.model.book.Book;
import com.library.model.book.BookDetailResponse;
import com.library.model.book.BookListRequest;
import com.library.model.book.BookListResponse;
import com.library.model.book.ReviewListResponse;
import com.library.model.member.Member;
import com.library.model.status.BookHistoryStatus;
import com.library.model.status.MemberStatus;
import com.library.service.BookService;
import com.library.service.MemberBookHistoryService;
import com.library.service.MemberService;
import com.library.service.ReviewService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("bookService")
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookMapper bookMapper; // 책
    private final ReviewService reviewService; // 책 리뷰
    
    private final MemberService memberService; // 대출, 반납 회원
    private final MemberBookHistoryService memberBookHistoryService; // 대출, 반납 기록
    
    private static final int BOOKS_PER_PAGE = 7; // 한 페이지당 게시글 수
    private static final int MAX_LOAN_COUNT = 9; // 최대 대출 가능한 도서 권수: 10권(0~9)
    
    @Value("${book.seach.api.key}")
    private String apiKey;

    // 조회
    // 1) 전체 목록 조회 - 통합검색
    @Override
    public BookListResponse getBookList(int currentPage) {
    	
    	int totalCount = getBookListCount(); // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / BOOKS_PER_PAGE);
    	int startRow = (currentPage - 1) * BOOKS_PER_PAGE;
    	int endRow = currentPage * BOOKS_PER_PAGE;
    	
    	BookListRequest bookListRequest = BookListRequest.builder()
    			.category(null)
    			.searchRequest(null)
    			.startRow(startRow)
				.endRow(endRow)
    			.build();
    	
    	List<Book> bookList = bookMapper.getBookList(bookListRequest);
    	
        return BookListResponse.builder()
        		.bookList(bookList)
        		.totalCount(totalCount)
        		.totalPages(totalPages)
        		.build();
    }
    
    // 2) 카테고리별 목록 조회 - 주제별검색
    @Override
    public BookListResponse getBookListByClassNo(String category, int currentPage) {
        
    	int totalCount = getBookListCount(); // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / BOOKS_PER_PAGE);
    	int startRow = (currentPage - 1) * BOOKS_PER_PAGE;
    	int endRow = currentPage * BOOKS_PER_PAGE;
    	
    	BookListRequest bookListRequest = BookListRequest.builder()
    			.category(category)
    			.searchRequest(null)
    			.startRow(startRow)
				.endRow(endRow)
    			.build();
    	
    	List<Book> bookList = bookMapper.getBookListByCategory(bookListRequest);
    	
        return BookListResponse.builder()
        		.bookList(bookList)
        		.totalCount(totalCount)
        		.totalPages(totalPages)
        		.build();
    }
    
    // 3) LoanCount 기준 목록 조회 - 대출 베스트
    @Override
    public BookListResponse getBookListByLoanCount(int currentPage) {
    	
    	int totalCount = 100; // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / BOOKS_PER_PAGE);
    	int startRow = (currentPage - 1) * BOOKS_PER_PAGE;
    	int endRow = currentPage * BOOKS_PER_PAGE;
    	
    	BookListRequest bookListRequest = BookListRequest.builder()
    			.category(null)
    			.searchRequest(null)
    			.startRow(startRow)
				.endRow(endRow)
    			.build();
    	
    	List<Book> bookList = bookMapper.getBookListByLoanCount(bookListRequest);
    	
        return BookListResponse.builder()
        		.bookList(bookList)
        		.totalCount(totalCount)
        		.totalPages(totalPages)
        		.build();
    }
    
    // 4) LikeCount 기준 목록 조회 - 인기도서
    @Override
    public BookListResponse getBookListByLikeCount(int currentPage) {
    	
    	int totalCount = 100; // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / BOOKS_PER_PAGE);
    	int startRow = (currentPage - 1) * BOOKS_PER_PAGE;
    	int endRow = currentPage * BOOKS_PER_PAGE;
    	
    	BookListRequest bookListRequest = BookListRequest.builder()
    			.category(null)
    			.searchRequest(null)
    			.startRow(startRow)
				.endRow(endRow)
    			.build();
    	
    	List<Book> bookList = bookMapper.getBookListByLikeCount(bookListRequest);
    	
        return BookListResponse.builder()
        		.bookList(bookList)
        		.totalCount(totalCount)
        		.totalPages(totalPages)
        		.build();
        
    }
    
    // 키워드 조회
    // DB 통합검색
    @Override
    public BookListResponse getBookListByKeywordByDB(String type, String keyword, int currentPage) {
    	
    	SearchRequest searchRequest = SearchRequest.builder()
    			.type(type)
    			.keyword(keyword)
    			.build();
    	
    	int totalCount = getBookListCountByKeyword(searchRequest); // 전체 개수
    	int totalPages = (int)Math.ceil((double)totalCount / BOOKS_PER_PAGE);
    	int startRow = (currentPage - 1) * BOOKS_PER_PAGE;
    	int endRow = currentPage * BOOKS_PER_PAGE;
    	
    	BookListRequest bookListRequest = BookListRequest.builder()
    			.category(null)
    			.searchRequest(searchRequest)
    			.startRow(startRow)
    			.endRow(endRow)
    			.build();
    	
    	List<Book> bookList = bookMapper.getBookListByKeyword(bookListRequest);
    	
    	return BookListResponse.builder()
    			.bookList(bookList)
    			.totalCount(totalCount)
    			.totalPages(totalPages)
    			.build();
    }
    
    // 도서정보나루 API 기반 통합검색
    @Override
    public BookListResponse getBookListByKeywordByExtAPI(String type, String keyword, int currentPage) {
    	
    	int totalCount = 0;
    	int totalPages = 0;
    	List<Book> bookList = null;
    	
    	try {
    		String serviceKey = apiKey;
    		StringBuilder apiUrl = new StringBuilder("http://data4library.kr/api/srchBooks?")
    				.append("authKey=").append(URLEncoder.encode(serviceKey, "UTF-8"))
    				.append("&format=json");
    		
    		if (keyword != null && !keyword.trim().isEmpty()) {
    			String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
    			
    			// type이 title, author, publisher 중 하나일 때만 해당 파라미터로 추가
    			if ("title".equals(type) || "author".equals(type) || "publisher".equals(type)) {
    				apiUrl.append("&").append(type).append("=").append(encodedKeyword);
    			} else {
    				// 그 외에는 keyword 파라미터로 처리
    				apiUrl.append("&keyword=").append(encodedKeyword);
    			}
    		}
    		
    		log.info("[API URL] " + apiUrl);
    		
    		URL url = new URL(apiUrl.toString());
    		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    		conn.setRequestMethod("GET");
    		conn.setConnectTimeout(5000);
    		
    		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    		StringBuilder sb = new StringBuilder();
    		String line;
    		while ((line = br.readLine()) != null) sb.append(line);
    		br.close();
    		
    		String response = sb.toString();
    		log.info("[API RESPONSE] " + response);
    		
    		ObjectMapper mapper = new ObjectMapper();
    		JsonNode root = mapper.readTree(response);
    		
    		// 전체 개수 추출
    		totalCount = root.path("response").path("numFound").asInt();
    		totalPages = (int) Math.ceil((double) totalCount / BOOKS_PER_PAGE);
    		
    		// 도서 정보 추출
    		JsonNode docsNode = root.path("response").path("docs");
    		bookList = new ArrayList<>();
    		
    		for (JsonNode node : docsNode) {
    			JsonNode bookNode = node.path("doc");
    			
    			// 데이터 가공
    			String year = bookNode.path("publication_year").asText();
    			Timestamp publishDate = null;
    			if (year != null && !year.isEmpty()) {
    				try {
    					publishDate = Timestamp.valueOf(year + "-01-01 00:00:00");
    				} catch (Exception e) {
    					log.error("날짜 변환 에러 : " + e);
    				}
    			}
    			String isbn = bookNode.has("isbn13") 
    					? bookNode.path("isbn13").asText() 
    							: bookNode.path("isbn").asText();
    			
    			
    			Book book = Book.builder()
    					.booksId(0) // 외부책
    					.title(bookNode.path("bookname").asText())
    					.author(bookNode.path("authors").asText())
    					.publisher(bookNode.path("publisher").asText())
    					.publishDate(publishDate)
    					.isbn(isbn)
    					.category(bookNode.path("class_no").asText())
    					.imageLink(bookNode.path("bookImageURL").asText())
    					.description(bookNode.path("bookDtlUrl").asText())
    					.build();
    			
    			bookList.add(book);
    		}
    		
    	} catch (Exception e) {
    		log.error("도서 API 호출 중 오류 발생 : ", e);
    		
    	}
    	return BookListResponse.builder()
    			.bookList(bookList)
    			.totalCount(totalCount)
    			.totalPages(totalPages)
    			.build();
    }
    
    // 목록 개수 (페이징용)
    // 1) 전체 목록 개수
    @Override
    public int getBookListCount() {
        return bookMapper.getBookListCount();
    }
    
    // 2) 카테고리별 목록 개수
    @Override
    public int getBookListCountByClassNo(String category) {
        return bookMapper.getBookListCountByCategory(category);
    }
    
    // 3) 키워드 조회 목록 개수
    @Override
    public int getBookListCountByKeyword(SearchRequest searchRequest) {
        return bookMapper.getBookListCountByKeyword(searchRequest);
    }
    
    
    // 상세 조회
    // 1) 상세 조회 (북 리뷰 포함)
    @Override
    public BookDetailResponse getBookWithReviewListById(int booksId, int reviewCurrentPage) {
    	
    	// 도서 정보 가져오기
	    Book book = bookMapper.getBookById(booksId);

	    // 기본 값 설정
	    ReviewListResponse reviewListResponse = null;
	    
	    if (book != null) {
	    	if (book.getReviewCount() > 0) {
	    		reviewListResponse = reviewService.getReviewListByBooksId(book.getBooksId(), reviewCurrentPage);
	    	}
	    }
    	
    	return BookDetailResponse.builder()
	            .book(book)
	            .reviewListResponse(reviewListResponse)
	            .build();
    }
    
    // 2) 수정용 상세 조회 (북 리뷰 제외)
	@Override
	public Book getBookById(int booksId) {
		return bookMapper.getBookById(booksId);
	}
    
    // 수정
    // 1) 책 정보 수정
    @Override
    public int updateBookInfo(Book book) {
        return bookMapper.updateBookInfo(book);
    }

    // 2) 도서 비공개 (soft del)
    @Override
    public int updateBookDisable(int booksId) {
        return bookMapper.updateBookDisable(booksId);
    }
    
	// 3) 대여중으로 변경
	@Override
	public int updateBookLoaned(int booksId) {
		return bookMapper.updateBookLoaned(booksId);
	}
	
	// 4) 대여가능으로 변경
	@Override
	public int updateBookLoanable(int booksId) {
		return bookMapper.updateBookLoanable(booksId);
	}
	
	// 4) 대출 예약 중으로 변경
	@Override
	public int updateBookLoanReserved(int booksId) {
		return bookMapper.updateBookLoanReserved(booksId);
	}
	
	// 6) 책 조회수 증가
    @Override
	public int updateBookViewCountUp(int booksId) {
		return bookMapper.updateBookViewCountUp(booksId);
	}
    
    // 7) 책 리뷰 개수 증가
	@Override
	public int updateBookReviewCountUp(int booksId) {
		return bookMapper.updateBookReviewCountUp(booksId);
	}
	
	// 8) 책 리뷰 개수 감소
	@Override
	public int updateBookReviewCountDown(int booksId) {
		return bookMapper.updateBookReviewCountDown(booksId);
	}
	
	// 9) 대출 누적수 증가
	@Override
	public int updateBookLoanCountUp(int booksId) {
		return bookMapper.updateBookLoanCountUp(booksId);
		
	}
	
	// 10) 찜 누적수 증가
	@Override
	public int updateBookLikeCountUp(int booksId) {
		return bookMapper.updateBookLikeCountUp(booksId);
	}
	
	// 도서 추가
	@Override
    public int insertBook(Book book) {
        return bookMapper.insertBook(book);
    }
	
	// 도서 삭제 (hard del)
    @Override
    public int deleteBook(int booksId) {
        return bookMapper.deleteBook(booksId);
    }
    
    // 기타 처리
    // 대출 처리
    @Transactional(rollbackFor = Exception.class)
    @Override
 	public void loanBook(int booksId, int membersId) {
    	// 대출 가능한 지 확인
    	Member member = memberService.getMemberById(membersId);
    	
    	// 준회원, 대출정지 회원, 대출권수가 10권을 넘는 회원은 불가능
    	if (member != null) {
    		int status = member.getStatus();
    		if (status == MemberStatus.JUNIOR.getCode()) {
    			throw new LoanNotAllowedException("준회원은 대출이 불가능 합니다.");
    		} else if (status == MemberStatus.LOAN_HOLD.getCode()) {
    			throw new LoanNotAllowedException("대출 정지되어 대출이 불가능 합니다.");
    		} else if (member.getLoanCount() == MAX_LOAN_COUNT) {
    			throw new LoanNotAllowedException("합계 10권 이상은 대출이 불가능 합니다.");
    		}
    	}
		
		// 1) 도서 : 대출중으로 처리
		updateBookLoaned(booksId);
		// 2) 회원 : 대출권수 증가
        memberService.updateMemberLoanCountUp(membersId);
        // 3) 회원 : 도서 이용 정보에 추가
        memberBookHistoryService.insertBookHistory(membersId, booksId, BookHistoryStatus.LOANING.getCode());
 	}
 	
 	// 반납 처리
    @Transactional(rollbackFor = Exception.class)
    @Override
 	public void returnBook(int booksId, int membersId) {
    	// 1) 도서 : 정상(대출가능)으로 처리
		updateBookLoanable(booksId);
		// 2) 회원 : 대출권수 감소
        memberService.updateMemberLoanCountDown(membersId);
        // 3) 회원 : 도서 이용 정보에 추가
        memberBookHistoryService.insertBookHistory(membersId, booksId, BookHistoryStatus.RETURNED.getCode());
 	}
	
}
