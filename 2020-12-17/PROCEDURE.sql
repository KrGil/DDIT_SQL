2020-12-17-01)저장 프로시져(Stored Procedure: Procedure)
 - 특정 기능을 수행하여 하나의 결과를 도출하기 위한 명령의 모임
 - 미리 컴파일되어 서버에 저장
 - 사용자는 실행 가능한 프로시져명만 호출(네트웤의 트래픽 감소, 실행효율 증대, 보안확보)
 - 반환값이 없음
 SET SERVEROUTPUT ON;
 (사용형식)
 CREATE  [OR REPLACE] PROCEDURE 프로시저명[(
    매개변수 [IN|OUT|INOUT] 타입명 [:=|DEFAULT 값],
    .. -- INOUT은 앵간하면 사용X
    .. -- IN을 사용할 때 그냥 생략해도 된다. 그럼 자동으로 입력으로 인식
    매개변수 [IN|OUT|INOUT] 타입명/*크기 지정하면 안된다.*/ [:=|DEFAULT 값])]
 IS|AS
    선언부;
 BEGIN
    실행부
    [EXCEPTION
        예외처리부;
    ]
    END;
 (실행문 사용형식)
 EXEC|EXECUTE 프로시져명(매개변수,...) --단독실행
 
 익명블록이나 다른 함수 등에서는
 프로시져명(매개변수,...);
 
 **재고수불테이블을 생성하시오
 테이블명 : REMAIN
 컬럼명        데이터타입           NULLTABLE           PK/FK 여부    DEFAULT VALUE
 ----------------------------------------------------------------------------------
 REMAIN_YEAR    CHAR(4)           N.N                PK
 REMAIN_PROD    VARCHAR2(10)      N.N                PK/FK
 REMAIN_J_00    NUMBER(5)                                               0
 REMAIN_I       NUMBER(5)                                               0
 REMAIN_O       NUMBER(5)                                               0
 REMAIN_J_99    NUMBER(5)                                               
 REMAIN_DATE    DATE           
 
 -- 00 ->기초재고
 -- I -> 입고슈량 합계
 -- O -> 출고수량
 -- 99 ->기말재고
 
 CREATE TABLE REMAIN(
    REMAIN_YEAR     CHAR(4),      
    REMAIN_PROD     VARCHAR2(10),
    REMAIN_J_00     NUMBER(5) DEFAULT 0,
    REMAIN_I        NUMBER(5) DEFAULT 0,
    REMAIN_O        NUMBER(5) DEFAULT 0,
    REMAIN_J_99     NUMBER(5) DEFAULT 0,
    REMAIN_DATE     DATE,
    
    --PK설정
    CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,REMAIN_PROD),
    CONSTRAINT fk_remain_pord FOREIGN KEY(REMAIN_PROD)
        REFERENCES PROD(PROD_ID));
        
**PROD테이블의 상품번호와 적정재고(PROD_PRODERSTOCK)를 REMAIN테이블의 REMAIN_PROD와
  REMAIN_J_00(기초재고)에 삽입하시오. 또 REMAIN_YEAR는 '2005'이고 날짜는
  '2005/01/01'이다.
  
  INSERT INTO remain(remain_year, remain_prod, remain_j_00, remain_j_99, REMAIN_DATE)
    SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20050101')
        FROM prod;
    
 SELECT * FROM REMAIN;
 
 예)2005년 1월 모든 상품별 매입수량을 조회하고 재고수불테이블을 UPDATE하시오
    PROCEDURE 사용
 (모든 상품별 매입수량)
 SELECT PROD_ID, NVL(SUM(buy_qty),0)
    FROM prod
    LEFT OUTER JOIN buyprod ON(prod_id = buy_prod
        AND buy_date BETWEEN '20050101' AND '20050131')
    GROUP BY prod_id
    ORDER BY 1;
    select * from dept
 (프로시져 생성)
 CREATE OR REPLACE PROCEDURE proc_buyprod01(
    p_id IN prod.prod_id%TYPE,
    p_qty IN number) --매개변수들
    IS
    BEGIN
        UPDATE remain
        SET remain_i = remain_i + p_qty,
            remain_j_99 = remain_j_99 + p_qty,
            remain_date = TO_DATE('20050131')
        WHERE remain_prod = p_id --기본키가 복합키로 되어 있을때(두개의 기본키)
                                -- 서로 조회를 시켜서 index를 맞춰야 한다!
            AND remain_year = '2005';
    END;
        
 (실행)
 DECLARE 
    CURSOR cur_buyprod01
    IS
        SELECT PROD_ID, NVL(SUM(buy_qty),0) AS amt
        FROM prod
        LEFT OUTER JOIN buyprod ON(prod_id = buy_prod
            AND buy_date BETWEEN '20050101' AND '20050131')
        GROUP BY prod_id
        ORDER BY 1;
 BEGIN
    FOR rec_buyprod IN cur_buyprod01 LOOP
        prod_buyprod01(rec_buyprod.prod_id, rec_buyprod.amt);
    END LOOP;
 END;
 
 SELECT * FROM remain;
 
 예)한명의 회원 id를 입력받아 회원의 이름과 주소, 마일리지를 출력하는 프로시져를 작성하시오.
 CREATE OR REPLACE PROCEDURE proc_mem01(
    p_id member.mem_id%TYPE)
 IS 
    v_name member.mem_name%TYPE;
    v_addr VARCHAR2(100);
    v_mile member.mem_mileage%TYPE;
 BEGIN
    SELECT mem_name, mem_add1 || ' ' || mem_add2, NVL(mem_mileage,0) INTO v_name, v_addr, v_mile
    FROM member
    WHERE mem_id = p_id;
    
    DBMS_OUTPUT.PUT_LINE('회원명 : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || v_addr);
    DBMS_OUTPUT.PUT_LINE('마일리지 : ' || v_mile);
 END;
 
 (실행)
 select * from member;
 EXECUTE proc_mem01('d001');
 
 
 -- 프로시져 안에서 실행하지 않기. 조금 더 고급스러운 방법?
 CREATE OR REPLACE PROCEDURE proc_mem01(
    p_id IN member.mem_id%TYPE,
    p_name OUT member.mem_name%TYPE,
    p_addr OUT VARCHAR2,
    p_mile OUT member.mem_mileage%TYPE)
 IS 
 BEGIN --자동으로 3개의 값p_name, p_addr, p_mile이 튀어나온다.
    SELECT mem_name, mem_add1 || ' ' || mem_add2, NVL(mem_mileage,0) INTO p_name, p_addr, p_mile
    FROM member
    WHERE mem_id = p_id;
 END;
 
 select * from member;
 
(실행)-- 익명블록에서 실행시킨다.
DECLARE
    v_name member.mem_name%TYPE;
    v_addr VARCHAR2(100);
    v_mile member.mem_mileage%TYPE;
BEGIN -- procedure 안에서 execute는 실행하는게 아니다.
    proc_mem01('r001', v_name, v_addr, v_mile);
    DBMS_OUTPUT.PUT_LINE('회원명 : '||v_name);
    DBMS_OUTPUT.PUT_LINE('주소 : '||v_addr);
    DBMS_OUTPUT.PUT_LINE('마일리지 : '||v_mile);
END;

(실행2) 거주지가 충남인 사람 뽑기
DECLARE
    v_name member.mem_name%TYPE;
    v_addr VARCHAR2(100);
    v_mile member.mem_mileage%TYPE;
    
    CURSOR cur_name02
    IS
        SELECT mem_id 
        FROM member
        WHERE mem_add1 like '충남%';
BEGIN 
    FOR rmem IN cur_name02 LOOP
        proc_mem01(rmem.mem_id, v_name, v_addr, v_mile);    
    
        DBMS_OUTPUT.PUT_LINE('회원명 : '||v_name);
        DBMS_OUTPUT.PUT_LINE('주소 : '||v_addr);
        DBMS_OUTPUT.PUT_LINE('마일리지 : '||v_mile);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;        
END;

 SELECT mem_id 
        FROM member
        WHERE mem_add1 like '충남%';
 -CUROR 복수개의 자료를 처리해야할 경우
 RMEM.MEM_ID 자리에 여러개의 값이 들어와 처리 할 경우
 CURSOR와 반복문을 써서 값을 집어넣어준다.
 
 문제] 상품코드와 월을 입력 받아 해당상품의 입고수량과 출고수량을 조회하여 출력하는
    프로시져를 작성하시오 [PROCEDURE 이름 : proc_cb_info)
    select * from cart
    order by cart_prod;
    select * from buyprod;
    
CREATE OR REPLACE PROCEDURE proc_cb_info(
    p_prod IN BUYPROD.BUY_PROD%TYPE,
    p_prod1 OUT buyprod.buy_prod%TYPE,
    p_bqty OUT BUYPROD.BUY_QTY%TYPE,
    p_cqty OUT CART.CART_QTY%TYPE)
    IS
BEGIN
    SELECT a.buy_prod, SUM(a.BUY_QTY), SUM(b.CART_QTY)
        INTO p_prod1, p_bqty, p_cqty
    FROM buyprod a, cart b
    WHERE a.buy_prod = b.cart_prod;
END;

EXEC proc_cb_info('P101000002');
 SELECT a.buy_prod, SUM(a.BUY_QTY), SUM(b.CART_QTY)
    FROM buyprod a, cart b
    WHERE a.buy_prod = b.cart_prod
        AND EXTRACT(MONTH FROM a.BUY_DATE) = '01'
    GROUP BY a.buy_prod
    ORDER BY a.buy_prod;
        
-- 하나의 열
DECLARE
    v_prod buyprod.buy_prod%TYPE;
    v_bqty BUYPROD.BUY_QTY%TYPE;--입고
    v_cqty CART.CART_QTY%TYPE;--출고
BEGIN
    proc_cb_info('P101000001', '20050101', v_prod, v_bqty, v_cqty);
    DBMS_OUTPUT.PUT_LINE('상품명 : ' || v_prod);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || v_bqty);
    DBMS_OUTPUT.PUT_LINE('마일리지 : ' || v_cqty);
end;

DECLARE
    v_prod buyprod.buy_prod%TYPE;
    v_bqty BUYPROD.BUY_QTY%TYPE;--입고
    v_cqty CART.CART_QTY%TYPE;--출고
    
    CURSOR cur_date01
    IS
        SELECT 
        
답
CREATE OR REPLACE PROCEDURE proc_cb_info(
    p_code IN prod.prod_id%TYPE,
    p_month IN CHAR,
    p_oamt OUT NUMBER,
    p_iamt OUT NUMBER)
IS
    v_date date := to_date('2005'||p_month||'01');
BEGIN
    SELECT SUM(buy_qty) INTO p_iamt
    FROM buyprod
    WHERE buy_date BETWEEN v_date AND last_day(v_date)
        AND buy_prod = p_code;
    
    SELECT SUM(cart_qty) INTO p_oamt
    FROM cart
    WHERE substr(cart_no,1,6) = SUBSTR(REPLACE(TO_CHAR(v_date),'/'),1,6)
        AND cart_prod=p_code;
END;
commit;
select nvl(max(board_id), 0) + 1 as board_id from TB_JDBC_BOARD;
select * from tb_jdbc_board;

insert into TB_JDBC_BOARD values (2, 'bb', 'bbb', 'bbbbb', '20201216');
select * from TB_JDBC_BOARD;
(실행)
DECLARE
    v_iamt NUMBER := 0;
    v_oamt NUMBER := 0;
    v_name prod.prod_name%TYPE;
BEGIN
    SELECT prod_name INTO v_name
    FROM prod
    WHERE prod_id = 'P101000006';
    proc_cb_info('P101000006','04', v_oamt, v_iamt);
    DBMS_OUTPUT.PUT_LINE('상품코드 : ' || 'P101000006');
    DBMS_OUTPUT.PUT_LINE('상품명 : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('매출수량 : ' || v_oamt);
    DBMS_OUTPUT.PUT_LINE('매입수량 : ' || v_iamt);
END;