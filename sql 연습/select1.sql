-- selelct from: 테이블의 데이터를 조회할 때 사용
-- *의 의미는 전체 컬럼을 의미
SELECT * FROM emp;
-- select와 from 사이에는 조회하고자 하는 컬럼을 씀
SELECT empno, ename FROM emp;

-- dept 테이블에서 전체 컬럼 조회
SELECT * FROM dept;
-- dept 테이블에서 deptno, dname 조회
SELECT deptno, dname FROM dept;

-- student 테이블에서 학번, 이름, 생일, 전화번호 조회
SELECT studno, name, birthday, tel FROM student

-- where: 행에 대한 조건문(조건에 만족하는 행만 조회할 때 사용)
SELECT *
FROM emp
WHERE deptno = 10;

SELECT empno, ename, deptno FROM emp WHERE deptno = 10;

-- emp 테이블에서 deptno가 10보다 큰 직원의 사번, 이름, 직무, 부서번호를 조회
SELECT empno, ename, job, deptno FROM emp WHERE deptno > 10;

-- student 테이블에서 4학년 학생들의 학번, 이름, 생일, 전화번호, 학년을 조회
SELECT studno, NAME, birthday, tel, grade FROM student WHERE grade = 4;


-- where 절 연산자
-- student 테이블에서 2학년이거나 3학년인 학생의 정보를 조회
SELECT * FROM student WHERE grade = 2 OR grade = 3;
SELECT * FROM student WHERE grade >= 2 OR grade <= 3;
SELECT * FROM student WHERE grade IN(2, 3); -- grade가 2나 3에 포함인지~

-- student 테이블에서 1학년 또는 2학년 또는 3학년인 학생의 정보를 조회
SELECT * FROM student WHERE NOT grade = 4;
SELECT * FROM student WHERE grade NOT IN(4);
SELECT * FROM student WHERE grade IN (1, 2, 3);

-- emp 테이블에서 직무가 CLERK이거나 SALESMAN인 직원의 사번, 이름, 직무를 조회
-- 문자열 지정 시, 작은 따옴표(')
SELECT empno, ename, job FROM emp WHERE job = 'CLERK' OR job = 'SALESMAN';

-- alias: 컬럼명을 바꿔서 조회
-- 기존 컬럼명/AS/새로운 컬럼명
-- AS 생략 가능
-- alias는 큰 따옴표 (")
-- 큰 따옴표는 생략 가능하나, alias 안에서 스페이스가 들어갈 경우 반드시 기재
SELECT empno AS "사번", ename 이름, job "직 무" FROM emp WHERE job = 'CLERK' OR job = 'SALESMAN';

-- student 테이블에서 4학년 학생들의 학번, 이름, 학년을 조회 (컬렴명: 학번, 이름, 학년)
SELECT studno 학번, NAME AS 이름, grade AS "학년" FROM student WHERE grade = 4;
SELECT studno 학번, NAME AS 이름, grade AS "학년" FROM student WHERE grade != 4;

-- professor 테이블에서 홈페이지가 null인 교수 목록 조회
SELECT * FROM professor WHERE hpage IS NULL; -- 컬럼값 비교 시 null은 is로 비교(=로 비교하지 않음)
SELECT * FROM professor WHERE hpage IS not NULL;

-- 날짜 형식도 비교 연산 가능 (최신 날짜일수록 큼)
SELECT * FROM emp WHERE hiredate =>'1985-01-01';

-- student 테이블에서 1976년생 학생 조회
SELECT * FROM student WHERE birthday >= '1976-01-01' AND birthday <= '1976-12-31';

-- emp 테이블에서 부서번호가 10이고 급여가 2000 이상인 직원의 목록 조회
SELECT * FROM emp WHERE deptno = 10 AND sal >= 2000;

-- professor 테이블에서 학과 번호가 101이면서 정교수 조회
SELECT * FROM professor WHERE deptno = 101 AND POSITION = '정교수';

-- student 테이블에서 전공이나 부전공이 101인 학생 조회
SELECT * FROM student WHERE deptno1 = 101 OR deptno2 = 101;

-- student 테이블에서 전공이나 부전공이 101인 학생 중, 1학년 또는 2학년 학생 조회
SELECT * FROM student WHERE (deptno1 = 101 OR deptno2 = 101) AND grade IN(1, 2);

-- emp2 테이블에서 정규직 중 급여가 5000 이상인 직원의 이름과 직급, 연봉 조회
SELECT NAME, POSITION, pay FROM emp2 WHERE emp_type = '정규직' AND pay >= 50000000;

-- 컴퓨터정보학부에 소속된 교수의 이름, 직급, 소속학과 조회
SELECT NAME, POSITION, deptno FROM professor WHERE deptno IN (101, 102, 103);
SELECT NAME, POSITION, deptno FROM professor WHERE deptno = 101 OR deptno = 102 OR deptno = 103;

-- 조인형 교수가 담당 교수로 하는 학생의 학번, 이름, 학년, 학과번호, 교수번호 조회
SELECT studno, NAME, grade, deptno, profno FROM student WHERE profno = 1001;

-- 노트북을 선물로 받을 수 있는 고객의 고객 번호, 이름, 포인트 조회
SELECT gno, gname, POINT FROM gogal WHERE POINT >= 5000;

-- exam() 테이블에서 학점이 B0m B+인 학생의 학번과 점수 조회
SELECT studno, total FROM exam_01 WHERE total >= 80 AND total <= 89;
SELECT studno, total FROM exam_01 WHERE total between 80 AND 89;

-- student 테이블에서 1976년생 학생 조회 (between A and B 사용)
SELECT * FROM student WHERE birthday BETWEEN '1976-01-01' AND '1976-12-31';

-- order by: 정렬
SELECT * FROM emp ORDER BY sal ASC; -- 오름차순
SELECT * FROM emp ORDER BY sal DESC; -- 내림차순
SELECT * FROM emp WHERE deptno = 10 ORDER BY sal DESC;

-- order by 숫자는, SELECT 절에서 조회할 컬림인  n번째 값을 기준으로 정렬하겠단 의미
SELECT studno, NAME FROM student ORDER BY 2;

-- student 테이블에서 4학년 학생들의 학번, 이름, 생일, 학과번호를 생일 순으로 정렬
SELECT studno, NAME, birthday, deptno1 FROM student WHERE grade = 4 ORDER BY 3;

-- deptno는 오름차순, sal는 내림차순
-- ASC의 경우, 생략 가능 (default)
SELECT * FROM emp ORDER BY deptno, sal DESC;

-- student 테이블에서 학년순 정렬, 같은 학년은 키가 큰 학생을 앞에 조회
SELECT * FROM student ORDER BY grade, height DESC;

-- DISTINCT: 중복 행 제거
SELECT DISTINCT deptno1 FROM student;
SELECT DISTINCT (deptno1) FROM student;

-- LIKE: VARCHAR 타입의 문자열에서 특정 문자열이 포함된 것을 조회할 때 사용
-- EX) 이름의 성이 '서'인 학생 조회
SELECT * FROM student WHERE NAME LIKE '서%';

-- emp 테이블에서 직급에 MAN이 포함된 인원 조회
SELECT * FROM emp WHERE job LIKE '%MAN%';

-- emp 테이블에서 직급에서 두 번째 글자에 A가 들어가는 인원 조회
-- _(언더바)는 하나의 글자를 의미
-- 즉, '_A%'는 앞에 한 글자가 있으면서 A 뒤에 글자가 있는 조건
SELECT * FROM emp WHERE job LIKE '_A%';

-- student 테이블에서 9월 생일인 학생의 학번, 이름, 학년, 주민번호 조회
SELECT studno, NAME, grade, jumin FROM student WHERE jumin LIKE '__09%';

-- professor 테이블에서 보너스가 있는 교수들의 교수번호, 이름, 급여, 보너스, 급여 + 보너스  조회
SELECT profno, NAME, pay, bonus, pay + bonus FROM professor WHERE bonus IS NOT NULL;

-- 특정 값과 NULL을 더하면, NULL을 반환 (모든 DB 동일)
SELECT profno, NAME, pay, bonus, pay + bonus FROM professor;

-- 즉, null 나올 수도 있는 컬럼일 경우, NULL이면 0으로 반환하게
-- IFNULL(something, 0): 만약 해당하는 컬럼인 something이 NULL일 경우,  대체값 반환(0)
SELECT profno, NAME, pay, bonus, pay + IFNULL(bonus, 0) FROM professor;

-- emp 테이블에서 sal이 1000보다 크고 comm이 1000보다 작거나 없는 직원의 사번, 이름, 급여, 커미션 조회
SELECT empno, ename, sal, comm FROM emp WHERE sal > 1000 AND (comm < 1000 OR comm IS NULL);

-- concat: 문자열을 이을 때 사용
SELECT CONCAT(ename, '(', job, ')') AS 'ename_job' FROM emp;

-- SMITH's sal is $800
SELECT CONCAT(ename, '''s sal is $', sal) AS info FROM emp;
SELECT CONCAT(ename, '''s sal is $', sal) AS info FROM emp WHERE ename = 'smith';