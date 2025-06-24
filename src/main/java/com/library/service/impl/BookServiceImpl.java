package com.library.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.library.mapper.BookMapper;
import com.library.model.Book;
import com.library.service.BookService;

import lombok.RequiredArgsConstructor;

@Service("bookService")
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

    private final BookMapper bookMapper;

    /** [1] 외부 도서정보나루 API 기반 통합검색 + DB 연동정보(booksId/status) 매칭 */
    @Override
    public List<Book> searchBooksByNaru(String type, String keyword, int pageNo, int pageSize) {
        List<Book> result = new ArrayList<>();
        try {
            String serviceKey = "a12b0286b0eb37032ee7bbf8f07cbb803f960697da604553b6d0c74140b00287";
            StringBuilder apiUrl = new StringBuilder("http://data4library.kr/api/srchBooks?")
                    .append("authKey=").append(serviceKey)
                    .append("&format=json")
                    .append("&pageNo=").append(pageNo)
                    .append("&pageSize=").append(pageSize);

            if (keyword != null && !keyword.trim().isEmpty()) {
                apiUrl.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
                apiUrl.append("&searchType=").append(type);
            }
            System.out.println("[API URL] " + apiUrl);

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
            System.out.println("[API RESPONSE] " + response);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response);
            JsonNode docsNode = root.path("response").path("docs");

            for (JsonNode node : docsNode) {
                JsonNode book = node.path("doc");
                Book b = new Book();
                b.setTitle(book.path("bookname").asText());
                b.setAuthor(book.path("authors").asText());
                b.setPublisher(book.path("publisher").asText());
                String year = book.path("publication_year").asText();
                if (year != null && !year.isEmpty()) {
                    try {
                        b.setPublishDate(Timestamp.valueOf(year + "-01-01 00:00:00"));
                    } catch (Exception e) {
                        b.setPublishDate(null);
                    }
                }
                String isbn13 = book.has("isbn13") ? book.path("isbn13").asText() : book.path("isbn").asText();
                b.setIsbn(isbn13);
                b.setCategory(book.path("class_no").asText());
                b.setImageLink(book.path("bookImageURL").asText());
                b.setDescription(null);
                // 기본값: 외부책(booksId=0)
                b.setBooksId(0);
                b.setCreateDate(null);
                b.setLoanCount(0);
                b.setLikeCount(0);
                b.setStatus(0);
                result.add(b);
            }

            // === [중요] API 결과와 내 DB 도서 매칭 ===
            List<Book> dbBooks = bookMapper.getAllBooks();
            Map<String, Book> dbIsbnMap = new HashMap<>();
            for (Book dbBook : dbBooks) {
                if (dbBook.getIsbn() != null)
                    dbIsbnMap.put(dbBook.getIsbn().replaceAll("-", "").trim(), dbBook);
            }
            for (Book apiBook : result) {
                String normIsbn = apiBook.getIsbn() != null ? apiBook.getIsbn().replaceAll("-", "").trim() : "";
                if (dbIsbnMap.containsKey(normIsbn)) {
                    Book db = dbIsbnMap.get(normIsbn);
                    apiBook.setBooksId(db.getBooksId());
                    apiBook.setStatus(db.getStatus());
                    // 필요하다면 createDate, loanCount 등도 추가로 세팅 가능
                }
            }

            // ISBN 단독검색일 때 완전일치만 필터링 (이하 생략 가능)
            if ("isbn".equals(type) && keyword != null && !keyword.trim().isEmpty()) {
                List<Book> filtered = new ArrayList<>();
                for (Book b : result) {
                    if (b.getIsbn() != null && b.getIsbn().replaceAll("-", "").trim().equals(keyword.replaceAll("-", "").trim())) {
                        filtered.add(b);
                    }
                }
                return filtered;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /** [2] 외부 API 검색 결과 개수 */
    @Override
    public int getSearchBookCount(String type, String keyword) {
        try {
            String serviceKey = "a12b0286b0eb37032ee7bbf8f07cbb803f960697da604553b6d0c74140b00287";
            StringBuilder apiUrl = new StringBuilder("http://data4library.kr/api/srchBooks?");
            apiUrl.append("authKey=").append(serviceKey)
                  .append("&format=json")
                  .append("&pageNo=1")
                  .append("&pageSize=1");

            if (keyword != null && !keyword.trim().isEmpty()) {
                apiUrl.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
                apiUrl.append("&searchType=").append(type);
            }

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

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response);
            JsonNode responseNode = root.path("response");
            int numFound = responseNode.path("numFound").asInt(0);

            return numFound;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ========== DB 직접 연동 ==========

    @Override
    public List<Book> getAllBooks() {
        return bookMapper.getAllBooks();
    }

    @Override
    public List<String> getAllIsbnList() {
        List<Book> dbBooks = getAllBooks();
        List<String> isbnList = new ArrayList<>();
        for (Book b : dbBooks) {
            if (b.getIsbn() != null) isbnList.add(b.getIsbn().trim());
        }
        return isbnList;
    }

    @Override
    public Map<String, Integer> getDbStatusMap() {
        List<Book> dbBooks = getAllBooks();
        Map<String, Integer> statusMap = new HashMap<>();
        for (Book b : dbBooks) {
            if (b.getIsbn() != null)
                statusMap.put(b.getIsbn().trim(), b.getStatus());
        }
        return statusMap;
    }

    @Override
    public Book getBookByIsbn(String isbn) {
        if (isbn == null) return null;
        return bookMapper.getBookByIsbn(isbn.trim());
    }

    @Override
    public List<Book> getBooksByClassNo(String classNo, int pageNo, int pageSize) {
        int offset = (pageNo - 1) * pageSize;
        return bookMapper.getBooksByClassNo(classNo, offset, pageSize);
    }

    @Override
    public int getBooksCountByClassNo(String classNo) {
        return bookMapper.getBooksCountByClassNo(classNo);
    }

    @Override
    public List<Book> getPopularBooksByLike100() {
        return bookMapper.getPopularBooksByLike();
    }

    @Override
    public List<Book> getBestBooksByLoan100() {
        return bookMapper.getBestBooksByLoan();
    }

    @Override
    public Book getBookById(int booksId) {
        return bookMapper.getBookById(booksId);
    }

    // ========== 관리자 전용 (추가/수정/삭제 등) ==========

    @Override
    public int insertBook(Book book) {
        return bookMapper.insertBook(book);
    }

    @Override
    public int updateBookInfo(Book book) {
        return bookMapper.updateBookInfo(book);
    }

    @Override
    public int updateBookDisable(int booksId) {
        return bookMapper.updateBookDisable(booksId);
    }

    @Override
    public int updateBookEnable(int booksId) {
        return bookMapper.updateBookEnable(booksId);
    }

    @Override
    public int deleteBook(int booksId) {
        return bookMapper.deleteBook(booksId);
    }
}
