2020-12-04-02)
예)사원들의 평균급여보다 많은 급여를 받는 사원을 출력하시오
    회원번호, 사원명, 급여
    
(where 절에 서브쿼리 사용);
--한번한번 서브쿼리 사용함.. 느려짐
select employee_id 사원번호,
        emp_name 사원명,
        salary 급여
    from employees
    where salary > (select avg(salary)
                        from employees)
    order by 3 desc;

(from 절에 서브쿼리 사용);
--한번만 서브쿼리 사용
select employee_id 사원번호,
        emp_name 사원명,
        salary 급여
    from employees a, (select avg(salary) sal
                        from employees) b
    where salary > b.sal
    order by 3 desc;