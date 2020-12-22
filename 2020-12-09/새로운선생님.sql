
--실행결과 알기 
explain plan for
select *
    from jobs j, employees e
    where j.job_id = e.job_id;

select *
from table(dbms_xplan.display);

--가장 많은 급여를 받는 사람의 employee_id 구하기
select employee_id, Max(salary)
from employees
group by employee_id;

--14
select * from emp;
--4
select * from dept;

제약조건
0. Unique : 값에 중복을 허용하지 않음. 단 null은 가능
1. Primary key == unique + not null
	==> 중복방지 / 해당컬럼 값이 테이블에서 유일함을 보장, null 값이 들어갈 수 없다.
2. fk(forein key) 참조 무결성
3. check 제약
not null

--전체적인 제약조건 보기
select * 
from user_constraints
where table_name in ('EMP', 'DEPT');

--primary key 보기
select *
from user_cons_columns
--where constraint_name = upper('pk_lprod');
where constraint_name = upper('pk_buyer');

--오라클에서 ()가 없는 함수는 ()를 뺀다. ex) sysdate
사원의 부서별 급여(sal)별 순위 구하기
select * from emp;
select 

분석함수 / window 함수 -- 둘다 같은말이다.
select window_funtion([arg])
over ([partition by columns] [order by columns] [windowing])
--over가 나오면 분석함수다!!


영역설정
partition by 컬럼코드

순서설정
order by 컬럼코드 [desc|asc]

범위설정(windowing)
ROWS|RANGE BETWEEN UNBOUNDED PRECEDING[CURRENT ROW]
AND UNBOUNDED FOLLOWING[CURRENT ROW]


