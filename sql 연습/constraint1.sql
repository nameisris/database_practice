-- constraint: 제약조건
-- not null, unique, primary key, foreign key, check
CREATE TABLE temp(
	id INT PRIMARY KEY,			-- 동일 데이터 비허용, null 값 비허용 (unique & not null)
	NAME VARCHAR(20) NOT NULL	-- null 값 비허용
);

-- 아래 구문 실행 시 오류
-- PK는 NULL 값 비허용
INSERT INTO temp VALUES(NULL, 'jang');

INSERT INTO temp VALUES(1, 'jang');

-- 아래 구문 실행 시 오류
-- 이미 PK에 해당하는 id 컬럼에 같은 값이 있으므로
-- PK는 중복 값 비허용
INSERT INTO temp VALUES(1, 'jang');

-- 아래 구문 실행 시 오류
-- NOT NULL 선언된 컬럼에 null 값 삽입 비허용
INSERT INTO temp VALUES(2, NULL);

-- UNIQUE: 중복값 허용
CREATE TABLE temp2(
	email VARCHAR(50) UNIQUE
);

-- UNIQUE 선언된 컬럼에 null 값 삽입 허용
INSERT INTO temp2 VALUES(NULL);

INSERT INTO temp2 VALUES('kosta@kosta.com');

-- 아래 구문 실행 시 오류
-- UNIQUE 선언된 컬럼에 중복된 값 삽입 허용
INSERT INTO temp2 VALUES('kosta@kosta.com');

-- CHECK: 조건 확인
CREATE TABLE temp3(
	NAME VARCHAR(20) NOT NULL,
	age INT DEFAULT 1 CHECK(age > 0) -- 값의 범위 제한
);

-- 값을 하나만 넣고자 할 땐, VALUES 구문 앞에 넣고자 하는 컬럼에 대해 (컬럼명) 작성
-- 아래 구문 실행 시, name 컬럼에만 값을 넣지만, age 컬럼에 null 값이 오는 경우 default로 1이 초기화됨
INSERT INTO temp3 (NAME) VALUES('hong');

-- 아래 구문 실행 시 오류
-- age 컬럼의 check 구문의 조건에 제한되는 값 삽입에 의한 오류
INSERT INTO temp3 VALUES('kang', -1);

DROP TABLE user;

CREATE TABLE USER(
	id VARCHAR(20) PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL
);

DROP TABLE article;

-- AUTO_INCREMENT: 데이터 삽입 시, 1씩 자동 증가
-- REFERENCES 테이블(컬럼명): 다른 테이블의 컬럼값을 FOREIGN KEY로 가짐
CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50),
	content VARCHAR(1000),
	writer VARCHAR(20)
);

INSERT INTO article (title, content) VALUES('제목', '내용');

-- 아래 구문 실행 시 오류
-- writer 컬럼이 외래키이므로
INSERT INTO article (title, content, writer) VALUES('제목', '내용', 'hong');

-- user 테이블에 미리 동일한 데이터를 삽입한 뒤,
-- article 테이블에 데이터를 삽입하면 성공
INSERT INTO user VALUES('hong', '홍길동');
INSERT INTO article (title, content, writer) VALUES('제목', '내용', 'hong');

-- 아래 구문 실행 시 오류
-- article 테이블에서 참조하고 있기에 삭제 불가능
DELETE FROM user WHERE id = 'hong';

-- 아래 구문 실행 시 오류
-- 다른 테이블에서 참조하는 컬럼 값 수정 불가능
UPDATE user SET id = 'kong' WHERE id = 'hong';

-- 참조되는 컬럼이 아닌, 다른 컬럼 값 수정 가능
UPDATE user SET NAME = '공길동' WHERE id = 'hong';

-- 아래 구문 정상 실행
-- 참조 관계를 가지는 컬럼이지만
-- 아래 삽입된 데이터는 참조되지 않으므로
-- id 컬럼의 'song' 값은, user 테이블에는 있지만 article 테이블에는 없음)
INSERT INTO user VALUES('song', '송길동');
DELETE FROM user WHERE id = 'song'; -- 참조하고 있지 않은 데이터는 삭제 가능

-- article_ibfk 외래키 참조 관계 삭제
ALTER TABLE article DROP FOREIGN KEY article_ibfk_1;

-- 외래키 지정
-- 외래키로 지정할 컬럼과 참조할 컬럼을 지정
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK FOREIGN KEY(writer) REFERENCES user(id);

ALTER TABLE article DROP FOREIGN KEY ARTICLE_USER_FK;

INSERT INTO article (title, content, writer) VALUES('송제목', '송내용', 'song');

DELETE FROM article WHERE writer = 'song';

-- ON DELETE CASCADE: 참조받는 key를 삭제할 때, 참조하는 컬럼을 가진 ROW를 삭제하도록 지정
-- foreign key로 연결된 데이터들이 일관성을 유지할 수 있도록
-- CASCADE 구문을 통해, 부모 테이블의 데이터를 UPDATE 또는 DELETE를 할 때
-- 자식 테이블의 데이터도 함께 UPDATE 또는 DELETE 되도록
ALTER TABLE article ADD CONSTRAINT ARTICLE_USER_FK FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE;
DELETE FROM user WHERE id = 'hong';