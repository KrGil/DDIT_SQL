2020-11-23-01)연산자
    4. 기타연산자
     1)in 연산자
        - 질의 탐색을 위해 2개 이상의 표현식(항목)을 지정
        - or 연산자로 변환 가능
        (사용형식)
        컬럼명 in(표현식1, 표현식2,...)
        .'컬럼명'에 저장된 값이( )안에 기술된 표현식 중 어느 하나와 일치하면 전체조건이 참
    예)사원테이블에서 부서코드가 20, 60, 80번 부서에 속한 사원을 검색하시오.
        Alias는 사원번호, 사원명, 부서콛, 급여
        
    (in 연산자를 사용하지 않는 경우)
    select employee_id as 사원번호,
            emp_name as 사원명,
            department_id as 부서코드,
            salary as 급여
        from employees
        where department_id=20 or department_id = 60 or department_id =80
        order by department_id asc
    
    (in 연산자를 사용하는 경우)
    select employee_id as 사원번호,
            emp_name as 사원명,
            department_id as 부서코드,
            salary as 급여
        from employees
        where department_id in(20,60,80)
        order by 3;
        
    2)some, any 연산자
    - 기본 기능은 in 연산자와 동일
    (사용형식)
    컬럼명 관계연산자 any|some (표현식1, 표현식2,...)
    .in 연산자는 동일성만 판단(=any, some)
    .any, some은 크기 비교도 가능
    select employee_id as 사원번호,
            emp_name as 사원명,
            department_id as 부서코드,
            salary as 급여
        from employees
        where department_id = some (20,60,80)
        order by 3;
    
    예)회원테이블에서 직업이 공무원인 회원이 가진 마일리지보다 더 많은 마일리지를 보유한 회원을 조회하시오.
    select mem_id as 사원번호,
            mem_name as 사원명,
            mem_mileage as 마일리지,
            mem_job as 직업
        from member
        where mem_job = '공무원' 
        order by mem_mileage desc;
        
    select mem_id as 사원번호,
            mem_name as 사원명,
            mem_mileage as 마일리지,
            mem_job as 직업
        from member
        where mem_mileage > any (select mem_mileage
                                from member 
                                where mem_job = '공무원');
    
    select mem_id as 사원번호,
            mem_name as 사원명,
            mem_mileage as 마일리지,
            mem_job as 직업
        from member
        where mem_mileage > any (select max(mem_mileage) -- 가장 큰 값! 3200 이상만을 나오게 하려면
                                from member 
                                where mem_job = '공무원');
    
    문제] 사원테이블에서 부서번호가 30,50,80 부서에 속하지 않은 사원을 조회하시오
        select employee_id as 사원번호,
                emp_name as 사원명,
                department_id as 부서번호,
                hire_date as 입사일
            from employees
            where department_id not in (30, 50, 80); 
            --where not department_id =any((some))(30,50,80);
            --
                
    문제] 회원테이블에서 다음자료의 주민번호를 수정하시오
        회원번호 : 'e001', 주민번호 : '750501-2406017' => '010501-4406017'
        회원번호 : 'n001', 주민번호 : '750323-1011014' => '000323-3011014'
        select * from member;
        select mem_id as 회원번호,
                mem_regno1 || '-' || mem_regno2 as 주민번호
            from member;
            commit;
        update member
            set mem_regno1 = '010501',
                mem_regno2 = '4406017'
            where mem_id = 'e001';
        select mem_id as 회원번호, mem_regno1 || '-' || mem_regno2
            from member
            where mem_id = 'e001'or
                mem_id = 'n001';
            
        update member
            set mem_regno1 = '000323',
                mem_regno2 = '3011014'
            where mem_id = 'n001';
            
    문제]회원테이블에서 여성회원이고 마일리지가 3000이상인 회원정보를 조회하시오.
        select * from member;
        select mem_id as 회원번호, mem_name as 회원명, mem_regno1 || '-' || mem_regno2 as 주민번호,
                 mem_job as 직업, mem_mileage as 마일리지
            from member
            where substr(mem_regno2, 1, 1) in (2,4) and mem_mileage >= 3000;
    
    문제]상품테이블(prod)에서 분류코드가 'P102'이고 판매가격(prod_price)이 10만원 이상인 상품을 조회하시오
    select prod_lgu
            from prod
            where prod_lgu = 'P101';
            
    select prod_id as 상품번호,
            prod_name as 상품명,
            prod_lgu as 분류코드,
            prod_price as 판매가격
        from prod
        where prod_lgu = 'P102' and prod_price >= 100000;
        
    문제] 장바구니테이블에서 2005년 7월 1일 ~ 7월 15일 판매정보를 조회하시오. 단, 구매수량이 많은것 부터 출력
    select * from cart;
    select * 
        from cart
        where substr(cart_no,1,8) between ('20050701') and ('20050715')
        order by cart_qty desc;
    
    예) 사원테이블에서 사원의  근속년수를 구하고 근속년수가 15년 이상인 회원들에게 보너스를 지급하려한다.
        보너스 : 급여의 15%, 지급액 : 급여 + 보너스
        select * from employees;
        select employee_id as 사원번호, 
                emp_name as 사원명, 
                hire_date as 입사일,
                --년도 뽑기. extract(month fromsysdate) 월 뽑기
                extract(year from sysdate) - extract(year from hire_date) as 근속년수,
                salary *0.15 as 보너스, 
                salary as 급여,
                (salary * 0.15) + salary as 지급액
            from employees
            where extract(year from sysdate) - extract(year from hire_date) >= 15;
        
    예) 회원테이블에서 회원들의 나이를 주민번호를 기준으로 계산하시오.
    select * from member;
--    select mem_id as 아이디, mem_name as 이름, mem_regno1 || '-' || mem_regno2 주민번호,
--            '120'-substr(mem_regno1,1,2) as 나이
    select '19'||substr(mem_regno1,1,2),
            extract(year from sysdate)-(1900+to_number(substr(mem_regno1,1,2)))
        from member;
    select mem_id 회원번호,
            mem_name as 회원명,
            mem_regno1||'-'||mem_regno2 as 주민번호,
            case when substr(mem_regno2,1,1)='1' or substr(mem_regno2,1,1)='2' then
                    extract(year from sysdate) -(1900+to_number(substr(mem_regno1,1,2)))
                else extract(year from sysdate) - (2000 + to_number(substr(mem_regno1,1,2)))
                end as 나이
            from member;
            
    예제) 매입테이블(buyprod)에서 2005년 1월 매입자료를 조회하시오
    select * from buyprod;
    select buy_date 매입일, buy_prod "매입상품 코드", buy_qty 매입수량, buy_cost 매입단가, buy_qty * buy_cost 매입가, extract(month from buy_date)
        from buyprod
        --where buy_date >= '20050101' and buy_date <= '20050131';
        where extract(year from buy_date) = 2005 and extract(month from buy_date) = 1;
        
        