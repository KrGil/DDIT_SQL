그룹 내 행 순서

--행간 계산 이건 앞 모든 행
window 함수에 대상이 되는 행을 지정
UNBOUNDED PRECEDING
    현재 행기준 모든 이전행
CURRENT ROW
    현재행
UNBOUNDED FOLLOWING
    현재 행 기준 모든 이후행

메타 인지 : 내가 무엇을 모르는지 아는 상황
--나 앞으로 나 자신까지 order by
SELECT empno, ename, sal, 
    SUM(sal) OVER (ORDER BY sal)
FROM emp;

SELECT empno, ename, sal, -- row
       SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM emp;

-- 행간 계산하기!! 요건 지정해 줄 수 있다.
windowing
    - window 함수에 대상이 되는 행을 지정
    n PRECEDING
    - 현재 행 기준 이전N행
    n FOLLOWING
    - 현재 행 기준 이후N행
    
실습 7
사원번호, 사원이름, 부서번호, 급여 정보를 부서별로 급여, 사원번호
오름차순으로 정렬 햇을 때, 자신의 급여와 선행하는 사원들의 급여 합을
조회하는 쿼리를 작성하시오(WINDOW 함수 사용)
SELECT * FROM emp;
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno 
--                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                 ) c_sum
FROM emp;

범위설정 WINDOWING - DEFAULT
RANGE UNBOUNDED PRECEDING
--두개 같은 표현이다.
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

-- RANGE와 ROWS의 차이점.
분석합수에서 ORDER BY 절 이후에 WINDOWING 절을 생략할 경우 다음의WINDOWING이 기본으로 적용된다.
RANGE UNBOUNDED PRECEDING
== RANGE BETWEEN INBOUNDED PRECEDING AND CURRENT ROW
ROWS: 물리적인 행의 단위 (동일한 값을 제외하고 자기 자신만을)
RANGE : 논리적인 행의 단위 (동일한 값을 포함하고 자기 자신만을) --동일한 값을 들고 있으면 하나의 행으로 여긴다. 논리적으로 맞음.

SELECT empno, ename, sal,
    SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
    SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
    SUM(sal) OVER (ORDER BY sal) default_sum
FROM emp;


ROWNUM : select 순서대로 반환된 행의 번호를 1부터 부여해주는 함수
특징 : WHERE절에서 사용 가능
      행을 건너뛰는 형태로 사용 불가
      ==> ROWNUM이 1부터 순차적으로 사용된 경우에만 사용가능
      WHERE ROWNUM = 1; (O)
      WHERE ROWNUM = 2; (X) //1을 건너 뛰었기 때문에 정상적으로 조회되지 않음.
      WHERE ROWNUM < 5; (0) 1~4
      WHERE ROWNUM > 5; (X) 1~4를 읽지 않고 건너 뜀
      
        
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM =1;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM =2;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM < 5;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM >5;

SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate DESC;

--페이지 사이즈가 10일 때 
1 PAGE : 1~10
2 PAGE : 11~20
N PAGE : (N-1) * 10 + 1 ~ N*10
--N PAGE : (:page - 1) * :pageSize + 1 ~ :page * :pageSize

--페이즈 사이즈가 5일 때
1 PAGE : 1~5
2 PAGE : 6~10
3 PAGE : 11~15

SELECT ROWNUM, a.*
 FROM 
    (SELECT empno, ename, hiredate
     FROM emp
     ORDER BY hiredate DESC) a 
WHERE ROWNUM BETWEEN 1 AND 10; -- 1PAGE
     
--오라클은 이렇게 인라인뷰를 이용해서 ROWNUM을 해야한다.
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM -- 여기만 바꾸면 된다.
        (SELECT empno, ename, hiredate
         FROM emp
         ORDER BY hiredate DESC) a )
WHERE rn BETWEEN 11 AND 20; -- 2PAGE

--바인딩 
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM -- 여기만 바꾸면 된다.
        (SELECT empno, ename, hiredate
         FROM emp
         ORDER BY hiredate DESC) a )
WHERE rn BETWEEN :st AND :ed; -- 2PAGE

-- 페이징 로직!
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM -- 여기만 바꾸면 된다.
        (SELECT empno, ename, hiredate
         FROM emp
         ORDER BY hiredate DESC) a )
WHERE rn BETWEEN (:page - 1) * :pageSize + 1 AND :page * :pageSize ; -- 페이징 로직
-- 값 줄 때 엔터가 들어가면 안된다!!