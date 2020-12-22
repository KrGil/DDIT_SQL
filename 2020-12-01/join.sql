2020-12-01-03) Join
    - rdb의 핵심 기능
    - 관계형데이터 베이스는 자료가 여러 테이블에 분산되어 저장되고
        테이블 간의 관계가 맺어져 있음
    - 따라서 여러 테이블에서 필요한 자료를 조회하기 위해 조인연산이 필요
    - 조인연산은 연산에 참여하는 테입르 간의 관계가 맺어져 있음을 전제로 함
    (조인의 종류)
    1)방식에 따라 : 일반조인, ansi 조인
    2)조인 조건에 사용하는 연산자에 따라 equi join, non equi join
    3)참가하는 행들의 확장 여부에 따라 내부조인(inner join), 외부조인(outer join)
    4)그 밖에 self join, cartesian product(cross join) 등으로 나뉨.
    (사용형식)
    select 컬럼list
        from 테이블명1 [별칭1], 테이블명2 [별칭2] [,테이블명3 [별칭3],...]
        where 조인조건1
        [and 조인조건2,...]
        [and 조인조건,...]
        . 테이블명에는 별칭을 사용하여 동일한 컬럼명이 두개 이상의 테이블에 사용된 경우 소속을 구별해줌
        . 별칭을 사용하지 않는 경우 동일한 컬럼명은 '테이블명, 컬럼명' 형식으로 기술해야함
        . 조인조건은 두 테이블 사이에 존재하는 같은 값을 갖는 컬럼간의 동등성('=')등을 
          평가하기 위한 조건으로 n개의 테이블이 사용된 경우 적어도 n-1개의 조인조건이 필요함
        . 일반조건과 조인조건의 기술 순서는 일정한 규칙이 없음.

1. cartesian product
    - 모든 행, 모든 열의 조합이 발생(행들은 곰한 값
    - 특별한 목적이 아닌 경우 사용되지 않음
    - 조인조건이 없거나 잘못 설정된 경우에두 발생됨.
    - ansi에서는 cross join
예);
select count(*) from cart;
select count(*) from customers;
select count(*)
    from cart a, customers b;
(ansi 형식);
select count(*)
    from cart cross join customers;
select count(*)
    from cart cross join customers cross join prod;


select 55500*209 from dual;

2. equi join(동등 조인)
    - 대부분의 조인 형식
    - 조인조건에 '='연산자가 사용됨
    - ansi에서는 inner join으로 구현됨
    (ansi 사용형식)
    select 컬럼list
    from 테이블명1[별칭]
        inner join 테이블명2[별칭] on (조인조건
            [and 일반조건])
        [inner join 테이블명3[별칭] on (조인조건
            [and 일반조건])]
    [where 일반조건]

예)장바구니테이블에서 2005년 6월 판매현황을 조회하시오
    일자, 회원명, 상품명, 판매수량, 판매금액;
select * from cart;
select * from member;
select *from prod;

-- 경유해서 가져오기 --
select to_date(substr(a.cart_no,1,8)) 일자,
        b.mem_name 회원명, 
        c.prod_name 상품명, 
        a.cart_qty 판매수량, 
        a.cart_qty*c.prod_price 판매금액
    from cart a, member b, prod c
    where a.CART_MEMBER = b.mem_id  --조인조건
        and a.cart_prod = c.prod_id --조인조건
        and A.cart_no like '200506%'
    order by 1;
    
    -- 부모테이블의 자식테이블의 기본키가 되는걸 식별관계
    -- 부모테이블의 자식테이블의 일반키가 되는걸 비식별관계