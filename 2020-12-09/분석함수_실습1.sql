2020-12-09 분석함수
분석함수 : 행간 연산 지원을 해주는 함수
select 분석함수이름([인자]) over ( 영역설정 순서설정 범위설정)
from .....
영역설정 : PARTITION BY 컬럼 
순서설정 : ORDER BY 컬럼
범위설정 : PARTITION 내에서 특정 행까지 범위를 지정...(나중)

하려고 하는 것 : emp 테이블을 이용하여 부서번호 별로 급여 랭킹을 계산
                (급여 랭크 기준 : sal값이 높은 사람이 랭크가 높은 것으로 계산)
                
영역설정 : deptno
순서설정 : sal DESC;

SELECT ename, sal, deptno,
    --rank는 공동 1위 다음에 3위
    RANK()OVER (PARTITION BY deptno ORDER BY SAL DESC) sal_rank,
    --dense_rank는 공동1위 후에 2위로 됨.
    DENSE_RANK()OVER (PARTITION BY deptno ORDER BY SAL DESC) sal_denserank, 
    --row_number는 공동순위 자체가 없다. ROWNUM과 다른점은 그냥 PARTITION의 차이.
    ROW_NUMBER()OVER (PARTITION BY deptno ORDER BY SAL DESC) sal_row_number
FROM emp;

-- ROWNUM 번호부여하기. 
select emp.*, ROWNUM
FROM emp;

RANK()OVER (PARTITION BY deptno ORDER BY SAL DESC) SAL_RANK
PARTITION BY deptno : 
ORDER BY sal : 
RANK() : 

실습1
사원 전체 급여 순위 rank, dense_rank, row_number를 이용하여
단, 급여가 동일할 경우 사번이 빠른 사람이 높은 순위가 되도록.

SELECT empno, ename, sal, deptno, 
    RANK() OVER(ORDER BY sal desc, empno asc) sal_rank,
    dense_RANK() OVER(ORDER BY sal desc,empno ) dense_rank,
    row_number() OVER(ORDER BY sal desc) row_number
FROM emp;

부서별 사원수
10, 3
20, 5
30, 6
select deptno, count(*)
from emp
group by deptno;

select count(*)
from emp;

select * 
from emp
order by job, sal, hiredate;

실습2
기존의 배운 내용을 활용하여,
모든 사원에 대해 사원번호, 사원이름, 해당사원이 속한 부서의 사원수를 조회하는 쿼리를 작성하세요.
--분석함수
select empno, ename, deptno, 
    count(*) OVER(partition by deptno) cnt
from emp;

--분석함수 안쓰고 from_subquery join이라 부른다.
--단점 테이블 두개를 읽는다.
select a.empno, a.ename, a.deptno, cnt
from emp a, (select deptno, count(*) cnt
            from emp
            group by deptno) b
where a.deptno = b.deptno;

--select 안에 있으면 스칼라 서브쿼리라 부른다.
--단점 행을 실행할 때마다 subquery를 실행한다.
10 : SELECT COUNT(*) 
     FROM emp 
     WHERE deptno = 10;
20 : SELECT COUNT(*)
     FROM EMP
     WHERE DEPTNO = 20;
select a.empno, a.ename, a.deptno, 
    (select count(*)
        from emp
        where deptno = a.deptno)cnt
from emp a
order by deptno;

WHERE : 조회되는 행을 제한, WHERE절에 기술한 조건이 해당행을 대상으로 참(TREU)으로 판단 될 경우 조회

SELECT *
FROM emp
WHERE 1=1;

--부서별 부서원수를 4번째 칼럼으로 조회
집계함수 : count, sum, avg, max, min
--효율적이다. table을 한번만 쓰니까!
SELECT empno, ename, deptno,
    COUNT(*) OVER(PARTITION BY deptno) cnt
FROM emp
ORDER BY deptno desc;

실습 2

window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 본인급여, 부서번호와 해당 사원이 속한 부서의 급여 평균을
조회하는 쿼리를 작성하세요.(급여 평균은 소수점 둘째 자리까지 구한다)

SELECT empno 사원번호, ename 사원이름, sal 본인급여, deptno 부서번호, 
       round(AVG(SAL) OVER ( PARTITION BY deptno ), 2 ) sal_avg,
       TO_CHAR(AVG(SAL) OVER ( PARTITION BY deptno ), 'fm9999.00' ) sal_avg1
FROM emp;

실습 3
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 본인 급여, 부서의 가장 높은 급여를 조회하는 쿼리를 작성하시오

SELECT empno 사원번호, ename 사원이름, sal 본인급여, 
        MAX(sal) OVER (PARTITION BY deptno) max_sal,
        MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

과제 : 위의 sql을 분석함수를 사용하지 않고 작성하기
--1.
SELECT a.empno 사원번호, a.ename 사원이름, a.sal 본인급여, max, min
    from emp a, (SELECT deptno a, max(sal) max, min(sal) min
                from emp
                group by deptno) b
    where a.deptno = b.a
    order by 3;
--2.
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

    
    
    