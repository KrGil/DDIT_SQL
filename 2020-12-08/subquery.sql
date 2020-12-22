2020-12-08-01)
예) 2005년 1~6월 모든 거래처별 매출현황을 조회하시오.
    거래처코드, 거래처명, 매출액

(일반 outer join);
    select a.buyer_id 거래처코드, 
            a.buyer_name 거래처명, 
            sum(b.cart_qty*c.prod_price) 매출액
        from buyer a,cart b, prod c
        where b.cart_prod(+) = c.prod_id
            and a.buyer_id = c.prod_buyer(+)
            and substr(b.cart_no, 1,6) between '200501' and '200506'
        group by a.buyer_id, a.buyer_name
        order by 1;

select * from buyer;
select * from cart;
(ansi outer)   ;    
    select a.buyer_id 거래처코드, 
            a.buyer_name 거래처명, 
            sum(b.cart_qty*c.prod_price) 매출액
        from buyer a 
            left outer join prod c on(a.buyer_id = c.prod_buyer)
            left outer join cart b on(c.prod_id = b.cart_prod
            and substr(b.cart_no,1,6) between '200501' and '200506')
    group by a.buyer_id, a.buyer_name
    order by 1;
    
select * from buyer;
select * from cart;
select * from prod;
(subquery);
    select a.buyer_id 거래처코드,
            a.buyer_name 거래처명,
            b.amt 매출액
        from buyer a,(select buyer_id bid,
                            sum(cart_qty*prod_price) amt
                        from buyer, cart, prod
                        where buyer_id = prod_buyer
                            and prod_id = cart_prod
                            and substr(cart_no, 1, 6) between '200501' and '200506'
                        group by buyer_id) b
        where a.buyer_id=b.bid(+);
        
2005년 1~6월 거래처별 매출액-내부조인
    select buyer_id bid,
    sum(cart_qty*prod_price) amt
    from buyer, cart, prod
    where buyer_id = prod_buyer
    and prod_id = cart_prod
    and substr(cart_no, 1, 6) between '200501' and '200506'
    group by buyer_id;
    
예) 2005년 모든 제품별 매입/매출을 조회하시오
    alice 상품코드, 상품명, 매입수량, 매출수량, 매입금액, 매출금액
select * from prod;
select * from cart;
select * from buyprod;

select a.prod_id 상품코드, 
        a.prod_name 상품명, 
        b.bqty 매입수량, 
        c.cqty 매출수량, 
        b.bamt 매입금액, 
        c.camt 매출금액
    from prod a,(select buy_prod bprod,
                        sum(buy_qty) bqty,
                        sum(buy_qty *buy_cost) bamt
                    from buyprod
                    where buy_date between '20050101' and '20051231'
                    group by buy_prod) b, (select cart_prod cprod, 
                                                    sum(cart_qty) cqty,
                                                    sum(cart_qty * prod_price) camt
                                                from cart, prod
                                                where cart_prod = prod_id
                                                and cart_no like '2005%'
                                                group by cart_prod) c
    where a.prod_id = b.bprod(+)
    and a.prod_id = c.cprod(+);

(2005년 제품별 매입집계);
select buy_prod bprod,
        sum(buy_qty) bqty,
        sum(buy_qty *buy_cost) bamt
    from buyprod
    where buy_date between '20050101' and '20051231'
    group by buy_prod;

(2005년 제품별 매출집계);
select cart_prod cprod, 
      sum(cart_qty) cqty,
      sum(cart_qty * prod_price) camt
    from cart, prod
    where cart_prod = prod_id
    and cart_no like '2005%'
    group by cart_prod;
    
select a.prod_id 상품코드,
        a.prod_name 상품명, 
        c.bqty 매입수량, 
        b.CART_QTY 매출수량, 
        c.bcost 매입금액, 
        sum(b.cart_qty *a.prod_price) 매출금액
    from prod a,cart b,(select buy_qty bqty, 
                          sum(buy_qty * buy_cost) bcost
                         from buyprod
                        group by buy_qty) c
    group by a.prod_id, a.prod_name, c,bqty, b.cart_qty, c.bcost;
                        
    

예) 사원테이블에서 부서별 가장 낮은 급여를 조회하고 누가 그 급여를 받는지 조회하시오
    사원번호, 사원명, 부서번호, 부서명, 급여
;
select * from employees;
select * from departments;
(메인쿼리 : 사원테이블에서 사원번호, 사원명, 부서번호, 부서명, 급여 조회);
select a.employee_id 사원번호, 
        a.emp_name 사원명,
        d.did 부서번호, 
        d.dname 부서명, 
        a.salary 급여
    from employees a, (select b.department_id did, 
                                c.department_name dname, 
                                min(b.salary) msal
                             from employees b, departments c
                            where b.DEPARTMENT_ID = c.department_id
                            group by b.department_id, c.department_name
                            order by 1) d
    where a.department_id = d.did
        and a.salary = d.msal
    order by 3;
(서브쿼리 : 부서별 최소임금 );
select b.department_id did, 
    c.department_name dname,
    min(b.salary) msal
from employees b, departments c
where b.DEPARTMENT_ID = c.department_id
group by b.department_id, c.department_name
order by 1;

select c.msal
    from employees b, (select department_id did, min(salary) msal
                            from employees a
                            group by department_id) c
    where b.DEPARTMENT_ID = c.did;
    
select department_id, min(salary) 
    from employees
    group by department_id;
    
예)사원테이블과 직무테이블(jobs)을 사용하여 각 직무별 최소급여를 조회하고
    해당 직무를 가지고 있는 사원 중 최소급여를 받는 사원정보를 조회하시오.
    사원번호, 사원명, 직무코드, 직무명, 급여
    (메인쿼리 : 사원번호, 사원명, 직무코드, 직무명, 급여)
    ;
select * from employees;
select * from jobs;

select  a.employee_id 사원번호,
        a.emp_name 사원명,
        a.job_id 직무코드,
        b.job_title 직무명,
        a.salary 급여
    from employees a, jobs b
    where a.job_id = b.job_id
        and (a.job_id, a.salary) in (select job_id 직무, min(salary)최저급여
            --2개의 컬럼과 2개의 컬럼 비교
                                         from employees
                                        group by job_id)
    order by 3;
        
    (서브쿼리 : 직무별 최저급여(jobs테이블의 min_salary가 아님 이건 초봉임.);
select job_id 직무, min(salary)최저급여
    from employees
    group by job_id;
    

예) 사원테이블에서 부서명이 '배송부'인 직원정보를 서브쿼리를 사용하여 조회
    사원번호, 사원명, 부서명, 급여

select * from employees;
select * from departments;

select department_id did, department_name d
    from departments
    where department_name = '배송부'; 
    
----- from절에 쓰기    
select b.employee_id 사원번호, 
        b.emp_name 사원명, 
        c.d 부서명, 
        b.salary 급여
    from  employees b, (select department_id did, department_name d
                                        from departments
                                        where department_name = '배송부') c
    where b.department_id = c.did;

----- where절에 쓰기
select a.department_id 사원번호, 
        b.emp_name 사원명, 
        a.DEPARTMENT_NAME 부서명, 
        b.salary 급여
    from departments a, employees b
    where a.DEPARTMENT_id in (select department_id
                                    from departments
                                    where department_name = '배송부') 
        and a.department_id = b.department_id;




