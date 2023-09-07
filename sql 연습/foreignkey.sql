DROP TABLE article;
DROP TABLE user;

CREATE TABLE user(
	id VARCHAR(100),
	NAME VARCHAR(100)
);

-- AUTO_INCREMENT는 PK로 지정 필수
CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100)
);

-- 테이블 생성 이후, 외래키 지정
ALTER TABLE user ADD CONSTRAINT USER_PK PRIMARY KEY(id);
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK FOREIGN KEY(writer) REFERENCES user(id);

-- 아래 구문 실행 시 오류
-- article의 writer 컬럼은 user 테이블의 id 컬럼을 참조하므로
-- writer에 해당 값이 필수 (외래키 제약조건 위배)
INSERT INTO article VALUES(NULL, '제목', '내용', 'hong');

-- 단, null은 가능 (참조 관계여도)
INSERT INTO article VALUES(NULL, '제목', '내용', NULL);

-- 참조 관계 데이터 각 테이블에 삽입
INSERT INTO user VALUES('hong', '홍길동');
INSERT INTO article VALUES(NULL, '제목', '내용', 'hong');

-- 제약조건 위배
DELETE FROM user WHERE id = 'hong'; -- 'hong' 데이터를 article 테이블에서 참조하고 있어서 삭제 불가
UPDATE user SET id = 'kong' WHERE id = 'hong'; -- 'hong' 데이터를 article 테이블에서 참조하고 있어서 변경 불가

-- 참조 데이터를 변경하는 것이 아니므로 실행 가능
UPDATE user SET NAME = '홍홍' WHERE id = 'hong';

-- 외래키 제약조건 삭제
ALTER TABLE article DROP CONSTRAINT ARTICLE_USER_FK;

-- 외래키 제약조건을 삭제했으므로, 아래 데이터 정상 삽입
INSERT INTO article VALUES(NULL, '송제목', '송내용', 'song');

-- 아래 구문 실행 시 오류
-- 제약조건 위배되는 데이터가 이미 있으므로 (writer 컬럼의 song)
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE;

-- 'hong'이 아닌 데이터는 전부 'hong'으로 수정
UPDATE article SET writer = 'hong' WHERE writer <> 'hong';

-- 외래키 지정
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE;

-- user 테이블의 'hong' 데이터가 포함된 row 삭제
-- article 테이블의 'hong' 데이터가 포함된 row 모두 삭제 (참조)
DELETE FROM user WHERE id = 'hong';



-- 제약조건 약식

CREATE TABLE user(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL
);

-- PK를 다른 행에서 지정
CREATE TABLE user(
	id VARCHAR(100),
	NAME VARCHAR(100) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100) NOT NULL REFERENCES user(id)
);

-- PK, FK를 다른 행에서 지정
CREATE TABLE article(
	num INT AUTO_INCREMENT,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100) NOT NULL,
	PRIMARY KEY(num),
	FOREIGN KEY(writer) REFERENCES user(id)
);



-- 제약조건 연습
CREATE TABLE dept2(
	dcode VARCHAR(6) PRIMARY KEY,
	dname VARCHAR(30) NOT NULL,
	pdept VARCHAR(16),
	AREA VARCHAR(26)
);

CREATE TABLE tcons(
	NO INT, -- PRIMARY KEY
	NAME VARCHAR(20), -- NOT NULL
	jumin VARCHAR(13), -- NOT NULL, UNIQUE
 	AREA INT, -- CHECK 1, 2, 3, 4
	deptno VARCHAR(6), -- REFERENCES dept2(dcode),
	-- PRIMARY KEY(NO),
	-- FOREIGN KEY(deptno) REFERENCES dept2(dcode)
);

-- 외부에서 조건 지정
ALTER TABLE tcons ADD CONSTRAINT tcons_no_pk PRIMARY KEY(NO);
ALTER TABLE tcons MODIFY COLUMN NAME VARCHAR(20) NOT NULL;
ALTER TABLE tcons MODIFY COLUMN jumin VARCHAR(13) NOT NULL;
ALTER TABLE tcons ADD CONSTRAINT tcons_jumin_uk UNIQUE(jumin);
ALTER TABLE tcons ADD CONSTRAINT tcons_area_ck CHECK(AREA IN(1, 2, 3, 4));
ALTER TABLE tcons ADD CONSTRAINT tcons_deptno_fk FOREIGN KEY(deptno) REFERENCES dept2(dcode);