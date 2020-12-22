2020-12-04-01)서브쿼리
    - 쿼리 안에 포함된 또다른 쿼리를 서브쿼리라고 함
    - 서브쿼리는 '( )'안에 기술
    - 각 절에서 제일 먼저 실행됨
    - 연산자와 같이 사용될 경우 연산자 오른쪽에 사용해야 함
    (서브쿼리의 종류)
    - 메인쿼리와 연관성 여부에 따라 : 연관성 있는 서브쿼리(Correlated Subquery)와 
      비연관성 서브쿼리(Noncorrelated subquery)로 구분
    - 사용되는 위치에 따라 : 일반서브쿼리(select 절에 사용), 인라인 서브쿼리(from 절에 사용),
                          중첩서브쿼리(where 절에 사용)으로 구분
    - 반환하는 행/열의 수에 따라 : 단일행/단일열, 다중행/단일열, 다중행/다중렬 등으로 구분되며
      이는 사용하는 연산자에 의해 구별됨.
      
1. 연관성 없는 서브쿼리
    - 메인쿼리와 서브쿼리사이에 조인이 발생되지 않는 서브쿼리
    예) 사원테이블에서 평균급여보다 많은 급여를 받는 사원정보(사원번호, 사원명, 부서코드, 급여) 조회
    (메인쿼리 : 사원번호, 사원명, 부서코드, 급여 조회)
    
    select employees_id as 사원번호,
            emp_name as 사원명,
            department_id as 부서코드,
            salary as 급여 
        from employees
        where salary >=(평균급여);
    
    (서브쿼리 : 평균급여)
    select avg(salary)
    from employees;
    
   select employee_id as 사원번호,
        emp_name as 사원명,
        department_id as 부서코드,
        salary as 급여 
    from employees
    where salary >= (select avg(salary)
                    from employees);

예)부모부서코드(parent_id)가 null인 부서에 소속된 사원정보를 조회하시오
    사원번호, 사원명, 부서코드, 직책코드(job_id)
    (메인쿼리 : 사원테이블에서 사원벙보를 조회)
select employee_id 사원번호,
        emp_name 사원명, 
        department_id 부서코드, 
        job_id 직책코드(job_id)
    from employees
    where department_id =부모부서코드(parent_id)가 null인 부서;
    
(서브쿼리 : 부서테이블에서 부모부서코드(parent_id)가 null인 부서코드)
select department_id
    from departments
    where parent_id is null;

부서테이블에서 부서코드 60(IT)의 부모부서코드를 null로 변경)
    update departments
        set parent_id = null
        where department_id = 60;   

(결합);
select a.employee_id 사원번호,
        a.emp_name 사원명, 
        a.department_id 부서코드, 
        a.job_id 직책코드
    from employees a
    where exists (select department_id
                     from departments b
                    where parent_id is null
                    and a.department_id = b.DEPARTMENT_ID);
2. 연관성 서브쿼리
    - 메인쿼리와 서브쿼리 사이에 조인이 발생되는 서브쿼리

예) 직무이력테이블(job_history)의 사원정보를 조회하시오
    사원번호, 사원명, 부서코드, 부서명이다.
select * from job_history;
select * from employees;

select a.employee_id 사원번호, 
       (select b.emp_name
            from employees b
            where a.employee_id = b.employee_id) 사원명,
        a.department_id 부서코드,
        (select c.department_name
            from departments c
            where a.department_id = c.department_id) 부서명
    from job_history a;
    
예제) 상품테이블에서 서브쿼리를 사용하여 'P300'번대의 상품의
    상품코드, 상품명, 분류코드, 분류명을 출력하시오
select * from prod;
select * from lprod;
select lprod_gu 
    from lprod b
    where a.prod_lgu = b.lprod_gu and b.lprod_gu like 'P30%';

select a.prod_id 상품코드, 
        a.prod_name 상품명, 
        a.prod_lgu 분류코드, 
       (select lprod_gu 
            from lprod b
            where a.prod_lgu = b.lprod_gu ) 분류명
    from prod a
    where a.prod_lgu like 'P3%';

예)사원들의 평균급여를 계산하여 평균급여보다 더 많은 급여를 받는 사원들이 소속된
    부서코드와 부서명을 출력하시오(subquery 사용)
    (메인쿼리 : 부서테이블에서 부서코드와 부서명을 출력)
select a.department_id 부서코드,
        a.department_name 부서명
    from department a
    where a.department_id in (평균급여보다 더 많은 급여를 받는 사원들이 소속된 부서);

(서브쿼리1 : 사원테이블에서 평균급여보다 더 많은 급여를 받는 사원들이 소속된 부서);
select b.department_id
    from employees b
    where b.salary > (평균급여);

select b.department_id
    from employees b
    where b.salary > (select avg(salary)
                        from employees);

(서브쿼리2 : 평균급여);
select avg(salary)
    from employees;

(결합); -- in
select a.department_id 부서코드,
        a.department_name 부서명
    from departments a
    where a.department_id in (select b.department_id
                                from employees b
                                where b.salary > (select avg(salary)
                                                    from employees))
    order by 1;
-- exists
select a.department_id 부서코드,
        a.department_name 부서명
    from departments a
    where exists (select 1
                    from employees b
                    where a.DEPARTMENT_ID = b.department_id
                        and b.salary > (select avg(salary)
                                        from employees))
    order by 1;
    
예)상위부서가(parent_id) 90번부서(기획부)인 사원들의 급여를 자신이 속해있는 부서의
    평균급여에 10% 인상하시오.
select * from departments;
select *from employees;

(메인 : 상위부서가 90번인 부서인 부서의 평균 급여;
select a.department_id, 
        avg(a.salary) 
    from employees a, departments b
    where a.department_id = b.department_id 
        and b.parent_id = 90
    group by a.department_id;

commit;
(update);
update employees c
    set c.salary = (select round(c.salary + aa.avg)
                    from (select a.department_id deptid,
                                (avg(a.salary)*0.1) avg
                            from employees a, departments b
                            where a.department_id=b.department_id
                                and b.parent_id = 90
                            group by a.department_id) aa
                    where c.department_id = aa.deptid)
    where c.department_id in (select department_id
                                from departments
                                where parent_id=90);
    
select c.department_id 부서번호, 
        c.salary 급여
    from employees c, (select aa.avg
                            from (select a.department_id deptid,
                                        round(avg(a.salary)*1.1) avg
                                    from employees a, departments b
                                    where a.department_id=b.department_id
                                        and b.parent_id = 90
                                    group by a.department_id) aa
                            where c.department_id = aa.deptid);
select aa.avg
    from (select a.department_id deptid,
                round(avg(a.salary)*1.1) avg
            from employees a, departments b
            where a.department_id=b.department_id
                and b.parent_id = 90
            group by a.department_id) aa;
            
select a.department_id,
        round(avg(a.salary)*1.1) avg
    from employees a, departments b
    where a.department_id=b.department_id
        and b.parent_id = 90
    group by a.department_id;

select department_id 사원이름, 부서명, avg(salary)평균급여
    from departments a;

create or replace view v_emp01
as
    select a.emp_name, a.salary, a.department_id
        from employees a
        where a.department_id in(select department_id
                                    from departments
                                    where parent_id =90)
        order by 3
        with read only;
--
select * from v_emp01;

select a.emp_name, a.salary, a.department_id
    from employees a
    where a.department_id in(select department_id
                                from departments
                                where parent_id =90)
    order by 3;
rollback;
select salary, emp_name 
    from employees
    where department_id = 70;
    8200
    7700
    7800
    6900
    
update employees
    set salary = 8200
    where emp_name = 'John Chen';
