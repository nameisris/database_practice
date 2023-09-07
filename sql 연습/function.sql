-- 문자열 함수
-- concat: 문자열을 이을 때 사용

SELECT CONCAT(ename, '(', job, ')') AS 'ename_job' FROM emp;

-- SMITH's sal is $800
SELECT CONCAT(ename, '''s sal is $', sal) AS info FROM emp;

-- format: #, ###, ###.## (숫자형 데이터의 포맷 지정
-- 소수점 2번째까지 출력
SELECT FORMAT(250500.1254, 2);

-- 소수점 1번째까지 출력 (sal 자체는 소수점이 없기에 소수점 1번째를 0으로 출력)
SELECT empno, ename, FORMAT(sal, 1) FROM emp;

-- insert: 문자열 내의 지정된 위치에 특정 문자 수만큼 문자열을 변경
-- 8번째인 n부터 시작하여, 5만큼의 길이인 naver를 kosta로 변경
SELECT INSERT('http://naver.com', 8, 5, 'kosta');

-- student 테이블에서 주민번호 뒤 7자리를 *로 대체하여 학생 조회
-- (학번, 이름, 주민번호, 학년)
SELECT studno, NAME, INSERT(jumin, 7, 7, '*******'), grade FROM student;

-- gogak 테이블에서 고객번호와 이름 조회
-- 단, 이름은 가운데 글자를 *로 대체
SELECT gno, INSERT(gname, 2, 1, '*') FROM gogak;

-- instr: 문자열 내에서 특장 문자의 위치를 출력
-- Java의 indexOf()와 유사
SELECT INSTR('http://naver.com', 'n');
-- n의 위치값인 8 출력

-- student 테이블의 tel에서 )의 위치 구하기
SELECT INSTR(tel, ')') FROM student;

-- substr: 문자열 내에서 부분 문자열 추출
-- 8번째에서 5개만큼 추출
SELECT SUBSTR('http://naver.com', 8, 5);
-- 8번째에서 끝까지 전부 추출
SELECT SUBSTR('http://naver.com', 8);

-- tel의 1번째부터 ) 문자 이전까지
SELECT SUBSTR(tel, 1, INSTR(tel, ')') - 1) 지역번호 FROM student;

-- student 테이블에서 주민번호 생년월일이 9월인 학생 조회
SELECT studno, NAME, jumin FROM student WHERE SUBSTR(jumin, 3, 2) = '09';

-- student 테이블에서 전화번호의 가운데 수만 추출
SELECT SUBSTR(tel, INSTR(tel, ')') + 1, INSTR(tel, '-') - INSTR(tel, ')')-1) 국번 FROM student;

-- Length: 문자열의 바이트 수 구하기 (영문 한글자: 1byte, 한글 한글자: 3byte)
SELECT LENGTH(tel) FROM student;

SELECT LENGTH(email) FROM professor;
SELECT email, INSTR(email, '@') FROM professor;
-- 전체 email, email에서 @ 뒤의 모든 문자열 출력
SELECT email, SUBSTR(email, INSTR(email, '@') + 1) FROM professor;

SELECT email, SUBSTR(email, INSTR(email, '@') + 1), LENGTH(SUBSTR(email, INSTR(email, '@') + 1)) LENGTH FROM professor;
-- email의 뒷 부분을 kosta.com으로 변경
SELECT email, INSERT(email, INSTR(email, '@') + 1, LENGTH(SUBSTR(email, INSTR(email, '@') + 1)), 'kosta.com') LENGTH FROM professor;

SELECT ename, LENGTH(ename) FROM emp;
SELECT NAME, LENGTH(NAME) FROM student;

-- char_Length: 문자열의 글자수 구하기
SELECT ename, CHAR_LENGTH(ename) FROM emp;
SELECT NAME, CHAR_LENGTH(NAME) FROM student;

-- substring: = substr
SELECT SUBSTR('http://naver.com', 8, 5);
SELECT SUBSTRING('http://naver.com', 8, 5);

-- 소문자로 변경: LOWER, LCASE
SELECT ename, LOWER(ename) FROM emp;
SELECT ename, LCASE(ename) FROM emp;

-- 대문자로 변경: UPPER, UCASE
SELECT id, UPPER(id) FROM professor;
SELECT id, UCASE(id) FROM professor;

-- trim: 앞뒤 공백 제거
SELECT LENGTH(' test '), LENGTH(TRIM(' test '));
-- 중간의 공백은 제거하지 않음
SELECT LENGTH('t e s t'), LENGTH(TRIM('t e s t'));

-- Ltrim: 왼쪽 공백만 제거
SELECT LENGTH(' test '), LENGTH(LTRIM(' test '));

-- Rtrim: 오른쪽 공백만 제거
SELECT LENGTH('  test   '), LENGTH(RTRIM('  test   '));

-- 왼쪽을 특정 문자로 채워넣기
-- Lpad: 특정 문자열의 전체 길이를 통일하며, 왼쪽으로 특정 문자를 끼워넣음 (왼편의 들어갈 문자와 길이를 정하는 오른쪽 정렬)
SELECT sal, LPAD(ename, 20, ' ') FROM emp;
SELECT LPAD(email, 20, '123456789') FROM professor;
-- 남는 공간만큼 1~9까지를 최대한 채움

-- 오른쪽을 특정 문자로 채워넣기 (왼쪽 정렬)
SELECT sal, RPAD(ename, 20, ' ') FROM emp;


-- 날짜 함수
-- curdate
-- 시스템의 현재 날짜 (시스템 날짜가 잘못되면 잘못된 값 그대로 가져옴)

SELECT CURDATE();
SELECT CURRENT_DATE();
SELECT CURDATE() + 1;

-- ADDDATE, DATE_ADD: 연, 월, 일을 더하거나 뺀다
-- 아래의 경우, 현재 날짜에서 (minus 1달)을 더해줌
SELECT ADDDATE(CURDATE(), INTERVAL - 1 MONTH); -- YEAR, DAY, MONTH 전부 가능
SELECT DATE_ADD(CURDATE(), INTERVAL - 1 YEAR);
-- INTERVAL 생략 시, 기본적으로 DAY가 됨
SELECT ADDDATE(CURDATE(), 2);
SELECT DATE_ADD(CURDATE(), 10);

-- emp 테이블에서 각 직원의 입사일과 10년 기념일을 조회
SELECT hiredate, ADDDATE(hiredate, INTERVAL + 10 YEAR) 10년기념일 FROM emp;

SELECT hiredate, ADDDATE(hiredate, 2) FROM emp;

-- curtime, current_time: 시스템의 현재 시각
SELECT CURTIME(), CURRENT_TIME();
-- 현재 시각, (현재 시간 + 1:10:5) 출력
SELECT CURTIME(), ADDTIME(CURTIME(), '1:10:5');

-- now(): 시스템의 현재 날짜 & 시간
-- DATE 타입 형태로 반환
SELECT NOW();
-- 현재 날짜&시간, (현재 날짜 & 시간 + 2일 1:10:5) 출력
SELECT NOW(), ADDTIME(NOW(), '2 1:10:5');

-- DAY: 날짜만 가지고 있는 경우 주로 사용하는 타입
-- DATE: 날짜, 시간을 가지고 있는 경우 주로 사용하는 타입

-- DATEDIFF
-- 날짜간의 차이 값
SELECT hiredate, DATEDIFF(CURDATE(), hiredate) 입사며칠째 FROM emp;
SELECT DATEDIFF(CURDATE(), '1997-05-15') AS 일수 FROM emp;

-- DATE_FORMAT
-- 날짜 포맷 변경하여 출력
-- M: 월, D: 일, Y: 연도, H: 시, I: 분, S: 초, W: 요일
SELECT DATE_FORMAT('2017-06-15', "%M %D %Y");
SELECT DATE_FORMAT(NOW(), "%b %d %Y %l:%i:%s %W");

-- 월: %M(September), %m(09), %b(sep), %c(9)
-- 연: %Y(2023), %y(23)
-- 일: %D(5th), %d(05), %e(5)
-- 요일: %W(Tuesday), %a(Tue)
-- 시간: %H(13), %l(1), %h(01)
-- %r hh:mm:ss AM, PM
-- 분: %i
-- 초: %S

-- DATE_SUB: 날짜 빼기
SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 10 DAY);
-- ADDDATE에서 마이너스를 더해 날짜 빼기
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL -10 DAY);

-- DAY, DAYOFMONTH: 날짜에서 일 추출
SELECT hiredate, DAY(hiredate) FROM emp;
SELECT hiredate, DAYOFMONTH(hiredate) FROM emp;

SELECT hiredate, YEAR(hiredate) FROM emp;
SELECT hiredate, MONTH(hiredate) FROM emp;

SELECT NOW(), HOUR(NOW());
SELECT NOW(), MINUTE(NOW());
SELECT NOW(), SECOND(NOW());

-- DAYNAME: 날짜에서 요일 추출
-- DAYOFWEEK: 날짜에서 요일의 순서 추출 (ex:일요일은 1, 월요일은 2... 금요일은 6, 토요일은 7)
SELECT hiredate, DAYNAME(hiredate) FROM emp;
SELECT hiredate, DAYOFWEEK(hiredate) FROM emp;

-- EXTRACT
SELECT CURDATE(), EXTRACT(MONTH FROM CURDATE()) AS MONTH;
SELECT CURDATE(), EXTRACT(YEAR FROM CURDATE()) AS YEAR;
SELECT CURDATE(), EXTRACT(DAY FROM CURDATE()) AS DAY;
SELECT CURDATE(), EXTRACT(WEEK FROM CURDATE()) AS WEEK; -- 1년 중, 몇 번째 주인지
SELECT CURDATE(), EXTRACT(QUARTER FROM CURDATE()) AS QUARTER; -- 분기
SELECT CURDATE(), EXTRACT(YEAR_MONTH FROM CURDATE()) AS 'YEAR_MONTH'; -- 연월
SELECT NOW(), EXTRACT(HOUR FROM NOW()) AS HOUR;
SELECT NOW(), EXTRACT(MINUTE FROM NOW()) AS MINUTE;
SELECT NOW(), EXTRACT(SECOND FROM NOW()) AS SECOND;

-- TIME_TO_SEC: 시간을 초로 변환
SELECT CURTIME(), TIME_TO_SEC(CURTIME());

-- TIMEDIFF: 시간 간의 차이 값
SELECT TIMEDIFF(CURTIME(), '08:48:27');
SELECT TIME_TO_SEC(TIMEDIFF(CURTIME(), '08:48:27'));


-- 숫자 함수
-- count: 조건에 만족하는 레코드(행) 수
SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp; -- 컬럼명이 매개변수로 사용될 시, null인 레코드는 제외

SELECT COUNT(*) FROM emp WHERE deptno = 10;

-- sum: 매개변수에 해당되는 컬럼의 합
SELECT SUM(sal) FROM emp;
SELECT SUM(sal) FROM emp WHERE deptno = 10;

-- avg: 매개변수에 해당되는 컬럼의 합
SELECT SUM(sal), COUNT(*), SUM(sal) / COUNT(*), AVG(sal) FROM emp;
-- SUM(comm) / COUNT(*)는 NULL인 comm까지 포함하여 나누며(그냥 전체 comm 갯수만큼 나눔)
-- AVG(comm)은 NULL을 제외한 갯수로 나눔
SELECT SUM(comm), COUNT(*), SUM(comm) / COUNT(*), SUM(comm) / COUNT(comm), AVG(comm) FROM emp;

-- comm의 특정 행이 null일 경우, 0으로 대체하여 null이 없는 comm으로 AVG() 구문 실행
SELECT SUM(comm), SUM(comm) / COUNT(*), AVG(IFNULL(comm, 0)) FROM emp;

-- max
SELECT MAX(sal) FROM emp;

-- min
SELECT MIN(sal) FROM emp;

-- professor 테이블에서 교수들의 연봉을 조회
-- 교수 번호, 이름, 월 급여, 보너스, 연봉
SELECT profno '교수 번호', NAME 이름, pay 월급, IFNULL(bonus, 0) 보너스, pay * 12 + IFNULL(bonus, 0) FROM professor;

-- group by: 특정 컬럼에서, 같은 값끼리 묶음
-- 아래의 경우, 조건식에 해당되는 인원이 전부 안 나오고 가장 앞의 한 명만 나옴 (오류가 안 나고 뭔가가 나오면서 실행됨)
SELECT deptno, job, COUNT(*), SUM(sal) FROM emp GROUP BY deptno, job;

-- student 테이블에서 메인 학과별 학생수 조회
SELECT deptno1, COUNT(*) FROM student GROUP BY deptno1;

-- student 테이블에서 학년별 평균 키 조회
-- format으로, 소수점 아래 1자리까지 출력
SELECT grade, FORMAT(AVG(height), 1) FROM student GROUP BY grade;

-- deptno 별 최대 급여
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;

-- GROUP BY 함수의 경우, SELECT절에 같이 포함된 컬럼만 의미있음
-- 만약 그렇지 않을 경우, 오류는 없지만 잘못된 값이 나올 수 있음

SELECT deptno, AVG(sal) FROM emp GROUP BY deptno;

-- group by한 값에 대한 조건은 HAVING 절 사용
-- emp 테이블에서 평균 급여가 2000 이상인 부서의 부서번호와 평균 급여 조회
SELECT deptno, format(AVG(sal), 0) FROM emp
GROUP BY deptno
HAVING(AVG(sal) >= 2000);

-- student 테이블에서 각 학과와 학년별 평균 몸무게, 최대/최소 몸무게를 조회 (오름차순)
SELECT deptno1, grade, AVG(weight), MAX(weight), MIN(weight) FROM student
GROUP BY deptno1, grade
HAVING AVG(weight) > 50
ORDER BY deptno1, grade;