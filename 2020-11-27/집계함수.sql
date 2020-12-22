2020-11-27-02)집계함수
    - 한 테이블의 데이터들을 특정컬럼을 기준으로 그룹화하고 각 그룹내의 데이터에 대하여
      집계처리(합계, 평균, 갯수, 최대값, 최소값)
    - sum, avg, count, min, max
    - select 절에 집계함수와 일반컬럼이 같이 사용되면 반드시 group by절이 기술되어야함.
    (사용형식)
    select 컬럼명1,...,
            sum(컬럼명)|count(*|컬럼명) |max(컬럼명)|min(컬럼명)
        from 테이블명
        [where 조건]
        [group by 컬럼명1,..]
        [having 조건]
        [order by 컬럼명|컬럼인덱스];
        . select 절에서 '[컬럼명1,...,]'이 생략되면 group by 절이 필요 없음
        (테이블 전체가 하나의 그룹)
        . '[group by 컬럼명1,..]'에 기술되는 컬럼명은 select 절에서 집계함수 이외의 
        컬럼명을 기술하고 필요에 따라 select절에서 기술하지 앟은 컬럼도 기술 가능
        . 'group by'다음에 기술되는 컬럼의 순서는 그룹핑 되는 순서임.
        .'[having 조건]' : 집계함수 자체에 조건이 부여된 경우 사용
        
1.sum(column)
    -'column'에 저장된 각 그룹별 합계를 구하여 반환
예)사원테이블에서 전체 사원들의 급여 합계를 구하시오
    select sum(salary)
        from employees;

예)사원테이블에서 부서별 사원들의 급여 합계를 구하시오
    select  department_id 부서명, sum(salary), count(*)
        from employees
        group by department_id
        order by 1;
예) 회원테이블에서 남녀 회원별 마일리지 합계를 조회하시오.
    select * from member;
    select case when substr(mem_regno2,1,1) = 1 or substr(mem_regno2,1,1) = 3 then '남성'
                else '여성' end 성별,
            sum(mem_mileage)
        from member
        group by case when substr(mem_regno2,1,1) = 1 or substr(mem_regno2,1,1) = 3 then '남성'
                else '여성' end
        order by 1;

예)2005년 2-3월 제품별 매입현황을 조회
    select * from buyprod;
    select buy_prod 제품별, sum(buy_qty) 수량합계, to_char(sum(buy_qty*buy_cost), '99,999,999') 금액합계
        from buyprod
        where buy_date between '20050201' and '20050331'
        group by buy_prod
        order by 1;
        
예)2005년 2-3월 제품별 매입현황을 조회하되 매입수량이 100개 이상인 제품만 조회하시오.
    select * from buyprod;
    select buy_prod 제품별, sum(buy_qty) 수량합계, to_char(sum(buy_qty*buy_cost), '99,999,999') 금액합계
        from buyprod
        where buy_date between '20050201' and '20050331'
        having sum(buy_qty) >= 100          -- having으로 sum(집계함수) 조건을 적어놓자!
        group by buy_prod
        order by 1;
        
        
** 상품테이블에서 재고량을 변경하시오
    재고량은 적정재고량의 130%이며 정수이다.
    select prod_totalstock 재고량, prod_properstock 적정재고량 from prod;
    update prod
        set prod_totalstock = to_number(prod_properstock + prod_properstock*0.3);

예)상품테이블에서 상품 분류별 재고 합계를 구하시오 250개 이상 남아있는 자료를 조회
    select * from prod;
    select prod_lgu as 상품분류,
            sum(prod_totalstock) as 재고합계
        from prod
        having sum(prod_totalstock) >=250
        group by prod_lgu
        order by 1;
    
예) 장바구니테이블에서 2005년 5월 회원별 매출집계
    회원번호, 매출수량합계
    select * from cart;
    select cart_member 회원번호, sum(cart_qty) 매출수량합계
        from cart
        where substr(cart_no,1, 6) = '200505'
        group by cart_member
        order by 1;
예) 장바구니테이블에서 2005년 5월 제품별 매출집계
    제품코드, 매출수량합계
    select cart_prod 제품코드, sum(cart_qty)
        from cart
        where cart_no like '200505%'
        group by cart_prod
        order by 1;
예) 장바구니테이블에서 2005년 5월 일자별 회원별 매출집계
    날짜, 회원번호, 매출수량합계
    select to_date(substr(cart_no, 1, 8)) 날짜, 
            cart_member 회원번호,
            sum(cart_qty) 매출수량합계
        from cart
        where substr(cart_no, 1, 6) = '200505' --cart_no like '200505%'
        group by to_date(substr(cart_no, 1, 8)), cart_member
        order by 1;
        