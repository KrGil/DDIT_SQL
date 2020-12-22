2020-12-15-02)커서(CURSOR)
커서(CURSOR)
커서는 select문 또는 데이터 조작어 같은 sql문을 실행했을 때 
해당 SQL문을 처리하는 정보를 저장한 메모리 공간을 뜻한다. 
커서를 사용하면 실행된 SQL문의 결과 값을 사용할 수 있게 되는데
예를 들어 SELECT 문의 결과 값이 여러 행으로 나왔을 때 
각 행별로 특정 작업을 수행하도록 기능을 구현하는 것이 가능하다.

 - 쿼리의 실행에 영향 받은 행들의 집합(VIEW)
 - 묵시적 커서와 명시적 커서로 구분

 SELECT * FROM LPROD;
 --VIEW는 쿼리다!
 
 DECLARE 에서 선언 가능한 세가지
 변수, 상수, 커서
 
 1) 묵시적 커서(IMPLICIT CURSOR)
 . SQL 명령이 실행 되면 자동으로 생성되는 커서
 . 익명커서
 . 실행결과의 출력이 종료됨과 동시에 CLOSE되어 사용자가 접근할 수 없음
 . 커서 속성
 ---------------------------------------------------------------
 속성명                설명
 ---------------------------------------------------------------
 SQL%FOUND            커서에 하나의 행이라도 존재하면 참(TRUE) 반환
 SQL%NOTFOUND         커서에 하나의 행이라도 존재하면 거짓(FALSE) 반환
 SQL%ISOPEN           커서가 OPEN되었으면 참
 SQL%ROWCOUNT         커서에 포함된 행의 수

 예) 회원테이블에서 거주지가 '대전'인 회원의 이름을 자신의 이름으로 변경하고
    몇건이 처리되었는지 확인하는 익명블록을 작성하시오.

DECLARE
BEGIN
    UPDATE MEMBER
    SET MEM_NAME = MEM_NAME
    WHERE mem_add1 LIKE '대전%';
    
    DEMS_OUTPUT.PUT_LINE('처리건수 : ' || SQL%ROWOCUNT);
END;

 SELECT COUNT(*)
 FROM MEMBER
 WHERE mem_add1 LIKE '대전%';
   -- 명시적 커서를 쓰면 서브쿼리의 갯수를 줄일 수 있다.
 2) 명시적 커서(EXPLICIT CURSOR)
 . 사용자가 선언부에서 선언한 커서
 . 커서의 사용 단계는 생성 -> OPEN -> FETCH -> CLOSE이다.
 . 커서 결과집합을 행단위로 접근하여 참조된 데이터를 이용한 조작처리가 목적(SELECT문에 의한
   커서 생성)
 (선언형식)
 CURSOR 커서명[(매개변수 [,매개변수,...])]
    IS SELECT 문;
 예) 부서번호를 입력받아 해당부서에 소속된 사원번호와 사원이름을 출력하는 커서를 정의하시오
 SELECT * FROM departments;
 DECLARE
    CURSOR cur_emp01(p_dept_id departments.department_id%TYPE) 
    IS 
      SELECT EMPLOYEE_ID, EMP_NAME
        FROM EMPLOYEES
        WHERE department_id = 60 --p_dept_id;
 
 OPEN
 . 커서를 사용하기 전에 반드시(FOR문 제외) OPEN 해야함
 . OPEN명령은 실행부(BEGIN ~ END)에서 작성
 (사용형식)
 OPEN 커서명 [(매개변수, [,매개변수,...])]
 
 예)2005년 1월 분류코드별 매입수량과 매입금액합계를 구하는 커서
 DECLARE
    CURSOR cur_buy01 
    IS
        SELECT lprod_gu, lprod_nm
        FROM lprod;
    v_gu LPROD.LPROD_GU%TYPE;  --분류코드 
    v_name LPROD.LPROD_NM%TYPE; --분류명
    v_sum NUMBER :=0;  --매입수량합계
    v_amt NUMBER :=0;  --매입금액합계
 BEGIN 
    OPEN cur_buy01;
    LOOP
        FETCH cur_buy01 INTO v_gu, v_name;
        EXIT WHEN cur_buy01%NOTFOUND;
        SELECT SUM(buy_qty * buy_cost), SUM(buy_qty) INTO v_sum, v_amt
            FROM buyprod, prod
            WHERE buy_prod = prod_id
            AND prod_lgu = v_gu
            AND buy_date between '20050101' AND '20050131';
        DBMS_OUTPUT.PUT_LINE(v_name || '->' ||v_amt||', ' ||v_sum);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('처리건수 : ' || cur_buy01 % ROWCOUNT);
    CLOSE cur_buy01;
END;