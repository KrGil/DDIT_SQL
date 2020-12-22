과제 : 위의 sql을 분석함수를 사용하지 않고 작성하기
--1. --조인
SELECT a.empno 사원번호, a.ename 사원이름, a.sal 본인급여, max, min
    from emp a, (SELECT deptno a, max(sal) max, min(sal) min
                from emp
                group by deptno) b
    where a.deptno = b.a
    order by 3;
--2.
--스칼라
select a.empno 사원번호, a.ename 사원이름, a.sal 본인급여, 
        (SELECT max(sal) max
             from emp
             where deptno = a.deptno) max, 
        (SELECT min(sal) min
             from emp
             where deptno = a.deptno) min
from emp a
order by 3;
select * from emp;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP E;
WHERE E.EMPNO = C.DNO
ORDER BY 4;

SELECT a.DEPTNO AS DNO,
                    ROUND(AVG(a.SAL),2) AS avg_sal,
                    MAX(a.SAL) AS max_sal,
                    MIN(a.SAL) AS min_sal
                    FROM EMP a
                    GROUP BY a.DEPTNO;