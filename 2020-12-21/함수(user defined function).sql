
[PL/SQL] 함수(user defined function : FUNCTION) 2020-12-21
- 프로시져와 비슷한 구조(단, 반환값이 존재해야 함)
- 일반 내장함수처럼 사용 가능
- (사용형식)

    ```sql
    :CREATE [OR REPLACE] FUNCTION 함수명(
        매개변수 [IN|OUT|INOUT] 타입명/*크기지정X*/ [:=DEFAULT 값],
                :
        매개변수 [IN|OUT|INOUT] 타입명/*크기지정X*/ [:=DEFAULT 값]
        RETURN 타입명/*BEGIN에 있는 RETURN 타입과 같은 타입이어야 한다. 
    									;도 붙지 않는다.*/

     IS|AS
        선언부
     BEGIN
        실행부
        RETURN 값;
     END;
        . 실행부에 반드시 하나이상의 RETURN 문이 존재해야함.
    ```

### 예) 상품테이블에서 상품코드를 입력 받아 해당 상품의 2005년 매입수량을 조회하는 함수를 작성하시오.
(함수처리영역 : 입력 받은 상품코드에 해당하는 상품의 2005년 매입수량을 조회)

- CODE

    ```sql
    CREATE OR REPLACE FUNCTION fn_buyqty(p_code IN prod.prod_id%TYPE)
        RETURN varchar2
    IS
        v_amt number(5):=0; --2005년도 상품별 매입수량집계
        v_sum number:=0; --2005년도 상품별 매입금액집계
        v_res varchar2(50);
    BEGIN
        SELECT SUM(buy_qty),
               SUM(buy_qty*buy_cost) INTO v_amt, v_sum
        FROM buyprod
        WHERE buy_prod = p_code
            AND buy_date BETWEEN '20050101' AND '20051231';
        v_res:='매입수량 : '||to_char(v_amt)||', '||'매입금액 : ' ||to_char(v_sum);
        RETURN v_res;
    END;

    (실행) --OUTER JOIN과 같은 결과를 가지고 온다.
    SELECT prod_id AS 상품코드,
           prod_name AS 상품코드,
           fn_buyqty(prod_id) AS 매입현황
    FROM prod
    --WHERE fn_buyqty(prod_id) >= 100;
    ```

### 예)거주지가 충남인 회원들의 2005년 상반기 매출액을 조회하시오.

(함수영역 : 입력된 회원들의 2005년 상반기 매출액을 조회)

- CODE

    ```sql
    select * from member;
    select * from cart;
    select * from prod;

    (함수) -- 상반기 매출액
    CREATE OR REPLACE FUNCTION fn_cart01(p_memid IN member.mem_id%TYPE)
        RETURN number
    IS
        v_sum number:= 0;
    BEGIN
        SELECT sum(cart_qty * prod_price) INTO v_sum
        FROM cart, prod
        WHERE cart_prod = prod_id -- JOIN 조건
            AND cart_member = p_memid --파라미터 값 비교
            AND SUBSTR(cart_no,1,6) BETWEEN '200501' AND '200506'; --일반 조건
    RETURN v_sum;
    END;

    (실행 : 거주지가 충남인 회원번호 검색)
    SELECT mem_name 회원명,
           NVL(fn_cart01(mem_id),0) 구입액합계  
    FROM member
    WHERE mem_add1 LIKE '충남%';
    ```

### 예)현재 계정에 존재하는 사용자 이름을 출력하는 함수를 작성하시오

- CODE (함수 뒤의 ()여부)

    ```sql
    CREATE OR REPLACE FUNCTION fn_get_user
        RETURN VARCHAR2
    IS
        v_name VARCHAR2(50);
    BEGIN
        SELECT user INTO v_name
        FROM dual;
    RETURN v_name;
    END;

    (실행)
    SELECT fn_get_user, fn_get_user()/*함수 뒤에 ()가 있어도 되고 없어도된다.*/ FROM dual;
    ```