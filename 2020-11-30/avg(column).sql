2020-11-30-01)
2. AVG(column)
    - 'column'을 기준으로 그룹으로 묶인 집단에 대한 평균값 반환
    예) 사원테이블에서 각 부서별 평균 급여를 소수 1자리까지 구하시오.
    select department_id as 부서코드,
--            emp_name as 사원이름,
            round(avg(salary),1)
        from employees
        group by department_id--, emp_name
        order by 1;
    
예) 상품테이블에서 상품분류별 평균매입가를 구하시오.
select * from prod;
select prod_lgu 분류코드,
        round(avg(prod_cost), -1) as 평균매입가
    from prod
    group by prod_lgu;
    
예제)2005년 월별 제품별 평균매입수량과 매입금액합계를 구하시오.
select * from buyprod;
select * from prod;
select extract(month from buy_date)월, 
        buy_prod 제품, 
        round(avg(buy_qty),0) 평균매입수량, 
        sum(buy_qty*buy_cost)매입금액합계
    from buyprod
    where extract(year from buy_date) = 2005
    group by extract(month from buy_date), buy_prod
    order by 1;
    
예제) 2005년 5월 일자별 평균판매 수량을 구하시오,
select * from cart;
select to_date(substr(cart_no,1,8)) 일자,
        round(avg(cart_qty),0) 평균판매수량
    from cart
    where cart_no like '200505%'
    group by substr(cart_no,1,8)
    order by 1;

예제) 사원테이블에서 각 부서별 평균급여보다 많은 급여를 받는 사원정보를 출력하시오.
select * from employees;
select department_id did,
        avg(salary) asal
       from employees
       group by  department_id;


select a.employee_id 사원번호,
        a.emp_name 사원명, 
        a.department_id 부서코드, 
        b.department_name 부서명,
        round(c.asal) 평균급여,
        a.salary 급여
       from employees a, departments b,
            (select department_id did,
                    avg(salary) asal
               from employees
               group by department_id) c
       where a.department_id = b.department_id
            and a. department_id = c.did
            and a.salary >=asal
       order by 3,5; 
        
3. count(*|column)
    - 그룹으로 묶인 각 그룹에 포함된 자류 수(행의 수)
    - 외부조인에 count함수를 사용할 경우 '*' 대신 컬럼명을 사용해야 함

예) 사원테이블에서 각 부서별 인원수를 구하시오
select department_id 부서코드, count(*) 인원수, count(emp_name) 사원수
    from employees
    group by department_id;
    
예)2005년 6월 제품별 판매건수를 조회하시오
select prod_id 상품코드, -- 많은쪽을 써준다.
        prod_name 상품명,
        count(cart_member) 판매건수, -- outer join에서 count(*이걸 쓰면 안된다)
        cart_no 날짜
    from cart
    right outer join prod on (cart_prod = prod_id
        and cart_no like '200506%')
    group by prod_id, prod_name, cart_no
    order by 1;

        
예제) 상품테이블에서 각 분류별 상품의 수를 조회하시오.
select * from prod;
select * from cart;

select cart_qty qty, substr(cart_prod,1,4) from cart;
select prod_lgu, 
        count(prod_name) 
    from prod
    group by prod_lgu
    order by 1;
    

예제) 회원테이블에서 각 연령대별 회원수를 조회하시오.
select * from member;    
    
select trunc(extract(year from sysdate) - extract(year from mem_bir),-1)||'대' as 연령대,
        count(*) 회원수
     from member
     group by trunc(extract(year from sysdate) - extract(year from mem_bir),-1)
     order by 1;

예제) 회원테이블에서 직업 종류별 회원수를 구하시오.
    select * from member;
    select mem_job 직업종류, 
            count(*) 회원수
        from member
        group by mem_job;
    -- distinct (중복제거)
예제) 회원테이블에서 직업의 종류를 출력하시오
    직업명
    select distinct(mem_job) 직업종류
        from member
        order by 1;
        
4. max(column), min(column)
    - 'column'으로 기술 컬럼에 저장된 값 중 최대값과 최소값을 구하여 반환
    - 내부적으로 계산방식하는 방식은 'column'을 기준으로 오름차순정렬(min), 또는
      내림차순 정열 후 그 중 첫번째 행의 값을 반환
      따라서 처리시간이 다소 많이 소요됨.
    
    **의사칼럼 rownum
        - 쿼리 결과(뷰)의 각행에 부여된 순번 값
        - 상위 5개 또는 하위 5개 등 필요한 갯수의 결과만을 출력할 때 사용(다른 dbms에서는 top 함수로 제공됨)
        
예) 회원의 마일리지 중 최대마일리지 값을 구하시오
select max(mem_mileage)
from member;

select mem_mileage
    from member
    where rownum <= 5
    order by 1 desc; -- order by 보다 where절이 먼저 실행되서 5개 중에서 내림차순한다.?
    
-------------------------------------순서가 중요하다!!--------------------------------------------
select a.mem_mileage
    from (select mem_mileage from member order by 1 desc) a -- 그래서 여기에 먼저 쓴다.
    where rownum <=1;
    
예) 사원테이블에서 부서별 최대 급여와 최소급여를 조회하시오
select department_id 부서, max(salary) 최대급여, min(salary) 최소급여
    from employees
    group by department_id
    order by 1;


