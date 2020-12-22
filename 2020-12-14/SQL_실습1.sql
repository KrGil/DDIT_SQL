2020-12-14 SQL WINDOW 실습문제

SELECT empno, ename, sal
FROM emp;

SELECT *
FROM salgrade;

SELECT a.empno, a.ename, a.sal, b.grade
FROM emp a, salgrade b
WHERE a.sal between b.losal and b.hisal;
--WHERE a.sal >= salgrade.losal
--      AND a.sal <= salgrade.hisal;

--부정형 조인
14, 4 자신과 같은 번호를 제외!! 14*3하면 총 42개가 나온다.
SELECT *
FROM emp, dept
WHERE emp.DEPTNO != dept.DEPTNO;

실습 --3
모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여를 급여가 낮은 순으로
조회 해보자. 급여가 동일할 경우 사원번호가 빠른 사람이 우선순위가 높다.

우선순위가 가장 낮은 사람부터 본인까지의 급여 합을 새로운 컬럼으로 생성
WINDOW 함수 없이...
SELECT ROWNUM,(select empno, ename,sal
                FROM emp
                ORDER BY sal;)
FROM emp;

SELECT a.empno, a.ename, a.sal, SUM(b.sal)
FROM 
    (select empno, ename,sal
    FROM emp
    ORDER BY sal) a,
    (select empno, ename,sal
    FROM emp
    ORDER BY sal) b
WHERE a.sal >= b.sal
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal;

SELECT a.empno, a.ename, a.sal, SUM(b.sal)
FROM emp a, emp b
WHERE a.sal >= b.sal
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal;

SELECT a.empno, a.ename, a.sal, SUM(b.sal) c_sum
FROM
    (SELECT a.*, ROWNUM rn
     FROM
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal, empno) a) a,
    (SELECT a.*, ROWNUM rn
     FROM
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal, empno) a) b
 WHERE a.rn >= b.rn
 GROUP BY a.empno, a.ename, a.sal
 ORDER BY a.sal, a.empno;
 
 ----WINDOWING 쓰기!! 분석함수
 SELECT a.empno, a.ename,a.sal, sum(a.sal) OVER (ORDER BY sal, empno)
 FROM emp a;
 
 --실습 0번
 사원의 부서별 급여(SAL) 별 순위 구하기
 EMP 테이블 사용
 1. 행을 임의로 생성 SINGLE ROW FUNCTION : LENGTH, LOWER
 SINGLE ROW FUNCTION : LENGTH, LOWER
 MULTI ROW FUNCTION : SUM , MAX, MIN
 
 SELECT *
 FROM dual; --행이 하나 컬럼이 하나.
 --DUAL 은 TEST할때

 SELECT LENGTH('hello, World') 
 FROM emp;
 --행을 임의로 만들어내고 번호를 중복되지 않게 만들려고.
 SELECT dual.*, LEVEL
 FROM dual
 CONNECT BY LEVEL <= 10; --행 복제하기
 
 SELECT LEVEL
 FROM dual              -- 범용성을 위해
 CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp);
 
 10 3
 20 5
 30 6
 
 SELECT deptno, COUNT(*)
 FROM emp
 GROUP BY deptno;
 
 ------------------------------------------
SELECT  A.empno, a.sal, a.deptno, B.rn
FROM
    (SELECT ROWNUM r, a.*
    FROM 
        (SELECT empno, sal, deptno
         FROM emp
         ORDER BY deptno, sal, empno) a ) a, 
     
    (SELECT ROWNUM r, b.*
     FROM 
        (SELECT a.deptno, b.rn
         FROM
            (SELECT deptno, COUNT(*) cnt
             FROM emp
             GROUP BY deptno) a,
        (SELECT LEVEL rn
         FROM dual
         CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp)) b
WHERE a.cnt >= b.rn
ORDER BY a.deptno, b.rn) b ) b
WHERE a.r = b.r;