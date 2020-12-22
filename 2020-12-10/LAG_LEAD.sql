2020-12-10

SELECT empno, ename, deptno
FROM emp;

SELECT *
FROM dept;

--cross join 가능한 모든 조합을 다 한다.
SELECT *
FROM emp, dept;
--14개, 4개
--56개의 정보가 다 나온다.

SELECT *
FROM emp, dept
WHERE emp.deptno != dept.deptno;
--14개, 3개
--42개의 정보가 나온다.

--페이징쿼리(페이징하기)

복습
분석함
1. 문법 : OVER, PRATITION BY, ORDER BY,
   함수 : RANK, DENSE_RANK, ROW_NUMBER
         집계함수 - SUM, AVG, MAX, MIN, COUNT


(그룹 내에서 행 순서)
LAG(col) 
 - 파티션별 윈도우에서 이전 행의 컬럼 값
LEAD(col)
 - 파티션별 윈도우에서 이후 행의 컬럼 값
==> 이전 이후 행의 특정 컬럼을 참조하는 함수

사원번호, 사원이름, 입사일자, 급여, 자신보다 급여 순위가 한단계 낮은 사람의 급여
급여 순위 : 1. 급여가 높은 사람
            2. 급여가 같을 경우 입사일자가 빠른 사람;
SELECT empno, ename, hiredate, sal,
    LEAD(sal) OVER(ORDER BY sal DESC, hiredate ASC ),
    --(col, 비교할 몇번 이후 row.
    LEAD(sal,3) OVER(ORDER BY sal DESC, hiredate ASC )
FROM emp
ORDER BY sal DESC, hiredate ASC;

실습 5
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여,
전체 사원중 급여 순위가 1단계 높은 사람의 급여를 조회하는 쿼리를 작성 하세요(급여가 같을 경우 입사일이 빠른 사람이 높은 순위)
SELECT * FROM emp;
SELECT empno, ename, hiredate, sal,
    LAG(sal) OVER (ORDER BY sal DESC, hiredate asc)
FROM emp
ORDER BY sal desc, hiredate asc;

select emp.*, rownum from emp;

select b.empno, b.ename, b.hiredate,a.sal, rownum
from emp b , (select ename, sal
                        from emp
                        order by sal desc) c, (select d.empno, d.ename, d.hiredate,c.sal, rownum
                                            from emp d , (select ename, sal
                                                    from emp
                                                    order by sal desc) e
                where d.ename = c.ename)
where b.ename = a.ename;

select b.empno, b.ename, b.hiredate,a.sal sal1, rownum
from emp b ,(select ename, sal
                        from emp
                        order by sal desc) a
where b.ename = a.ename;

select g.*, h.sal1, j.sal1
from emp g,
    (select b.empno, b.ename, b.hiredate,a.sal sal1, rownum aa
    from emp b ,(select ename, sal
                            from emp
                            order by sal desc) a
    where b.ename = a.ename) h,
    (select d.empno, d.ename, d.hiredate,c.sal sal1, rownum bb
    from emp d ,(select ename, sal
                            from emp
                            order by sal desc) c
    where d.ename = c.ename) j
where h.aa = j.bb-1;

        
실습 5_1
SELECT * FROM emp;

SELECT a.*, b.sal, a.sal
FROM (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) a,
     (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) b
where a.rn  = b.rn-1;

SELECT a.empno, a.ename, a.hiredate, a.sal, b.sal
FROM (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) a left outer join
     (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) b on (a.rn  = b.rn+1)
ORDER BY a.rn;
a가 2위이면 b의 1위와 연결
a가 3위이면 b의 2위와 연결
a가 n위이면 b의 n-1위와 연결
a.rn -1 = b.rn

window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 직군(job), 급여 정보와
담당업무(job) 별 급여 순위가 1단계 높은 사람의 급여를 조회하는 쿼리를 작성하세요
(급여가 같을 경우 입사일이 빠른 사람이 높은순위);
SELECT * FROM emp;
SELECT empno, ename, hiredate, job, sal,
    LAG(sal) OVER(PARTITION BY job ORDER BY sal desc)
FROM EMP
ORDER BY job, sal desc, hiredate asc;


메타 인지 : 내가 무엇을 모르는지 아는 상황
select empno, ename, hiredate, job, sal, 
    ROW_NUMBER() OVER(PARTITION BY job ORDER BY sal desc)
FROM emp;

메타 인지 : 내가 무엇을 모르는지 아는 상황
--나 앞으로 나 자신까지 order by
SELECT empno, ename, sal, 
    SUM(sal) OVER (ORDER BY sal)
FROM emp;











