2020-12-02-01)
예)상품테이블에서 상품의 분류코드가 'P200'대의 상품을 조회하시오
상품코드, 상품명, 분류코드, 분류명, 판매가격
(일반 조인)
select * from prod;
select * from lprod;
select a.prod_id 상품코드, a.prod_name 상품명, a.prod_lgu 분류코드, 
        b.lprod_nm 분류명, a.prod_price 판매가격
    from prod a , lprod b
    where a.prod_lgu like 'P2%' --일반조건
        and a.prod_lgu = b.lprod_gu
    order by 3;

(ansi 조인)
select a.prod_id 상품코드, a.prod_name 상품명, a.prod_lgu 분류코드, 
        b.lprod_nm 분류명, a.prod_price 판매가격
    from prod a
        inner join lprod b on(a.prod_lgu = b.lprod_gu) --조인조건
    where a.prod_lgu like 'P2%' --일반조건
    order by 3;
    
예제) 2005년 1월 1일 ~ 15일 동안 발생된 매입자료

select * from buyprod;
select * from prod;
select buy_date  
    from buyprod
    where buy_date between '20050101' and '20050115';
select a.buy_date 일자, 
        a.BUY_PROD 상품코드, 
        b.prod_name 상품명,
        a.BUY_QTY 수량,
        a.buy_qty * a.BUY_COST 금액
    from buyprod a, prod b
    where a.BUY_PROD = b.prod_id --join조건
        and a.BUY_DATE between '20050101' and '20050115';
-- outer 모든 테이블을 출력한다.
-- inner 조건에 해당하는 값들만 출력한다.
-- ansi
select a.buy_date 일자, 
        a.BUY_PROD 상품코드, 
        b.prod_name 상품명,
        a.BUY_QTY 수량,
        a.buy_qty * a.BUY_COST 금액
    from buyprod a 
        inner join prod b on(a.BUY_PROD = b.prod_id --join조건
        and a.BUY_DATE between '20050101' and '20050115') --일반조건
    order by 1;

예제)2005년 5월 제품별 매입/매출현황을 조회하시오
    상품코드, 상품명, 매출액합계, 매입액합계
select * from prod;
select * from buyprod;
select * from cart;

select a.prod_id 상품코드, a.prod_name 상품명,
        sum(c.cart_qty*a.prod_price) 매출액합계,
        sum(b.buy_qty*b.buy_cost) 매입액합계
    from prod a, buyprod b, cart c
    where a.prod_id = b.buy_prod and b.buy_prod = c.cart_prod --join condition
        and c.cart_no like '200505%'
        and b.BUY_DATE between '20050501' and '20050531'
    group by a.prod_id, a.prod_name
    order by 1;

예제)2005년 5월 제품별 매출현황을 조회하시오
select c.prod_id 상품코드, 
        c.prod_name 상품명,
        sum(a.cart_qty * c.prod_price) 매출액합계
    from cart a, prod c
    where a.cart_prod = c.prod_id --join condition
        and a.cart_no like '200505%'
    group by c.prod_id, c.prod_name
    order by 1;

--ansi
select c.prod_id 상품코드, c.prod_name 상품명,
        sum(a.cart_qty*c.prod_price) 매출액합계,
        sum(b.buy_qty*b.buy_cost) 매입액합계
    from cart a
        right outer join prod c on(a.cart_prod = c.prod_id
        and a.cart_no like '200505%')
        left outer join buyprod b on(b.buy_prod=c.prod_id
        and b.BUY_DATE between '20050501' and '20050531')
    group by c.prod_id, c.prod_name
    order by 1;
    
예제) 2005년 1~6월 사이 거래처별 매입현황을 조회하시오.
    거래처코드, 거래처명, 매입액합계
select distinct(buyer_name) from buyer;
select * from prod;
select * from buyprod;

select a.buyer_id 거래처코드, a.buyer_name 거래처명, sum(c.BUY_QTY*c.buy_cost) 매입액합계
    from buyer a, prod b, buyprod c
    where a.buyer_id(+) = b.prod_buyer
        and b.prod_id = c.BUY_PROD(+)
        and c.buy_date between '20050101' and '20050630'
    group by a.buyer_id, a.buyer_name
    order by 1;

--ansi
select a.buyer_id 거래처코드, a.buyer_name 거래처명, sum(c.BUY_QTY*c.buy_cost) 매입액합계
    from buyer a
        right outer join prod b on(a.buyer_id = b.prod_buyer)
        left outer join buyprod c on(b.prod_id = c.buy_prod
        and c.buy_date between '20050101' and '20050630')
    group by a.buyer_id, a.buyer_name
    order by 1;
    
select a.buyer_id 거래처코드, a.buyer_name 거래처명, sum(c.BUY_QTY*c.buy_cost) 매입액합계
    from buyer a
        inner join prod b on(a.buyer_id = b.prod_buyer)
        inner join buyprod c on(b.prod_id = c.buy_prod
        and c.buy_date between '20050101' and '20050630')
        --where는 일반조건이 2개일 시 쓰면 결과가 이상해진다!!
    group by a.buyer_id, a.buyer_name
    order by 1;
    
예제) 장바구니테이블에서 2005년 5월 회원별 구매금액을 조회하시오
    회원번호, 회원명, 구매액
select *from cart;
select *from member;
select *from prod;
    select b.mem_id 회원번호, 
            b.mem_name 회원명, 
            nvl(sum(a.cart_qty*c.prod_price),0) 구매액
        from cart a, member b, prod c
        where a.CART_PROD = c.prod_id   --join 조건 구매액을 구하기 위해(prod_price).
            and a.CART_MEMBER = b.mem_id --join 조건 회원이름 가져오기 위해.
            and substr(a.cart_no,1,6) = 200505
--            and a.cart_no like '200505%'
        group by b.mem_id, b.mem_name
        order by 1;

--ansi 회원이름이 어느 테이블에 속해있는지 알고. 전부 속해있는 테이블(member)을 기준으로
--테이블(member)이 오른쪽에 있으면 right 왼쪽에 있으면 left
        select b.mem_id 회원번호, 
            b.mem_name 회원명, 
            sum(a.cart_qty*c.prod_price) 구매액
        from cart a
            right outer join member b on( a.CART_MEMBER = b.mem_id)
            left outer join prod c on (a.CART_PROD = c.prod_id
            and substr(a.cart_no,1,8) like '200505%')
        group by b.mem_id, b.mem_name
        order by 1;
            
--ansi inner
        select b.mem_id 회원번호, 
            b.mem_name 회원명, 
            sum(a.cart_qty*c.prod_price) 구매액
        from cart a  --이것과 member가 연관이 있어야 서로 비교하여 쓸수 있다.
            inner join member b on( a.CART_MEMBER = b.mem_id)
            inner join prod c on (a.CART_PROD = c.prod_id
            and substr(a.cart_no,1,8) like '200505%')
        group by b.mem_id, b.mem_name
        order by 1;
        
         select b.mem_id 회원번호, 
            b.mem_name 회원명, 
            sum(a.cart_qty*c.prod_price) 구매액
        from member b  --member와 cart가 연관이 있어야 서로 비교하여 쓸수 있다.
            inner join cart a on( a.CART_MEMBER = b.mem_id
            and substr(a.cart_no,1,8) like '200505%')
            inner join prod c on (a.CART_PROD = c.prod_id)
        group by b.mem_id, b.mem_name
        order by 1;

예제) 사원테이블에서 관리자(manager_id)별 사원정보를 조회하시오.

select *from employees;
select * from departments;
select manager_id 관리자번호, 
        department_name 부서명,
        count(*) 소속사원수 
    from departments
    group by manager_id, department_name
    order by 1;
select a.manager_id 관리자번호, 
        b.emp_name 관리자명, 
        count(a.department_name) 소속사원수, 
        a.department_name 부서명
    from departments a, employees b
    where a.DEPARTMENT_ID = b.department_id
    group by rollup(a.manager_id, a.department_name, b.emp_name)
    order by 3;


