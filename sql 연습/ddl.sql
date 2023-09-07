-- DDL (Data Definition Language)
-- 테이블 기준
-- create(생성), alter(변경), truncate(잘라내기), drop(삭제)

-- DML (Data Manipulation Language)
-- 데이터 기준
-- insert(삽입), update(수정), delete(삭제), merge(병합)

-- DCL (Data Control Language)
-- 계정 기준
-- grant(권한 부여), revoke(권한 회수)

-- TCL (Transaction Control Language)
-- commit(확정), rollback(취소)

-- DQL (Data Query Language)
-- select(조회)

CREATE DATABASE testdb;

DROP DATABASE testdb;

CREATE TABLE person(
	NAME VARCHAR(100) NOT NULL,
	age INT DEFAULT 0, -- 값 설정 시 NULL일 경우, 0 초기화
	address VARCHAR(100),
	email VARCHAR(100) PRIMARY KEY,
	-- 혹은, PRItestdbpersonMARY KEY(email)과 같이 지정 가능
	-- 혹은, 추후 ALTER 명령어와 함께 지정 가능
	-- PK 지정 시, 자연스레 NOT NULL & UNIQUE
	birthday DATE
);

DROP TABLE person;


-- emp 테이블 생성 및 삽입
drop table IF EXISTS emp;
CREATE TABLE EMP ( 
  EMPNO     int, 
  ENAME     VARCHAR(30), 
  JOB       VARCHAR(20), 
  MGR       int, 
  HIREDATE  DATE, 
  SAL       int,
  COMM      int, 
  DEPTNO    int) DEFAULT CHARSET=UTF8;

insert into emp values (7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
insert into emp values (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
insert into emp values (7521,'WARD','SALESMAN',7698,'1982-02-22',1250,500,30);
insert into emp values (7566,'JONES','MANAGER',7839,'1981-04-02',2975,null,20);
insert into emp values (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30);
insert into emp values (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,null,30);
insert into emp values (7782,'CLARK','MANAGER',7839,'1981-06-09',2450,null,10);
insert into emp values (7788,'SCOTT','ANALYST',7566,'1987-04-17',3000,null,20);
insert into emp values (7839,'KING','PRESIDENT',null,'1981-11-17',5000,null,10);
insert into emp values (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
insert into emp values (7876,'ADAMS','CLERK',7788,'1987-05-23',1100,null,20);
insert into emp values (7900,'JAMES','CLERK',7698,'1981-12-03',950,null,30);
insert into emp values (7902,'FORD','ANALYST',7566,'1981-12-03',3000,null,20);
insert into emp values (7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

CREATE UNIQUE INDEX PK_EMP ON EMP (EMPNO) ;
ALTER TABLE EMP ADD  CONSTRAINT PK_EMP PRIMARY KEY (EMPNO);


-- 기존의 테이블을 이용하여 데이터를 가진 테이블 생성
CREATE TABLE emp_sub AS
SELECT empno, ename, job, hiredate, sal FROM emp WHERE deptno = 10;

-- WHERE절에서 거짓 조건을 달 경우, 데이터를 제외한 테이블만 생성
CREATE TABLE emp_t AS
SELECT * FROM emp WHERE 1 = 2;

-- person 테이블 생성
CREATE TABLE persons(
	id INT,
	last_name VARCHAR(255),
	first_name VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(200)
);

-- add column
ALTER TABLE persons ADD email VARCHAR(255);

-- modify column
ALTER TABLE persons MODIFY COLUMN city VARCHAR(255);

-- drop column
ALTER TABLE persons DROP COLUMN email;

-- add column (default 지정)
ALTER TABLE emp_sub ADD deptno INT DEFAULT 10;

-- rename column
ALTER TABLE emp_sub RENAME COLUMN deptno TO dcode;

-- rename table
RENAME TABLE emp_sub TO emp_10;

SELECT * FROM emp_10;

-- table 비우기
-- delete와 달리, 사용하지 않는 메모리까지 비움
TRUNCATE TABLE emp_10;

-- CRUD (create(insert), read(select), update(update), delete(delete))
-- table 전체 삭제
DELETE FROM emp;