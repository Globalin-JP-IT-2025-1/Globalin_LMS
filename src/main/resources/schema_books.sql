-- 테이블 생성
CREATE TABLE BOOKS (
  BOOKS_ID       NUMBER             PRIMARY KEY,                       -- 도서ID
  TITLE          VARCHAR2(200)      NOT NULL,                          -- 제목
  AUTHOR         VARCHAR2(100)      NOT NULL,                          -- 저자
  PUBLISHER      VARCHAR2(100)		NOT NULL,                          -- 출판사
  PUBLISH_DATE   DATE				NOT NULL,                                                 -- 출판일자
  ISBN           VARCHAR2(20),				                           -- ISBN
  CATEGORY       VARCHAR2(100)      NOT NULL,                          -- 카테고리
  IMAGE_LINK     VARCHAR2(300)      DEFAULT 'DEFAULT.PNG',             -- 썸네일
  DESCRIPTION    VARCHAR2(1000),                                       -- 설명
  CREATE_DATE    DATE               DEFAULT SYSDATE NOT NULL,
  VIEW_COUNT     NUMBER(9)          DEFAULT 0       NOT NULL,
  LOAN_COUNT     NUMBER(9)          DEFAULT 0       NOT NULL,
  LIKE_COUNT     NUMBER(9)          DEFAULT 0       NOT NULL,
  STATUS         NUMBER(1)          DEFAULT 0       NOT NULL           -- 상태 (0: 기본, 1: 대여중, 2: 대여예약중)
);

-- 시퀀스 생성
CREATE SEQUENCE SQ_BOOKS
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 인덱스 생성
CREATE INDEX IDX_BOOKS_ISBN        ON BOOKS (ISBN);          -- ISBN으로 탐색
CREATE INDEX IDX_BOOKS_TITLE       ON BOOKS (TITLE);         -- 제목 키워드 탐색
CREATE INDEX IDX_BOOKS_AUTHOR      ON BOOKS (AUTHOR);        -- 작성자 키워드 탐색
CREATE INDEX IDX_BOOKS_CATEGORY    ON BOOKS (CATEGORY);      -- 카테고리 필터링
CREATE INDEX IDX_BOOKS_LIKE_COUNT  ON BOOKS (LIKE_COUNT);    -- 평점수순 정렬
