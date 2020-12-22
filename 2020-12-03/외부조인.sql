2020-12-03-01)외부조인 -- 종류가 부족할 때...
 - 내부조인은 조인조건을 만족하지 않는 행(row)는 검색에서 제외
 - 외부조인은 부족한 테이블에 null값으로 채워진 행을 삽입하여 조인 수행 
 - 조인조건 기술 시 부족한 테이블에 포함된 컬럼뒤에 외부조인 연산자 
   '(+)'를 사용 : 일반 외부조인
 - 하나 이상의 조인 조건이 외부조인되는 경우 모든 조인 조건에 '(+)'연산자 사용
 - 하나의 테이블이 동시에 확장되는 외부조인은 허용되지 않는다. 즉, a,b,c 테이블을
   외부조인하는 경우 a를 기준으로 b를 외부조인하는 동시에 c를 기준으로 b를 
   외부조인하지 못함 --부족한 테이블쪽에다가 (+)를 해준다.
   ex) where a.Col = b.Col(+) -- 이 테이블에다가 null을 넣어서 확장해 주어라.
            and c.col = b.col(+) -- 허용안됨 하나의 테이블에 서로다른테이블로 확장은 되지 않는다.    
 - 일반조건이 추가된 외부조인은 일반외부조인을 사용하면 내부조인결과를 반환 -- ansi 외부조인 이나 subquery
 (ansi 외부조인 사용 형식) --정확한 결과
 select 컬럼list
    from 테이블명[별칭]
    full|right|left outer join 테이블명2[별칭] on(조인조건
                        [and 일반조건1])
    [full|right|left outer join 테이블명3[별칭] on(조인조건
                        [and 일반조건2])]
    [where 일반조건]
        .full : 양쪽 테이블 모두 확장
        .right : 테이블명2가 테이블명1보다 더 많은 종류의 자료가 있는 경우(테이블명1이 확장되는 경우)
        .left : 테이블명1이 테이블명2보다 더 많은 종류의 자료가 있는 경우(테이블명2가 확장되는 경우)
        .일반조건1, 일반조건2는 해당 테이블들에만 적용되는 조건
        .where 절의 일반조건은 전체에 적용될 조건 --주의
        
예)모든 회원들에 대한 매출집계를 조회하시오
    회원번호, 회원명, 매출액합계;
select *from member;
select distinct(cart_prod)from cart;
select distinct(prod_id) from prod;

select (a.cart_prod) a,
       (b.prod_id) b
    from cart a, prod b
    where a.cart_prod(+) = b.prod_id;
    
-- oracle
select a.mem_id 회원번호, a.mem_name 회원명, 
        nvl(sum(b.CART_QTY*c.prod_price),0) 매출액합계
    from member a, cart b, prod c
    where a.mem_id = b.cart_member(+)
        and b.CART_PROD = c.prod_id(+)
    group by a.mem_id, a.mem_name
    order by 1;
-- ansi
select a.mem_id 회원번호, a.mem_name 회원명, 
        nvl(sum(b.CART_QTY*c.prod_price),0) 매출액합계
    from member a
            left outer join cart b on (a.mem_id = b.cart_member)
            left outer join prod c on (b.CART_PROD = c.prod_id)
    group by a.mem_id, a.mem_name
    order by 1;
    
예) 2005년 3월 매입한 모든 상품별 매입집계를 조회하시오
상품코드, 상품명, 매입수량, 매입금액
(4월에 판매된 상품의 종류);
select count(distinct buy_prod) 상품코드
    from buyprod
    where buy_date between '20050201' and '200502280';
    
(일반외부조인);
select a.BUY_PROD 상품코드, b.prod_name 상품명, sum(a.buy_qty) 매입수량, sum(a.buy_qty*a.buy_cost)매입금액
    from buyprod a, prod b
    where a.BUY_PROD(+) = b.prod_id --29개
--        and a.buy_date between '20050201' and '20050228' -- 안하면 74개...
    group by a.BUY_PROD,b.prod_name;
    
--ansi
select b.pROD_id 상품코드, b.prod_name 상품명, nvl(sum(a.buy_qty),0) 매입수량, nvl(sum(a.buy_qty*a.buy_cost),0)매입금액
    from buyprod a
        right outer join prod b on(a.BUY_PROD(+) = b.prod_id
        and a.buy_date between '20050201' and '20050228') -- 안하면 74개...
    group by b.pROD_id, b.prod_name
    order by 1;


--subquery
select buy_prod id, buy_qty qty, buy_cost 
    from buyprod
    where buy_date between '20050201' and '20050228';
select * from prod;

select a.prod_id 상품코드, 
        a.prod_name 상품명, 
        nvl(sum(b.qty),0) 매입수량, 
        nvl(sum(b.qty*b.buy_cost),0) 매입금액
    from prod a, (select buy_prod id, 
                        buy_qty qty, 
                        buy_cost 
                    from buyprod 
                    where buy_date between '20050201' and '20050228') b
    where b.id(+) = a.prod_id
    group by a.prod_id, a.prod_name
    order by 1;

예제)모든 분류별 상품의 수를 조회하시오
상품분류코드, 분류명, 상품의 수
--ansi
select *from lprod;
select * from prod;
select count(distinct prod_lgu) from prod;
select a.lprod_gu 상품분류코드, 
        a.lprod_nm 분류명, 
        count(b.prod_lgu) "상품의 수"
    from lprod a
        left outer join prod b on(a.lprod_gu = b.prod_lgu)
    group by a.lprod_gu, a.lprod_nm
    order by 1;

--oracle
select a.lprod_gu 상품분류코드, 
        a.lprod_nm 분류명, 
        count(b.prod_lgu) "상품의 수" -- count()안에 null값이 없는 기본키를 쓰는게 제일 안전함.
    from lprod a , prod b
    where a.lprod_gu = b.prod_lgu(+)
    group by a.lprod_gu, a.lprod_nm
    order by 1;

--subquery
select count(*) "상품의 수"
    from prod;
select a.lprod_gu 상품분류코드, 
        a.lprod_nm 분류명, 
        nvl(b.cnt,0) "상품의 수"
    from lprod a , (select count(*) cnt, prod_lgu
                        from prod 
                        group by prod_lgu) b
    where a.lprod_gu = b.prod_lgu(+)
    order by 1;
    
예제) 사원테이블에서 모든 부서별 평균급여를 계산하시오
평균급여는 수숫점없이 출력하고, 부서코드 부서명, 평균급여를 출력할것
select * from employees;
select * from departments;
--ansi
select a.department_id 부서코드, 
        nvl(a.DEPARTMENT_NAME,'사장') 부서명, 
        round(avg(b.SALARY)) 평균급여
    from departments a 
        full outer join employees b on(a.department_id = b.department_id)
    group by a.department_id, a.DEPARTMENT_NAME
    order by 1;
--oracle
select a.department_id,0 부서코드, 
        a.DEPARTMENT_NAME 부서명, 
        round(avg(b.SALARY)) 평균급여
    from departments a, employees b
    where a.department_id = b.department_id(+)
    group by a.department_id, a.DEPARTMENT_NAME
    order by 1;
--subquery
select department_id did, round(avg(salary)) avg 
    from employees
    group by department_id;
    
select a.department_id 부서코드, 
        a.DEPARTMENT_NAME 부서명, 
        avg 평균급여
    from departments a, (select department_id did, round(avg(salary)) avg 
                            from employees
                            group by department_id) b
    where a.department_id = b.did(+)
    order by 1;

예제) 2005년 6월 제품별 입출고 현황을 조회하시오
    상품코드, 상품명, 입고수량합계, 매입액합계, 출고수량합계, 매출액합계
select * from prod;
select * from buyprod;
select * from cart;

select c.prod_id 상품코드,
        c.prod_name 상품명, 
        nvl(sum(a.buy_qty),0) 입고수량합계, 
        nvl(sum(a.buy_qty*c.prod_cost),0) 매입액합계, 
        nvl(sum(b.cart_qty),0)출고수량합계,
        nvl(sum(b.cart_qty*c.prod_price),0)매출액합계
    from prod c
        left outer join buyprod a on (c.prod_id = a.buy_prod
            and a.BUY_DATE between '20050601' and '20050630')
        left outer join cart b on(b.cart_prod = c.prod_id
            and substr(b.cart_no,1,6)='200506')
    group by c.prod_id, c.prod_name
    order by 4 desc;



