2020-12-16-01)
2)반복문
 애플리케이션 개발언어의 반복문과 같은 기능 제공
 - LOOP, WHILE, FOR문이 제공됨
 1)loop문
 . 반복문 중 가장 기본적인 구조 제공
 (사용형식)
 LOOP
    반복문처리문(들);
    EXIT [WHEN 조건];
    ..
 END LOOP;
 - 'EXIT [WHEN 조건];' : 조건이 LOOP문을 벗어나고, 거짓이면 다음 명령 수행
 
 예) 구구단의 5단을 출력하는 로직을 LOOP구문을 사용하여 작성하시오
 SET SERVEROUTPUT ON;
 ACCEPT p_base PROMPT '구할 구구단 입력 : ';
 DECLARE
    v_base NUMBER := &p_base; --단을 보관하는 변수
    v_cnt NUMBER := 0; --곱해지는 수(1~9) 보관
    v_res NUMBER := 0; --결과 보관
 BEGIN
    LOOP
        v_cnt := v_cnt+1;
        EXIT WHEN v_cnt > 9;
        v_res := v_base*v_cnt;
        DBMS_OUTPUT.PUT_LINE(v_base ||  ' * ' || v_cnt ||' = '|| v_res);
    END LOOP;
 END;
 /
 
 예) 부서번호를 입력받아 해당부서에 소속된 사원번호와 사원이름을 출력하는 커서를 정의하시오.
 ACCEPT p_id PROMPT '부서번호 : '
 DECLARE
    v_empid EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_name employees.emp_name%TYPE;
     CURSOR cur_emp02(p_dept employees.department_id%TYPE)
     IS
        SELECT EMPLOYEE_ID, EMP_NAME
        FROM EMPLOYEES
        WHERE department_id = p_dept;
 BEGIN
    OPEN cur_emp02('&p_id');
    LOOP
        FETCH cur_emp02 INTO v_empid, v_name;
        EXIT WHEN cur_emp02%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empid || ',  ' ||v_name);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('처리건수 : ' ||cur_emp02%ROWCOUNT);--ROWCOUNT 행의 갯수를 세어준다.
   CLOSE cur_emp02; 
 END;
 
 2)WHILE문
 . 개발언어의 WHILE과 같은 기능 제공
 (사용형식)
 WHILE 조건 LOOP
    반복처리 명령문(들);
        ..
 END LOOP;
 . '조건'이 참이면 반복수행, '조건'이 거짓이면 LOOP를 벗어남
 
 예) 구구단의 5단을 WHILE을 이용하여 작성
 DECLARE
    v_cnt NUMBER := 1;
 BEGIN
    WHILE v_cnt <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('5*' || v_cnt || ' = ' || 5*v_cnt);
        v_cnt := v_cnt+1;
    END LOOP;
 END;

 예) 1~50 사이에 존재하는 FIBONACCI NUMBER를 인쇄하시오.
    FIBONACCI NUMBER : 1,1 가 주어지고 그 이후 수는 전 두수의 합
    
 DECLARE
    vp_num number := 1; --전수
    vpp_num number := 1; --전전수
    vcur_num number := 0; --현재
    v_res varchar2(100); --결과
 BEGIN
     v_res := '1, 1, ';
    WHILE vcur_num <= 50 LOOP
        vcur_num := vp_num + vpp_num;
        v_res := v_res||vcur_num||', '; 
        vpp_num :=vp_num;
        vp_num := vcur_num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_res);
 END;
 /
  SELECT EMPLOYEE_ID, EMP_NAME
        FROM EMPLOYEES;
        WHERE department_id;
 예)회원테이블에서 거주지가 서울인 회원을 찾아 그 회원의 2005년 매출 정보를 조회하시오.
 DECLARE
    vid MEMBER.mem_id%TYPE;
    v_name MEMBER.mem_name%TYPE;
    v_tot NUMBER := 0; --구매총합계
    CURSOR cur_cart01
    IS
        SELECT mem_id, mem_name
        FROM member
        WHERE mem_add1 LIKE '충남%';
 BEGIN
    OPEN cur_cart01;
    FETCH cur_cart01 INTO v_id, v_name;
    WHILE cur_cart01%FOUND LOOP
        -- v_id에 저장된 회원의 매출액 계산
        SELECT SUM(a.cart_qty * b.prod_price) INTO v_tot
        FROM cart a, prod b
        WHERE a.CART_PROD = b.prod_id
            AND a.cart_member=v_id
            AND a.cart_no LIKE '2005%';
        
        DBMS_OUTPUT.PUT_LINE('회원번호 : ' || v_id);
        DBMS_OUTPUT.PUT_LINE('회원명 : ' || v_name);
        DBMS_OUTPUT.PUT_LINE('구매금액 합계 : ' || v_tot);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
        
        FETCH cur_cart01 INTO v_id, v_name; 
        --WHILE문에는 FETCH가 반드시 두개!와일문 밖에 다음사람 읽기위해
    END LOOP;
 END;
    
 3) FOR문
 .제어변수(INDEX)를 이용한 반복 수행
 .제어변수(INDEX)는 시스템에서 자동설정(선언 불필요)
 (사용형식)
 FOR index IN [REVERSE] 초기값..최종값 LOOP
    반복처리 명령문(들);
 END LOOP;
 
 
 예)오늘의 요일을 구하는 프로그램을 작성
    1)서기 1년 1월 1일부터 전년(2019년)12월 31일까지 경과된 일수
    2)올해 1월 1일부터 전월마지막일까지 일수
    3)금월 1일부터 오늘까지 일수
    -----------------------------------------------------
    1)2)3)의 합계를 7로 나눈 나머지 계산
    --1)전년도까지 날짜 구하기
 DECLARE
    v_tot NUMBER := 0;
    v_year NUMBER := EXTRACT(YEAR FROM SYSDATE);
    v_month NUMBER := EXTRACT(MONTH FROM SYSDATE);
    v_date NUMBER := EXTRACT(DAY FROM SYSDATE);
    v_mi varchar2(50); ---요일 저장부분
 BEGIN
    FOR Y IN 1..v_year -1 LOOP --1부터 2019까지 돌아라
        IF MOD(Y,4) = 0 AND MOD(Y,100) <> 0 OR (MOD(Y,400) = 0) THEN
            v_tot := v_tot+366; --윤년
        ELSE
            v_tot := 365; --평년
        END IF;
    END LOOP;
    -- 2)올해 1월 1일부터 전월 마지막일까지 일수
    FOR M IN 1..v_month -1 LOOP
        IF M=1 OR M=3 OR M = 5 OR M = 7 OR M = 8 OR M = 10 OR M = 12 THEN
            v_tot := v_tot+31;
        ELSIF M=4 OR M=6 OR M=9 OR M=11 THEN
            v_tot := v_tot+30;
        ELSE
            IF (MOD(v_year,4)=0 AND MOD(v_year,100) <>0) OR (MOD(V_YEAR, 400)=0) THEN
                v_tot := v_tot+29;
            ELSE
                v_tot := v_tot+28;
            END IF;
        END IF;
    END LOOP;
    
    -- 3)금월 1일부터 오늘까지 일수
    v_tot := v_tot+v_date; --
    CASE MOD(v_tot,7)
        WHEN 1 THEN v_mi := SYSDATE ||'는 월요일';
        WHEN 2 THEN v_mi := SYSDATE ||'는 화요일';
        WHEN 3 THEN v_mi := SYSDATE ||'는 수요일';
        WHEN 4 THEN v_mi := SYSDATE ||'는 목요일';
        WHEN 5 THEN v_mi := SYSDATE ||'는 금요일';
        WHEN 6 THEN v_mi := SYSDATE ||'는 토요일';
        WHEN 7 THEN v_mi := SYSDATE ||'는 일요일';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_mi);
 END;
 
 **커서와 사용되는 FOR문
 1) 사용형식
 FOR 레코드명 IN 커서명[(매개변수),...] LOOP
    반복처리문;
 END LOOP;
 . '레코드명'은 시스템이 자동으로 할당함
 . 커서내의 컬럼 접근은 '레코드명.컬럼명' 형식으로 접근
 . OPEN, FETCH, CLOSE 문이 불필요함
 
 예) 부서번호를 입력 받아 사원번호, 사원명, 부서명을 출력하는 익명블록 작성

 DECLARE
    CURSOR cur_emp03(p_did employees.department_id%TYPE)
    IS
        SELECT a.employee_id eid, a.emp_name ename, b.department_name dname
        FROM employees a, departments b
        WHERE a.department_id = b.department_id
            AND a.department_id = p_did;
 BEGIN
    FOR rec IN cur_emp03(60) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.eid || ', ' || rec.ename || ', ' || rec.dname);
    END LOOP;
 END;
        
 **커서와 사용되는 INLINE FOR문
 1) 사용형식
 FOR 레코드명 IN 커서정의문 LOOP
    반복처리문;
 END LOOP;
 . '레코드명'은 시스템이 자동으로 할당함
 . 커서내의 컬럼 접근은 '레코드명.컬럼명' 형식으로 접근
 . OPEN, FETCH, CLOSE 문이 불필요함
 
 예) 부서번호를 입력 받아 사원번호, 사원명, 부서명을 출력하는 익명블록 작성
 
 ACCEPT p_did PROMPT '부서번호를 입력하시오 : '
 DECLARE
 BEGIN
    FOR rec IN (SELECT a.employee_id eid, a.emp_name ename, b.department_name dname
                FROM employees a, departments b
                WHERE a.department_id = b.department_id
                    AND a.department_id = '&p_did') LOOP
        DBMS_OUTPUT.PUT_LINE(rec.eid || ', ' || rec.ename || ', ' || rec.dname);
    END LOOP;
 END;
 