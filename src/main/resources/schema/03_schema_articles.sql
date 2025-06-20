-- 테이블 생성
CREATE TABLE ARTICLES (
  ARTICLES_ID    NUMBER,                            					 -- 게시글ID
  AUTHOR_ID      NUMBER,                            					 -- 작성자 ID (MEMBERS.MEMBER_ID와 FK)
  CATEGORY       VARCHAR2(3)		NOT NULL,                            -- 카테고리
  TITLE          VARCHAR2(100)      NOT NULL,                            -- 제목
  CONTENT        VARCHAR2(1000)     NOT NULL,                            -- 내용
  CREATE_DATE    DATE               DEFAULT SYSDATE NOT NULL,            -- 최초등록일자
  UPDATE_DATE    DATE				NOT NULL,                            -- 최종수정일자
  REPLY_COUNT    NUMBER(9)          DEFAULT 0,                  		 -- 댓글수
  VIEW_COUNT     NUMBER(9)          DEFAULT 0,                  		 -- 조회수
  STATUS 	NUMBER(1) 			DEFAULT 0 NOT NULL,              	 -- 비밀글 여부 (0: 공개, 1: 비밀)

  -- 제약조건 명시
  CONSTRAINT PK_ARTICLES PRIMARY KEY (ARTICLES_ID),
  CONSTRAINT FK_ARTICLES_AUTHOR FOREIGN KEY (AUTHOR_ID)
    REFERENCES MEMBERS(MEMBERS_ID)
);

-- 시퀀스 생성
CREATE SEQUENCE SQ_ARTICLES
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 인덱스 생성
CREATE INDEX IDX_ARTICLES_CATEGORY     ON ARTICLES (CATEGORY);      -- 카테고리 탐색
CREATE INDEX IDX_ARTICLES_TITLE        ON ARTICLES (TITLE);         -- 제목 키워드 탐색
CREATE INDEX IDX_ARTICLES_CONTENT      ON ARTICLES (CONTENT);       -- 내용 키워드 탐색
CREATE INDEX IDX_ARTICLES_CREATE_DATE  ON ARTICLES (CREATE_DATE);   -- 등록일자 정렬
CREATE INDEX IDX_ARTICLES_VIEWS_COUNT  ON ARTICLES (VIEW_COUNT);    -- 조회수 정렬

update articles set reply_count=2 where articles_id=2;

-- 공지사항(not)
INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '시스템 점검 안내', '시스템 점검 일정에 대한 공지입니다.', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '이용 약관 변경 안내', '이용 약관이 변경되었습니다. 자세한 내용은 링크를 참조하세요.', TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '서비스 일시 중단 안내', '시스템 점검으로 서비스가 일시 중단됩니다. 양해 부탁드립니다.', TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '새로운 기능 추가 안내', '우리 사이트에 새로운 기능이 추가되었습니다. 이제 더욱 편리하게 사용하실 수 있습니다.', TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '회원 정보 변경 안내', '회원 정보 변경에 대한 방법을 안내드립니다. 자세한 사항은 홈페이지를 참고하세요.', TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '새로운 모바일 앱 출시', '새로운 모바일 앱이 출시되었습니다. 더 많은 기능을 제공하며, 다운로드는 앱스토어에서 가능합니다.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '이벤트 당첨자 발표', '이번 이벤트의 당첨자가 발표되었습니다. 자세한 사항은 홈페이지를 확인해 주세요.', TO_DATE('2025-06-07', 'YYYY-MM-DD'), TO_DATE('2025-06-07', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '서버 점검 안내', '서버 점검이 예정되어 있습니다. 점검 시간 동안 일부 서비스 이용이 불가능합니다.', TO_DATE('2025-06-08', 'YYYY-MM-DD'), TO_DATE('2025-06-08', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '회원 서비스 종료 안내', '회원 서비스가 종료됩니다. 종료 일정을 참고해 주세요.', TO_DATE('2025-06-09', 'YYYY-MM-DD'), TO_DATE('2025-06-09', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'not', '긴급 보안 패치 안내', '보안 패치가 진행됩니다. 사용자들의 개인정보 보호를 위해 필수 업데이트를 권장합니다.', TO_DATE('2025-06-10', 'YYYY-MM-DD'), TO_DATE('2025-06-10', 'YYYY-MM-DD'), 0);

-- 희망도서신청(req)
INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '책을 신청하려면 어떻게 하나요?', '희망도서 신청 방법에 대해 안내드립니다.', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '희망도서 신청 양식은 어디서 찾나요?', '희망도서 신청 양식을 확인할 수 있는 페이지를 안내드립니다.', TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '도서 신청이 제한된 경우는 언제인가요?', '도서 신청이 제한되는 경우에 대한 안내입니다.', TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '신청 도서 수량에 제한이 있나요?', '희망도서 신청 수량에 제한이 없으나, 상황에 따라 변동될 수 있습니다.', TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '희망도서 신청 후 취소할 수 있나요?', '희망도서 신청 후 취소는 불가능합니다. 신중하게 신청 부탁드립니다.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '희망도서 신청 시 서류 제출이 필요한가요?', '희망도서 신청 시 별도의 서류 제출은 필요하지 않습니다.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '희망도서 신청 기간은 언제인가요?', '희망도서 신청은 매월 1일부터 15일까지 가능합니다.', TO_DATE('2025-06-07', 'YYYY-MM-DD'), TO_DATE('2025-06-07', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '희망도서 신청 시 신청서를 어떻게 작성하나요?', '희망도서 신청서는 홈페이지에서 작성할 수 있습니다. 자세한 안내를 참고해 주세요.', TO_DATE('2025-06-08', 'YYYY-MM-DD'), TO_DATE('2025-06-08', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '희망도서 신청에 대한 자주 묻는 질문', '희망도서 신청과 관련된 자주 묻는 질문은 홈페이지 FAQ를 참조해 주세요.', TO_DATE('2025-06-09', 'YYYY-MM-DD'), TO_DATE('2025-06-09', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'req', '도서 신청 후 변경 사항은 어떻게 처리되나요?', '도서 신청 후에는 변경이 불가능합니다. 신중히 신청해 주세요.', TO_DATE('2025-06-10', 'YYYY-MM-DD'), TO_DATE('2025-06-10', 'YYYY-MM-DD'), 0);


-- 자주 묻는 질문(faq)
INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '서비스 장애 시 어떻게 해야 하나요?', '서비스 장애 발생 시 고객센터로 문의해 주세요.', TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '회원가입은 어떻게 하나요?', '회원가입 방법에 대해 안내드립니다.', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '로그인 비밀번호를 잊어버렸어요. 어떻게 하나요?', '로그인 비밀번호를 재설정하는 방법을 안내드립니다.', TO_DATE('2025-06-02', 'YYYY-MM-DD'), TO_DATE('2025-06-02', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '회원 정보를 수정하려면 어떻게 하나요?', '회원 정보 수정 방법에 대해 안내드립니다.', TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '아이디를 잊어버렸어요. 어떻게 찾을 수 있나요?', '아이디 찾기 기능을 통해 이메일로 아이디를 찾을 수 있습니다.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '비밀번호를 변경하고 싶어요. 어떻게 하나요?', '비밀번호는 "내 정보" 페이지에서 "비밀번호 변경" 메뉴를 통해 변경할 수 있습니다.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '회원 탈퇴 후 재가입이 가능한가요?', '회원 탈퇴 후 30일 이내에는 재가입이 불가능합니다.', TO_DATE('2025-06-07', 'YYYY-MM-DD'), TO_DATE('2025-06-07', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '내 정보 수정은 어떻게 하나요?', '회원 정보 수정은 "내 정보" 페이지에서 가능합니다. 개인정보를 최신 상태로 유지해 주세요.', TO_DATE('2025-06-08', 'YYYY-MM-DD'), TO_DATE('2025-06-08', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '회원 가입 후 확인 메일이 오지 않아요. 어떻게 하나요?', '가입 후 확인 메일이 오지 않으면 스팸 메일함을 확인하거나, 메일을 재발송해 보세요.', TO_DATE('2025-06-09', 'YYYY-MM-DD'), TO_DATE('2025-06-09', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'faq', '아이디와 비밀번호를 동시에 잊어버렸어요. 어떻게 해야 하나요?', '아이디와 비밀번호를 모두 잊어버린 경우, 이메일을 통해 계정 복구 절차를 진행할 수 있습니다.', TO_DATE('2025-06-10', 'YYYY-MM-DD'), TO_DATE('2025-06-10', 'YYYY-MM-DD'), 0);


-- QNA
INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '회원가입 시 이메일 인증이 안돼요. 어떻게 해야 하나요?', '이메일 인증이 안 될 경우, 이메일 주소를 확인하고 다시 시도해 보세요.', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '이메일 인증을 받지 못했어요. 어떻게 해야 하나요?', '이메일 인증 메일이 오지 않으면 스팸메일함을 확인하거나, 인증 메일을 재발송해 보세요.', TO_DATE('2025-06-07', 'YYYY-MM-DD'), TO_DATE('2025-06-07', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '회원 탈퇴를 하려면 어떻게 하나요?', '회원 탈퇴 방법에 대해 안내드립니다.', TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '도서 목록을 어떻게 조회하나요?', '도서 목록을 검색하는 방법에 대해 안내드립니다.', TO_DATE('2025-06-04', 'YYYY-MM-DD'), TO_DATE('2025-06-04', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '회원가입 시 이메일 인증이 안돼요. 어떻게 해야 하나요?', '이메일 인증이 안 될 경우, 이메일 주소를 확인하고 다시 시도해 보세요.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '회원가입 시 이메일 인증이 안돼요. 어떻게 해야 하나요?', '이메일 인증이 안 될 경우, 이메일 주소를 확인하고 다시 시도해 보세요.', TO_DATE('2025-06-06', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '이메일 인증을 받지 못했어요. 어떻게 해야 하나요?', '이메일 인증 메일이 오지 않으면 스팸메일함을 확인하거나, 인증 메일을 재발송해 보세요.', TO_DATE('2025-06-07', 'YYYY-MM-DD'), TO_DATE('2025-06-07', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '내 프로필을 수정할 수 있나요?', '프로필 수정은 설정에서 가능합니다. 개인 정보를 업데이트해 주세요.', TO_DATE('2025-06-08', 'YYYY-MM-DD'), TO_DATE('2025-06-08', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '비밀번호를 잊어버렸어요. 어떻게 복구하나요?', '비밀번호 복구는 이메일을 통해 진행할 수 있습니다. 이메일을 확인해 주세요.', TO_DATE('2025-06-09', 'YYYY-MM-DD'), TO_DATE('2025-06-09', 'YYYY-MM-DD'), 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, STATUS)
VALUES (SQ_ARTICLES.NEXTVAL, 0, 'qna', '계정에 문제가 생겼어요. 어떻게 해결하나요?', '계정 관련 문제는 고객센터에 문의하여 해결하실 수 있습니다.', TO_DATE('2025-06-10', 'YYYY-MM-DD'), TO_DATE('2025-06-10', 'YYYY-MM-DD'), 0);


