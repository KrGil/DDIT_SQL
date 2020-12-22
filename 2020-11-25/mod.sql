2020-11-25-02)
4.mod(n,c), remainder(n,c)
    - n을 c로 나눈 나머지
    - 내부에서 서로 다른 함수를 사용하여 나머지를 구함
    mod : n -c * floor(n/c)
    remainder : n - c* round(n/c)
        ** floor(n) : n과 같거나 작은쪽에서 제일 큰 정수(n을 초과하지 않는 최대 정수)
        select mod(11,3), remainder(11,3) from dual;
    mod(10,3) : 10 - 3 * floor(10/3)
                10 - 3 * floor(3.33333)
                10 - 3*3 => 10-9 =>1
    remainder(10,3) : 10 - 3 * round(10/3)
                    10 - 3 * round(3.33333)
                    10 - 3 *3 => 10-9 =>1
                    
    mod(11,3) : 11 - 3 * floor(11/3)
                11 - 3 * floor(3.33333)
                11 - 3*3 => 11-9 =>2
    remainder(11,3) : 10 - 3 * round(10/6)
                     10 - 3 * round(3.666666)
                     10 - 3 *4 => 11-12 =>-1
                     
5. floor(n), ceil(n)
    -floor : n을 초과하지 않는 최대정수
    -ceil : n과 같거나 n보다 큰 제일 작은 정수 --올림
            .소수점이 허용되지 않는 컬럼에 정수 데이터가 입력 된 경우 소수점을 무조건 반올림하여
            정수자료만 저장하는 경우 주로 사용(급여, 세금 등의 계산 항목에 주로 사용)
예)
select floor(-10), floor(-10.234), ceil(-10), ceil(-10.001) from dual;
select floor(-10), floor(-10.234), ceil(10), ceil(10.001) from dual;

6. width_bucket(n, min, max,b)
    - min과 max 사이를 b개의 구간으로 나누었을 경우 주어진 수 n이 어느 구간에 속하는지를 반환
    select width_bucket(90, 1, 100, 10) from dual;
예) 회원테이블에서 회원들이 보유한 마일리지를 1~10000사이를 10개 구간으로 나누고 각 회원이 속한 구간 값을 조회하시오.
    select mem_id 회원번호, mem_name 회원명, mem_mileage 마일리지,
            width_bucket(mem_mileage, 1, 10000, 10) 구간값,
            width_bucket(mem_mileage, 10000, 1, 10) 등급
        from member;

예) 사원테이블에서 급여를 2000 ~ 30000을 3개의 구간으로 나누고 그 구간값이 1인경우
    '낮은급여', 2인 경우 '중간급여', 3인경우 '고 임금' 이라는 메세지를 비고란에 출력하시오
    select * from employees;
    select employee_id 사원번호, emp_name 사원명, department_id 부서코드, salary 급여, 
            width_bucket(salary, 2000, 30000, 3) 구간값,
            case when width_bucket(salary, 2000, 30000, 3) = 3 then '고임금'
                when width_bucket(salary, 2000, 30000, 3) = 2 then '중임금'
                else '저임금' end 비고
        from employees;
    
예) 사원테이블에서 급여를 2000 ~ 30000을 3개의 구간으로 나누고 그 구간값이 1인경우
    '낮은급여', 2인 경우 '중간급여', 3인경우 '고 임금' 이라는 메세지를 비고란에 출력하시오.
    select* from employees;
    select employee_id 사원번호, emp_name 사원명, department_id 부서코드, salary 급여, 
            width_bucket(salary, 2000, 30000, 3) 구간값,
            case when width_bucket(salary, 2000, 30000, 3)=1 then '낮은 급여'
                when width_bucket(salary, 2000, 30000, 3)=2 then '중간 급여'
            else '고 임금' end 비고
        from employees; 
            
            
            
            
            