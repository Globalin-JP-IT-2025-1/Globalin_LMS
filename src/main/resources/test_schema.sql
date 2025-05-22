
-- 테스트용
-- 테이블 생성
CREATE TABLE test_users ( 
id NUMBER NOT NULL,
name VARCHAR2(30) NOT NULL, 
email VARCHAR2(50) NOT NULL,
userid VARCHAR2(30) NOT NULL UNIQUE, 
password VARCHAR2(30) NOT NULL,
CONSTRAINT test_users_pk PRIMARY KEY (id)
);

-- 시퀀스 생성
CREATE SEQUENCE test_users_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 테이블 전체 조회
SELECT * FROM test_users;

-- 예제 데이터 추가
INSERT INTO test_users (id, name, email, userid, password) 
VALUES (test_users_seq.NEXTVAL, '가길동', 'gildong_ga@test.com', 'test', 'test');

-- 시퀀스 전체 조회
SELECT sequence_name, min_value, max_value, increment_by, cycle_flag, cache_size
FROM user_sequences;

-- 시퀀스 삭제
DROP SEQUENCE test_seq;

-- 테이블 내용 전체 삭제
TRUNCATE TABLE test_users;
-- 테이블 제거
DROP TABLE test_users;

