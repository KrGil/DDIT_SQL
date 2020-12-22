2020-12-01-02) null 처리함수
    - 연산에 사용되는 항목 중 null을 포함 하는 경우 결과가 null로 반환
    - is [not] null, nvl, nvl2, nullif 등의 함수(연산자)가 제공 됨

1. is [not] null
    - null 값 여부를 비교하기 위해여 '-' 사용은 허용되지 않음.
    - 반드시 is[not] null 연산자를 사용해야 함.

예)사원테이블에서 영업실적코드(commission_pct)가 null이 아닌 사원을 조회하시오.
    사원번호, 사원명, 부서코드, 영업실적
    select employee_id 사원번호,emp_name 사원명, department_id 부서코드, commission_pct 영업실적
        from employees
        where commission_pct = nvl(commission_pct,0);
        where commission_pct is not null;
    
2. nvl(c, val)
    - 'c'(컬럼명)의 값이 null이면 'val'을 반환하고 null이 아니면 'c'의 값을 반환
    - 연산에 사용되는 숫자 항목의 값이 null을 포함할 위험이 있는 경우 사용
    - 'c'의 데이터 타입과 val의 데이터 타입은 일치해야함.
예) create table temp(
    col1 number(6),
    col2 varchar2(20) not null,
    col3 date);
    
    insert into temp(col2) values('대전시');
    insert into temp values(10, '중구', sysdate);
    
temp의 col1에 5를 더한 값을 출력하시오.
select col1+5 from temp WHERE col1 is not null;
select * from temp;

예) 사원테이블에서 영업실정에 따른 보너스를 출력하시오
    사원번호, 사원명, 영업실적, 보너스 (nvl 미사용)
    select employee_id 사원번호, 
            emp_name 사원명, 
            commission_pct 영업실적, 
            commission_pct*salary 보너스
        from employees;
        
    select employee_id 사원번호, 
            emp_name 사원명, 
            nvl(commission_pct,0) 영업실적, 
            nvl(commission_pct*salary,0) 보너스
        from employees;
        
**회원테이블에서 회원번호 'r001', 'd001', 'k001'회원의 마일리지를 null로 바꾸시오.
    select * from member;
    select mem_id 회원번호, mem_mileage 마일리지
        from member
        where mem_id in ('r001', 'd001', 'k001');
    
    update member
        set mem_mileage = null
        where lower(mem_id) in('r001', 'd001', 'k001');
예제) 모든 회원들에게 500마일리지를 추가로 지급하려한다.
    회원번호, 회원명, 기존마일리지, 변경마일리지를 출력
    select mem_id 화원번호,
            mem_name 회원명, 
            mem_mileage 기존마일리지, 
            nvl(mem_mileage,0) + 500 변경마일리지
        from member;
        
예)매입테이블에서 2005년 3월 모든 상품별 매입현황을 조회하시오
    상품코드, 상품명, 매입수량, 매입금액
    select * from prod;
    select * from buyprod;
    select a.buy_prod 상품코드, 
            b.prod_name 상품명, 
            sum(buy_qty) 매입수량, 
            sum(buy_cost*buy_qty) 매입금액
         from buyprod a, prod b
         where b.prod_id = a.buy_prod and a.buy_date between '20050301' and '20050331'
         group by a.buy_prod, b.prod_name;
    -- outer jon
    select b.prod_id 상품코드, 
            b.prod_name 상품명, 
            nvl(sum(a.buy_qty),0) 매입수량, 
            nvl(sum(a.buy_cost*a.buy_qty),0) 매입금액
         from buyprod a
                right outer join prod b on(a.buy_prod = b.prod_id
                and a.buy_date between '20050301'and '20050331')
         group by b.prod_id, b.prod_name
         order by 1;
         
3.nvl2(c, val1, val2)
    -'c'의 값이  null이 아니면 val1을 ///// null이면 val2를 반환함
    'val1'과 'val2'는 같은 데이터 타입이어야 함.
    
    
예) 회원테이블에서 마일리지가 null인 회원을 조회하여 비고란에 '탈퇴회원'을,,
    null이 아닌 회원은 '정상회원'을 출력하시오
    
select * from member;
select mem_id 회원번호, 
        mem_name 회원명, 
        mem_mileage 마일리지, 
        nvl2(mem_mileage,'정상회원','탈퇴회원') 비고
--        nvl(to_char(mem_mileage),'탈퇴회원') 비고
    from member;
    
예제) 모든 회원들에게 500마일리지를 추가로 지급하려한다.
회원번호, 회원명, 기존마일리지, 변경마일리지를 출력
select mem_id 화원번호,
    mem_name 회원명, 
    mem_mileage 기존마일리지, 
    nvl(mem_mileage,mem_mileage,0) + 500 변경마일리지
from member;

4.nullif(c1, c2)
    -'c1'과 'c2'가 같으면 null, 다른 값이면 c1을 반환
    
** 상품테이블에서 분류코드가 'P201'인 상품의 할인판매가격을 매입가격으로 변경하시오.
select * from prod where prod_lgu = 'P201';
commit;
update prod
    set prod_sale = prod_cost 
    where prod_lgu = 'P201';
    
예) 상품테이블에서 매입가격과 할인판매 가격이 같은 상품은 '마감처리물품',
    서로 다르면 '정상상품'을 비고란에 출력
select * from prod;
select prod_id 상품코드, 
        prod_cost 매입가격, 
        prod_sale 할인판매가격, 
        nvl2(nullif(prod_cost, prod_sale),'정상상품', '마감처리물품')비고
    from prod;
    
    
    
    
    