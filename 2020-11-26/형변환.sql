2020-11-26-02) 형변환 함수
1. CAST(expr as 타입[(크기)])
    - 'expr'로 제공되는 자료를 '타입[(크기)]'    
    
select * from lprod;
예) 분류테이블의 lprod_id 컬럼의 데이터 타입을 number(7)에서
    char(10)으로 변경 출력하시오
    
    select cast(lprod_id as char(10)) 순번,
            lprod_gu 분류코드,
            lprod_nm 분류명
        from lprod;
        
    예) 사원테이블에서 부서코드 50에 속한 사원들의 근속년수를 조회하시오.
    사원번호, 사원명, 입사일, 근속년수이며, 근속년수는 'xx년' 형식의 문자열로 변환 출력하시오.
    select employee_id 사원번호, emp_name 사원명, hire_date 입사일, 
            cast((extract(year from sysdate)-extract(year from hire_date)) as char(2))||'년' 근속년수,
            (extract(year from sysdate)-extract(year from hire_date))||'년' 근속년수
        from employees
        where department_id =50;

2.to_char(c) : char, clob 타입을 자료 'c'를 varchar2 타입의 문자열로 변환
    to_char(d[,fmt]) : 날짜자료 d를 fmt 형식으로 문자열로 변환
    to_char(n[,fnt]) : 숫자자료 'n'을 fmt 형식의 문자열로 변환
        
    -날자형식 지정문자열
    ------------------------------------------------------------------
    형식 문자열                  의미              사용 예
    ------------------------------------------------------------------
    AD, BC, CC             세기를 출력          To_char(sysdate, 'CC')
        ex) select to_char(sysdate, 'cc'),
                    to_char(sysdate, 'ad'),
                    to_char(sysdate, 'bc')
                from dual;
    YYYY,YYY,YY,Y           년도를 출력          To_char(sysdate, 'YY')
        ex) select to_char(sysdate, 'YYYY'),
                    to_char(sysdate, 'YYY'),
                    to_char(sysdate, 'YY'),
                    to_char(sysdate, 'Y')
                from dual;
    Q                       분기               To_char(sysdate, 'YY Q')
        ex) select to_char(sysdate,'MM"월은" Q"분기"') from dual;
    Month, mon, MM RM       월                 To_char(sysdate, 'YYYY-MM')
        ex) select to_char(sysdate, 'YYYY-MM'),
                    to_char(sysdate, 'YYYY-RM'),
                    to_char(sysdate, 'YYYY-MON'),
                    to_char(sysdate, 'YYYY-MONTH')
                from dual;
    W,WW,IW                 주차
         ex) select to_char(sysdate,'W'),
                    to_char(sysdate,'WW'),
                    to_char(sysdate,'IW')
                from dual;
    
    D, DD, DDD, J           일
        D : 해당일이 속한 주에서 경과된 일수
        DD : 해당일이 속한 월에서 경과된 일수
        DDD : 해당일이 속한 년에서 경과된 일수
        J : 기원전 4712년 이후 경과된 일수
        ex) 
        select to_char(sysdate,'d'), to_char(sysdate,'dd'), to_char(sysdate,'ddd'), 
                    to_char(sysdate,'j') from dual; 
        
    DAY, DY                 주의 요일
        ex) 
        select to_char(sysdate, 'day'), to_char(sysdate, 'dy') from dual;
    HH, HH24, HH12          시간 (HH와 HH12는 같은 형식)
    AM, PM, A.M, P.M        오전, 오후 표현
    MI                      분
    SS, SSSSS               초('SSSSS' : 자정이후 경과된 시간을 초로 반환)
    기타                     사용자가 임의로 정한 문자열은 "   "안에 기술
    -----------------------------------------------------------------
    select to_char(mem_bir),
        to_char(mem_bir, 'YYYY-MM-DD day')
        from member;
    
    -숫자형식 지정문자열
    ------------------------------------------------------------------
    형식문자열                 의미
    ------------------------------------------------------------------
    9                   대응되는 위치의 값이 유효한 값이라면 데이터를 출력하고 무효의 0은 공백처리
    
    0                   대응되는 위치의 값이 유효한 값이라면 데이터를 출력하고 무효의 0은 출력
    
    $, L                화폐기호를 출력
    
    MI                  음수 출력인 경우 우측에 '-' 부호 출력
    
    pr                  음수 출력인 경우 '-' 부호 '< >'안에 출력
    
    ,(콤마), .(소숫점)
    
    ------------------------------------------------------------------
    
    000890000
    999,999,999.99 --9 모드
    000,000,000.00 --0 모드
    --------------
        890,000.00 --9 모드
    000,890,000.00 --0 모드
    
    
    예) 2005년 2월 제품별 매입현황을 조회하시오
        제품코드, 매입수량, 매입금액
    select buy_prod 제품코드, 
            to_char(sum(buy_qty),'999') 매입수량, 
            to_char(sum(buy_qty*buy_cost),'L99,999,999') 매입금액
        from buyprod
        where buy_date between '20050201' and last_day('20050201')
        group by buy_prod
        order by 3;
    