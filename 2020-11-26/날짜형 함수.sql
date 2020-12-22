2020-11-26-01) 날짜형 함수

1. sysdate
 - 시스템이 제공하는 기본 날짜형
 - 년, 월, 일, 시, 분, 초 정보제공
 - '+'와 '-' 연산의 대상
 
 예);-- 일수 -- 계산하기
 select sysdate, sysdate +10, sysdate-200 from dual;
 
 2. add_months(d,n) -- 월수 -- 계산하기
    - 'd'로 주어진 날짜에서 'n' 월수를 더한 날짜 반환
예)  회원테이블에서 mem_memorial 컬럼이 가입일이라고 가정했을 때, 모든 회원의 유효기간이 3개월이며
    모두 재등록할 경우 재 등록 날짜 10일전에 문자데이터를 전송하고자 한다.
    각 회원의 문자전송 시작일을 구하시오.
    alias는 회원번호, 회원명, 가입일, 종료일, 문자전송일
    
    select * from member;
    select mem_id 회원번호, mem_name 회원명, mem_memorialday 가입일, 
            add_months(mem_memorialday,3) 종료일,
            add_months(mem_memorialday,3)-10 문자전송일
        from member;
    
    select add_months(sysdate,-4) from dual;  
3. next_day(d, char)
    - 주어진 날짜 'd' 이후 처음 만나는 char요일 날짜
    select next_day(sysdate, '금') from dual;
    select next_day(sysdate, '목요일') from dual;

4. last_day(d)
    - 주어진 날짜 'd'의 월에 해당하는 마지막일자 반환
    select last_day(sysdate), last_day('20000210') from dual;

5. months_between(d1, d2)
    - 두 날짜 자료 'd1'과 'd2' 사이의 개월수를 반환
    select round(months_between(sysdate, '00010101')) from dual;
    
6. extract(fmt from d)
    - 주어진 날짜데이터 'd'에서 fmt로 정의된 값을 추출하여 반환
    - fmt는 year, month, day, hour, minute, second를 의미함
    select extract(month from sysdate) 달 from dual;
예) 매입테이블에서 월별 매입정보를 조회하시오
    alias는 월, 매입수량, 매입금액
    select * from buyprod;
    select extract(month from buy_date) 월 , sum(buy_qty) 매입수량, sum(buy_qty*buy_cost) 매입금액,
            count(*) 건수
        from buyprod
        where extract(year from buy_date) = 2005
        group by extract(month from buy_date)
        order by 1;
예)대출잔액테이블(kor_loan_status)에서 2013년 대출현황을 조회하시오
    월, 지역, 구분, 대출잔액
    select * from kor_loan_status;
    select substr(period, 5) 월, region 지역, gubun 구분, loan_jan_amt 대출잔액
        from kor_loan_status
        where substr(period, 1,4) = 2013
        order by 1,3;
예) 사원테이블에서 11월에 입사한 사원벙보를 조회하시오
    사원번호, 사원명, 부서코드, 이메일
    select * from employees;
    select employee_id 사원번호, emp_name 사원명, department_id 부서코드, email 이메일, hire_date 입사일
        from employees
--        where extract(month from hire_date) = 11;
        where extract(month from hire_date) = extract(month from sysdate);        
        
        
        
        
        