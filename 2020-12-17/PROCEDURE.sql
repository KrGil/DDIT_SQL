2020-12-17-01)���� ���ν���(Stored Procedure: Procedure)
 - Ư�� ����� �����Ͽ� �ϳ��� ����� �����ϱ� ���� ����� ����
 - �̸� �����ϵǾ� ������ ����
 - ����ڴ� ���� ������ ���ν����� ȣ��(��Ʈ�p�� Ʈ���� ����, ����ȿ�� ����, ����Ȯ��)
 - ��ȯ���� ����
 SET SERVEROUTPUT ON;
 (�������)
 CREATE  [OR REPLACE] PROCEDURE ���ν�����[(
    �Ű����� [IN|OUT|INOUT] Ÿ�Ը� [:=|DEFAULT ��],
    .. -- INOUT�� �ް��ϸ� ���X
    .. -- IN�� ����� �� �׳� �����ص� �ȴ�. �׷� �ڵ����� �Է����� �ν�
    �Ű����� [IN|OUT|INOUT] Ÿ�Ը�/*ũ�� �����ϸ� �ȵȴ�.*/ [:=|DEFAULT ��])]
 IS|AS
    �����;
 BEGIN
    �����
    [EXCEPTION
        ����ó����;
    ]
    END;
 (���๮ �������)
 EXEC|EXECUTE ���ν�����(�Ű�����,...) --�ܵ�����
 
 �͸����̳� �ٸ� �Լ� �����
 ���ν�����(�Ű�����,...);
 
 **���������̺��� �����Ͻÿ�
 ���̺�� : REMAIN
 �÷���        ������Ÿ��           NULLTABLE           PK/FK ����    DEFAULT VALUE
 ----------------------------------------------------------------------------------
 REMAIN_YEAR    CHAR(4)           N.N                PK
 REMAIN_PROD    VARCHAR2(10)      N.N                PK/FK
 REMAIN_J_00    NUMBER(5)                                               0
 REMAIN_I       NUMBER(5)                                               0
 REMAIN_O       NUMBER(5)                                               0
 REMAIN_J_99    NUMBER(5)                                               
 REMAIN_DATE    DATE           
 
 -- 00 ->�������
 -- I -> �԰��� �հ�
 -- O -> ������
 -- 99 ->�⸻���
 
 CREATE TABLE REMAIN(
    REMAIN_YEAR     CHAR(4),      
    REMAIN_PROD     VARCHAR2(10),
    REMAIN_J_00     NUMBER(5) DEFAULT 0,
    REMAIN_I        NUMBER(5) DEFAULT 0,
    REMAIN_O        NUMBER(5) DEFAULT 0,
    REMAIN_J_99     NUMBER(5) DEFAULT 0,
    REMAIN_DATE     DATE,
    
    --PK����
    CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,REMAIN_PROD),
    CONSTRAINT fk_remain_pord FOREIGN KEY(REMAIN_PROD)
        REFERENCES PROD(PROD_ID));
        
**PROD���̺��� ��ǰ��ȣ�� �������(PROD_PRODERSTOCK)�� REMAIN���̺��� REMAIN_PROD��
  REMAIN_J_00(�������)�� �����Ͻÿ�. �� REMAIN_YEAR�� '2005'�̰� ��¥��
  '2005/01/01'�̴�.
  
  INSERT INTO remain(remain_year, remain_prod, remain_j_00, remain_j_99, REMAIN_DATE)
    SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20050101')
        FROM prod;
    
 SELECT * FROM REMAIN;
 
 ��)2005�� 1�� ��� ��ǰ�� ���Լ����� ��ȸ�ϰ� ���������̺��� UPDATE�Ͻÿ�
    PROCEDURE ���
 (��� ��ǰ�� ���Լ���)
 SELECT PROD_ID, NVL(SUM(buy_qty),0)
    FROM prod
    LEFT OUTER JOIN buyprod ON(prod_id = buy_prod
        AND buy_date BETWEEN '20050101' AND '20050131')
    GROUP BY prod_id
    ORDER BY 1;
    select * from dept
 (���ν��� ����)
 CREATE OR REPLACE PROCEDURE proc_buyprod01(
    p_id IN prod.prod_id%TYPE,
    p_qty IN number) --�Ű�������
    IS
    BEGIN
        UPDATE remain
        SET remain_i = remain_i + p_qty,
            remain_j_99 = remain_j_99 + p_qty,
            remain_date = TO_DATE('20050131')
        WHERE remain_prod = p_id --�⺻Ű�� ����Ű�� �Ǿ� ������(�ΰ��� �⺻Ű)
                                -- ���� ��ȸ�� ���Ѽ� index�� ����� �Ѵ�!
            AND remain_year = '2005';
    END;
        
 (����)
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
 
 ��)�Ѹ��� ȸ�� id�� �Է¹޾� ȸ���� �̸��� �ּ�, ���ϸ����� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
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
    
    DBMS_OUTPUT.PUT_LINE('ȸ���� : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('�ּ� : ' || v_addr);
    DBMS_OUTPUT.PUT_LINE('���ϸ��� : ' || v_mile);
 END;
 
 (����)
 select * from member;
 EXECUTE proc_mem01('d001');
 
 
 -- ���ν��� �ȿ��� �������� �ʱ�. ���� �� ��޽����� ���?
 CREATE OR REPLACE PROCEDURE proc_mem01(
    p_id IN member.mem_id%TYPE,
    p_name OUT member.mem_name%TYPE,
    p_addr OUT VARCHAR2,
    p_mile OUT member.mem_mileage%TYPE)
 IS 
 BEGIN --�ڵ����� 3���� ��p_name, p_addr, p_mile�� Ƣ��´�.
    SELECT mem_name, mem_add1 || ' ' || mem_add2, NVL(mem_mileage,0) INTO p_name, p_addr, p_mile
    FROM member
    WHERE mem_id = p_id;
 END;
 
 select * from member;
 
(����)-- �͸��Ͽ��� �����Ų��.
DECLARE
    v_name member.mem_name%TYPE;
    v_addr VARCHAR2(100);
    v_mile member.mem_mileage%TYPE;
BEGIN -- procedure �ȿ��� execute�� �����ϴ°� �ƴϴ�.
    proc_mem01('r001', v_name, v_addr, v_mile);
    DBMS_OUTPUT.PUT_LINE('ȸ���� : '||v_name);
    DBMS_OUTPUT.PUT_LINE('�ּ� : '||v_addr);
    DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||v_mile);
END;

(����2) �������� �泲�� ��� �̱�
DECLARE
    v_name member.mem_name%TYPE;
    v_addr VARCHAR2(100);
    v_mile member.mem_mileage%TYPE;
    
    CURSOR cur_name02
    IS
        SELECT mem_id 
        FROM member
        WHERE mem_add1 like '�泲%';
BEGIN 
    FOR rmem IN cur_name02 LOOP
        proc_mem01(rmem.mem_id, v_name, v_addr, v_mile);    
    
        DBMS_OUTPUT.PUT_LINE('ȸ���� : '||v_name);
        DBMS_OUTPUT.PUT_LINE('�ּ� : '||v_addr);
        DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||v_mile);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;        
END;

 SELECT mem_id 
        FROM member
        WHERE mem_add1 like '�泲%';
 -CUROR �������� �ڷḦ ó���ؾ��� ���
 RMEM.MEM_ID �ڸ��� �������� ���� ���� ó�� �� ���
 CURSOR�� �ݺ����� �Ἥ ���� ����־��ش�.
 
 ����] ��ǰ�ڵ�� ���� �Է� �޾� �ش��ǰ�� �԰������ �������� ��ȸ�Ͽ� ����ϴ�
    ���ν����� �ۼ��Ͻÿ� [PROCEDURE �̸� : proc_cb_info)
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
        
-- �ϳ��� ��
DECLARE
    v_prod buyprod.buy_prod%TYPE;
    v_bqty BUYPROD.BUY_QTY%TYPE;--�԰�
    v_cqty CART.CART_QTY%TYPE;--���
BEGIN
    proc_cb_info('P101000001', '20050101', v_prod, v_bqty, v_cqty);
    DBMS_OUTPUT.PUT_LINE('��ǰ�� : ' || v_prod);
    DBMS_OUTPUT.PUT_LINE('�ּ� : ' || v_bqty);
    DBMS_OUTPUT.PUT_LINE('���ϸ��� : ' || v_cqty);
end;

DECLARE
    v_prod buyprod.buy_prod%TYPE;
    v_bqty BUYPROD.BUY_QTY%TYPE;--�԰�
    v_cqty CART.CART_QTY%TYPE;--���
    
    CURSOR cur_date01
    IS
        SELECT 
        
��
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
(����)
DECLARE
    v_iamt NUMBER := 0;
    v_oamt NUMBER := 0;
    v_name prod.prod_name%TYPE;
BEGIN
    SELECT prod_name INTO v_name
    FROM prod
    WHERE prod_id = 'P101000006';
    proc_cb_info('P101000006','04', v_oamt, v_iamt);
    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || 'P101000006');
    DBMS_OUTPUT.PUT_LINE('��ǰ�� : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('������� : ' || v_oamt);
    DBMS_OUTPUT.PUT_LINE('���Լ��� : ' || v_iamt);
END;