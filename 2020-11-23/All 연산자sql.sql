2020-11-23-02)between
3) All 연산자
- 질의 탐색을 위해 2개 이상의 표현식(항목)을 지정
- 모든 표현식의 평가 결과가 참이어야 where 절이 참이되는 연산자
  (거의 사용되는 경우가 없음)
- and 연산자로 변환 가능
컬럼명 all (표현식1, 표현식2,...)

4)exists 연산자
 - 반드시 뒤에 서브쿼리가 나와야함
 (사용형식)
 where exists(서브쿼리)
 
 예) 사원테이블에서 전체 사원의 평균급여보다 많은 급여를 수령하는
    사원이 근무하는 부서코드를 조회하시오.
    select *from employees;
    --평균급여
    select round(avg(salary)) from employees; 
    select department_id, salary
        from employees
        where salary >= (select avg(salary) from employees);
--        where salary >= avg(salary); XXXXX
        where exists (select 1
                            from employees
                            where salary > (select round(avg(salary))
                                                from employees))
    order by 1;
    
    5) between 연산자
        - 범위를 지정하여 조건을 구성하는 경우 사용
        (사용형식)
        컬럼명 between 값1 and 값2
        . 컬럼명의 값이 '값1'에서 '값2'사이의 값이면 참(true)을 반환
        
예) 회원테이블에서 마일리지가 1000 ~ 3000 사이인 회원정보를 조회하시오
    alias는 회원번호, 회원명, 마일리지
(and 연산자 사용)
select mem_id 회원번호, 
        mem_name 회원명, 
        mem_mileage 마일리지
    from member
    --where mem_mileage >= 1000 and mem_mileage <= 3000;
    where mem_mileage between 1000 and 3000;
        
예제) 장바구니테이블에서 'a001'회원부터 'd001'회원까지 구매정보를 조회하시오
select * from cart;
select cart_member 회원번호, cart_no 상품코드, cart_qty 구매수량
        from cart
        where cart_member between 'a001' and 'd001'
--        where cart_member >= 'a001' and cart_member <='d001'
        order by 3 desc;
        
6) LIKE 연산자 --****문자열에 사용****
    - 패턴을 비교하는 경우 사용하는 연산자
    - 와일드카드(패턴문자열)로 '%'와 '_'가 사용
    -'%' : '%'가 사용된 위치에서 그 이후에 나오는 모든 문자열과 대응
        ex) '김%' : '김'으로 시작하는 모든 문자열과 대응
            '%김' : '김'으로 끝나는 모든 문자열과 대응
            '%김%' : 단어 내부에 '김'이 존재하는 모든 문자열과 대응
    -'_' : '_'가 사용된 위치에서 하나의 문자와 대응
        ex) '김_' : '김'으로 시작하고 2글자로 구성되며 두번째 글자는 어느글자든 상관없음
            '_김' : '김'으로 끝나는 2글자로 구성된 문자열과 대응
select *from member;
select mem_name 이름
    from member
    where mem_name like '%이%';

예) 회원테이블에서 회원의 거주지가 '충남'인 회원정보를 출력하시오
select * from member;
select mem_name 회원이름, mem_add1 || '-' || mem_add2 주소, mem_job 직업
    from member
    where mem_add1 like '충남%';
    
