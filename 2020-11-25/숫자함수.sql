2020-11-25 01) 숫자함수
1. 수학적 함수
    -abs(n) : n의 절대값 반환
    -sign(n) : n의 부호에 따라 0인경우 0, 양수라면 1, 음수라면 -1을 반환 --양소인지 음수인지 판별하는 함수
    -sqrt(n) : n의 평방근(root)
    -power(n1, n2) : n1의 n2승 값을 반환
    
예) 상품테이블에서 상품의 매입단가와 할인판매단가를 비교하여 이익 정도를 나타낼 수 있도록 조회하시오
    *이익여부는 이익이 발생되면 '정상' 이익이 없으면 '원가판매상품' 손해가 발생되면 '재고처분상품'이라고 출력하시오.
    
    update prod
        set prod_sale = prod_cost
        where prod_id like 'P101%';
    
    update prod
        set prod_sale = prod_cost
        where prod_id like 'P102%';
    
    select prod_id 상품코드, prod_name 상품명, prod_cost 매입단가, prod_sale 할인판매가,
            case when sign(prod_sale - prod_cost) = 1 then '정상제품'
                when sign(prod_sale - prod_cost) = 0 then '원가판매상품'
            else '재고처분상품' end 비고
        from prod;
    
    **표현식 (case when then ~ end)
    - 조건을 판단하여 처리할 명령을 다르게 선택할 때 사용(IF문과 비슷한 기능)
    - select 절에서 사용
    (사용형식)
    case when 조건1 then 명령1
        when 조건2 then 명령 2
            ....
    else 명령n end

예)회원테이블에서 주민번호를 이용하여 성별을 구분하시오. 단, 대전지역에 거주하는 회원번호만을 조회하시오
    select * from member;
    select mem_id 회원번호, mem_name 회원명, mem_add1||'-'||mem_add2 주소, 
            case when substr(mem_regno2,1,1) ='2' or substr(mem_regno2,1,1) ='4' then '여성회원' 
                when substr(mem_regno2,1,1) ='1' or substr(mem_regno2,1,1) ='3' then '남성회원'
                else '오류' end 성별
    from member
    where mem_add1 like '대전%';


2. greatest(n1,n2[,n3,...]), least(n1,n2[,n3,...])
    - greatest: 주어진 수 n1,n2[,n3,...] 중 제일 큰 수를 반환
    - least : 주어진 수 n1, n2[,n3,...] 중 제일 작은 수를 반환
    
예) select greatest(20,-15,70), least('오성님', '오성순', '정은실')
     from dual;
    
예) 회원테이블에서 마일리지가 1000미만인 회원들의 마일리지를 1000으로 부여하려고 한다. 이를 구현하시오(greatest) 사용
     select * from member;
     select mem_id 회원번호, mem_name 회원명, mem_mileage 마일리지, greatest(mem_mileage, 1000) 마일리지1
        from member
        where mem_mileage <=1000;
        
3. round(n[,L]), trunc(n,[,L])
    - round : 주어진 자료 n을 L+1번째 자리에서 반올림하여 L자리까지 표현
    - trunc : 주어진 자료 n을 L+1번째 자리에서 자리버림하여 L자리까지 표현
    - 1이 음수이면 정수부분 1자리에서 반올림(round), 자리버림(trunc)
    - 1이 생략하면 0으로 간주
    
예)사원테이블에서 각 부서별 평균임금을 조회하시오
    평균임금은 소수 2자리까지 출력하시오
    select * from employees; 
    
    alter table
    modify emp_name varchar2(80);
    
    update employees
        set emp_name=trim(emp_name);
        
    select a.department_id 부서코드, b.department_name 부서명,
            to_char((round(avg(a.salary),2)),'99,999.99') 평균임금
        from employees a, departments b
        where a.department_id = b.department_id
        group by a.department_id, b.department_name
        order by 1;
        
예) 사원테이블을 이용하여 사원들의 이번달 급여를 지급하려한다.
    지급액은 보너스+급여-세금이고 보너스는 영엽실적(commission_pct)*급여이다.
    또 세금은 보너스+급여의 3%이다. 소수 첫자리까지 나타내시오.;
    select * from employees;
    
    select employee_id 사원번호, emp_name 사원명, department_id 부서코드, 
           salary 급여, 
           nvl(commission_pct*salary,0) 보너스, 
           to_char(trunc(((salary +nvl(salary*commission_pct,0))*0.03),1),'99,999.9') 세금, 
           to_char(trunc((salary+nvl(salary*commission_pct,0)-((salary +nvl(salary*commission_pct,0))*0.03)),1),'99,999.9' )지급액
        from employees;


    
    