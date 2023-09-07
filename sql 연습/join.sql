-- JOIN  
         
DROP TABLE test1;
         
CREATE TABLE test1 (
A VARCHAR(10),
B VARCHAR(20)
);       
         
DROP TABLE test2;
         
CREATE TABLE test2 (
A VARCHAR(10),
C VARCHAR(20),
D VARCHAR(20));
         
INSERT INTO test1 VALUES('a1', 'b1');
INSERT INTO test1 VALUES('a2', 'b2');
         
INSERT INTO test2 VALUES('a3', 'c3', 'd3');
INSERT INTO test2 VALUES('a4', 'c4', 'd4');
INSERT INTO test2 VALUES('a5', 'c5', 'd5');
         
SELECT t1.A, t2.A, t2.C
FROM test1 t1, test2 t2
WHERE t1.A = 'a1';
         
SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno = 10;
         
-- ANSI join(표준 join)
-- INNER 생략 가능
SELECT e.empno, e.ename, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 10;
         
-- student, department 테이블을 이용하여 학번, 학생명, 제1전공명 조회
SELECT s.studno, s.name, d.dname
FROM student s INNER JOIN department d
ON s.deptno1 = d.deptno;

SELECT s.*, d.*
FROM student s, department d;

-- student, professor 테이블을 이용하여 학번, 학생명, 담당교수명을 조회
-- LEFT JOIN: FROM에서 LEFT를 기준으로,  왼쪽에 위치하는 테이블의 값은 NULL을 포함하여 모두 조회
SELECT s.studno 학번, s.name 이름, p.name 담당교수
FROM student s LEFT JOIN professor p
ON s.profno = p.profno
UNION
SELECT s.studno 학번, s.name 이름, p.name 담당교수
FROM student s RIGHT JOIN professor p
ON s.profno = p.profno;

-- student, department, professor를 이용하여 학번, 이름, 제1전공명, 담당교수명 조회
SELECT s.studno 학번, s.name 이름, d.dname 제1전공, p.name 담당교수
FROM student s JOIN department d
ON s.deptno1 = d.deptno
LEFT JOIN professor p
ON s.profno = p.profno;

SELECT s.*, d.*
FROM student s JOIN department d
ON s.deptno1 = d.deptno;

-- student, exam_01 테이블을 이용하여 학번, 이름, 시험점수 조회
SELECT s.studno 학번, s.name 이름, e.total 시험점수
FROM student s JOIN exam_01 e
ON s.studno = e.studno
ORDER BY 3 DESC; -- selct 구문에서 3번째를 기준으로 내림차순

-- student, exam_01, hakjum 테이블을 이용하여 학번, 이름, 시험점수, 학점 조회
SELECT s.studno 학번, s.name 이름, e.total 시험점수, h.grade
FROM student s, exam_01 e, hakjum h
WHERE s.studno = e.studno AND (e.total BETWEEN h.min_point AND h.max_point);

SELECT s.studno 학번, s.name 이름, e.total 시험점수, h.grade 학점
FROM student s JOIN exam_01 e ON s.studno = e.studno
JOIN hakjum h ON e.total BETWEEN h.min_point AND h.max_point
ORDER BY 3 DESC;

-- gogak, gift 테이블을 이용하여 고객의 모든 정보와, 고객이 본인의 포인트로 받을 수 있는 가장 좋은 상품 조회
SELECT gg.*, gf.gname
FROM gogak gg JOIN gift gf
ON gg.point BETWEEN gf.g_start AND gf.g_end
ORDER BY gg.point;

-- emp2, p_grade 테이블을 이용하여 이름, 직급, 급여, 같은 직급의 최소급여, 최대급여 조회
SELECT e.name, e.position, e.pay, pg.s_pay, pg.e_pay
FROM emp2 e, p_grade pg
WHERE e.position = pg.position;

-- emp2, p_grade 테이블을 이용하여 이름, 직급, 나이, 본인의 나이에 해당하는 예상 직급 조회
SELECT e.name 이름, e.position 직급, YEAR(CURDATE()) - YEAR(e.birthday) 나이, p.position 예상직급
FROM emp2 e, p_grade p
WHERE YEAR(CURDATE()) - YEAR(e.birthday) BETWEEN p.s_age AND p.e_age
ORDER BY 3 DESC;

SELECT e.name 이름, e.position 직급, YEAR(CURDATE()) - YEAR(e.birthday) 나이, p.position 예상직급
FROM emp2 e JOIN p_grade p
ON YEAR(CURDATE()) - YEAR(e.birthday) BETWEEN p.s_age AND p.e_age
ORDER BY 3 DESC;

-- gogak, gift 테이블을 이용하여 노트북을 받을 수 있는 고객의 이름, 포인트, 상품명 조회
SELECT g.gname, g.point, gf.gname
FROM gogak g, gift gf
WHERE gf.gname = '노트북' AND g.point >= gf.g_start;

SELECT g.gname, g.point, gf.gname
FROM gogak g JOIN gift gf
ON g.point >= gf.g_start
WHERE gf.gname = '노트북';

-- dept2 테이블을 이용하여 부서의 모든 정보와 각 부서의 상위 부서명을 조회
SELECT d.*, td.dname
FROM dept2 d LEFT JOIN dept2 td
ON d.pdept = td.dcode;

-- emp 테이블을 이용하여 직원의 사번, 이름, 담당 매니저 사번과 이름 조회
SELECT e.EMPNO, e.ENAME, e.MGR, m.ename
FROM emp e JOIN emp m
ON e.MGR = m.empno;

-- student, department 테이블을 이용하여 학번, 이름, 제1전공명, 제2전공명 조회
SELECT s.studno 학번, s.name 이름, d1.dname 제1전공, d2.dname 제2전공
FROM student s JOIN department d1 ON s.deptno1 = d1.deptno
LEFT JOIN department d2 ON s.deptno2 = d2.deptno;

-- student, department 테이블을 이용하여 '컴퓨터정보학부'에 속한 학생의 학번, 이름, 학과번호, 학과명 조회
-- 컴퓨터정보학부는 컴퓨터공학과, 멀티미디어공학과, 소프트웨어공학과를 포함
SELECT s.*, d.*
FROM student s, department d
WHERE s.deptno1 = d.deptno AND d.part = 100;

SELECT s.studno 학번, s.name 이름, s.deptno1 학과번호, d1.dname 학과, d2.dname 학부
FROM student s JOIN department d1
ON s.deptno1 = d1.deptno
JOIN department d2
ON d1.part = d2.deptno
WHERE d2.dname = '컴퓨터정보학부';

-- student, department 테이블을 이용하여 제1전공, 제2전공으로 전자제어관에서 수업을 듣는 학생 조회
SELECT s.studno, s.name, d1.dname, d2.dname, d1.build
FROM student s JOIN department d1 ON s.deptno1 = d1.deptno
LEFT JOIN department d2 ON s.deptno2 = d2.deptno
WHERE d1.build = '전자제어관' OR d2.build = '전자제어관';

-- emp 테이블을 이용하여 사번, 이름, 입사 일자, 자신보다 먼저 입사한 인원수 조회
SELECT e1.EMPNO, e1.ENAME, e1.HIREDATE, COUNT(e2.HIREDATE) 입사선배인원수
FROM emp e1 LEFT JOIN emp e2
ON e1.HIREDATE > e2.HIREDATE
GROUP BY e1.EMPNO
ORDER BY 4;

-- professor 테이블을 이용하여 교수번호, 교수이름, 입사일자, 자신보다 먼저 입사한 인원수 조회
SELECT p1.profno, p1.name, p1.hiredate, COUNT(p2.hiredate) 입사선배인원수
FROM professor p1 LEFT JOIN professor p2
ON p1.hiredate > p2.hiredate
GROUP BY p1.profno
ORDER BY 4;

-- EX.1
SELECT e.*
FROM emp e JOIN dept d ON e.deptno = d.deptno;

-- USING(컬럼명): JOIN하는 컬럼명이 같을 때, 자동으로 JOIN
-- EX.1과 EX.2와 동일
-- EX.2
SELECT e.*, d.dname
FROM emp e JOIN dept d USING(deptno);

-- NATURAL JOIN: 컬럼명이 같은 것끼리 자동으로 JOIN
SELECT e.*, d.dname
FROM emp e NATURAL JOIN dept d;

SELECT s.*, p.name
FROM student s JOIN professor p USING(profno);

-- FULL OUTER JOIN: 전체 외부 조인. 두 테이블을 합집합한 것으로, 중복되는 값을 제외하여 조회
-- MySQL에서는 FULL OUTER JOIN을 지원하지 않으므로
-- LEFT JOIN과 RIGHT JOIN을 UNION하는 방법을 사용
SELECT s.*, p.name
FROM student s LEFT JOIN professor p ON s.profno = p.profno
UNION
SELECT s.*, p.name
FROM student s RIGHT JOIN professor p ON s.profno = p.profno