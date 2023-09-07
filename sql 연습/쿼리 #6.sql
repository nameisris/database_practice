-- DML: insert, update, delete (데이터 삽입, 수정, 삭제)

-- 컬럼 순서에 맞춰 values 삽입
-- insert into table_name (column_name1, column_name2, ...) values(value1, value2, ...)
INSERT INTO user (id, NAME) VALUES ('kong', '공길동');
-- 컬럼 순서는 사용자 임의로 작성해도 무방 (단, 데이터와의 순서는 동일)
INSERT INTO user (NAME, id) VALUES ('공길동', 'kong');

-- 컬럼 목록을 생략할 경우 컬럼순으로 모든 값 삽입
-- 동일한 type으로 삽입
INSERT INTO user VALUES('park', '박길동');

-- article 데이터 삽입
-- title, content, writer
-- 1. 'title1', 'content1'
INSERT INTO article (title, content) VALUES ('title1', 'content1');
INSERT INTO article VALUES (NULL, 'title1', content1, NULL);
-- 2. 'title2'
INSERT INTO article (title) VALUES ('title2');
-- 3. 'content'
INSERT INTO article (content) VALUES ('content');
-- 4. 'title3, 'content3', 'hong'
INSERT INTO article (title, content, writer) VALUES('title3', 'content3', 'hong');
INSERT INTO article VALUES (NULL, 'title3', 'content3', 'hong');
-- 5. 'title4', 'song'
INSERT INTO article (title, writer) VALUES ('title4', 'song');
-- 6. 'content5', 'song'
INSERT INTO article (content, writer) VALUES ('content5', 'song');


-- emp 데이터 삽입
-- 사번: 9999, 이름: hong, 담당업무: SALESMAN, 담당매니저: 7369, 입사일: 오늘, 급여: 1800, 부서번호: 40
INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, deptno) VALUES (9999, 'hong', 'SALESMAN', 7369, CURDATE(), 1800, 40);
INSERT INTO emp VALUES (9999, 'hong', 'SALESMAN', 7369, CURDATE(), 1800, NULL, 40);


CREATE TABLE emp_sub (
	id INT,
	NAME VARCHAR(30)
);
-- insert into select: select의 결과값을 테이블에 삽입
-- 컬럼명은 달라도 무방하지만, 타입은 동일해야 함
-- WHERE 절을 사용해 조건에 맞는 결과값 삽입 가능
INSERT INTO emp_sub (id, NAME)
SELECT empno, ename from emp WHERE deptno = 10;