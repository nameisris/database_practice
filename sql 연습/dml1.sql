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

-- update table_name set column_name1 = value1, column_name2 = value2, ... where 조건;

-- emp에서 hong의 담당 업무가 CLERK로 변경, 담당 매니저가 7782로 변경
UPDATE emp SET job = 'CLERK', mgr = 7782 WHERE ename = 'hong';

-- emp에서 커미션이 없는 사람은 100을 줌
UPDATE emp SET comm = 100 WHERE comm IS NULL OR comm = 0;

-- emp에서 deptno이 10인 부서만 comm을 급여의 10%만큼 더 줌
UPDATE emp SET comm = comm + sal * 0.1 WHERE deptno = 10;

-- emp에서 smith와 같은 업무를 하는 사람들의 급여를 30% 인상
UPDATE emp SET sal = sal + sal * 0.3 WHERE job = (SELECT job FROM emp WHERE ename = 'SMITH');



-- delete from table_name where 조건;

-- emp에서 이름이 hong인 데이터 삭제
DELETE FROM emp WHERE ename = 'hong';

-- emp에서 부서 번호가 40인 데이터 삭제
DELETE FROM emp WHERE deptno = 40;

-- commit, rollback이 나올 때까지 실행되는 모든 SQL 추적
-- 즉, 최종 반영을 commit 또는 rollback 사용 시점에 결정
-- rollback 구문으로 emp_sub 삭제를 롤백
START TRANSACTION;
DELETE FROM emp_sub;
ROLLBACK;
COMMIT;

SELECT * FROM emp_sub