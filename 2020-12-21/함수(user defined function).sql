
[PL/SQL] �Լ�(user defined function : FUNCTION) 2020-12-21
- ���ν����� ����� ����(��, ��ȯ���� �����ؾ� ��)
- �Ϲ� �����Լ�ó�� ��� ����
- (�������)

    ```sql
    :CREATE [OR REPLACE] FUNCTION �Լ���(
        �Ű����� [IN|OUT|INOUT] Ÿ�Ը�/*ũ������X*/ [:=DEFAULT ��],
                :
        �Ű����� [IN|OUT|INOUT] Ÿ�Ը�/*ũ������X*/ [:=DEFAULT ��]
        RETURN Ÿ�Ը�/*BEGIN�� �ִ� RETURN Ÿ�԰� ���� Ÿ���̾�� �Ѵ�. 
    									;�� ���� �ʴ´�.*/

     IS|AS
        �����
     BEGIN
        �����
        RETURN ��;
     END;
        . ����ο� �ݵ�� �ϳ��̻��� RETURN ���� �����ؾ���.
    ```

### ��) ��ǰ���̺��� ��ǰ�ڵ带 �Է� �޾� �ش� ��ǰ�� 2005�� ���Լ����� ��ȸ�ϴ� �Լ��� �ۼ��Ͻÿ�.
(�Լ�ó������ : �Է� ���� ��ǰ�ڵ忡 �ش��ϴ� ��ǰ�� 2005�� ���Լ����� ��ȸ)

- CODE

    ```sql
    CREATE OR REPLACE FUNCTION fn_buyqty(p_code IN prod.prod_id%TYPE)
        RETURN varchar2
    IS
        v_amt number(5):=0; --2005�⵵ ��ǰ�� ���Լ�������
        v_sum number:=0; --2005�⵵ ��ǰ�� ���Աݾ�����
        v_res varchar2(50);
    BEGIN
        SELECT SUM(buy_qty),
               SUM(buy_qty*buy_cost) INTO v_amt, v_sum
        FROM buyprod
        WHERE buy_prod = p_code
            AND buy_date BETWEEN '20050101' AND '20051231';
        v_res:='���Լ��� : '||to_char(v_amt)||', '||'���Աݾ� : ' ||to_char(v_sum);
        RETURN v_res;
    END;

    (����) --OUTER JOIN�� ���� ����� ������ �´�.
    SELECT prod_id AS ��ǰ�ڵ�,
           prod_name AS ��ǰ�ڵ�,
           fn_buyqty(prod_id) AS ������Ȳ
    FROM prod
    --WHERE fn_buyqty(prod_id) >= 100;
    ```

### ��)�������� �泲�� ȸ������ 2005�� ��ݱ� ������� ��ȸ�Ͻÿ�.

(�Լ����� : �Էµ� ȸ������ 2005�� ��ݱ� ������� ��ȸ)

- CODE

    ```sql
    select * from member;
    select * from cart;
    select * from prod;

    (�Լ�) -- ��ݱ� �����
    CREATE OR REPLACE FUNCTION fn_cart01(p_memid IN member.mem_id%TYPE)
        RETURN number
    IS
        v_sum number:= 0;
    BEGIN
        SELECT sum(cart_qty * prod_price) INTO v_sum
        FROM cart, prod
        WHERE cart_prod = prod_id -- JOIN ����
            AND cart_member = p_memid --�Ķ���� �� ��
            AND SUBSTR(cart_no,1,6) BETWEEN '200501' AND '200506'; --�Ϲ� ����
    RETURN v_sum;
    END;

    (���� : �������� �泲�� ȸ����ȣ �˻�)
    SELECT mem_name ȸ����,
           NVL(fn_cart01(mem_id),0) ���Ծ��հ�  
    FROM member
    WHERE mem_add1 LIKE '�泲%';
    ```

### ��)���� ������ �����ϴ� ����� �̸��� ����ϴ� �Լ��� �ۼ��Ͻÿ�

- CODE (�Լ� ���� ()����)

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

    (����)
    SELECT fn_get_user, fn_get_user()/*�Լ� �ڿ� ()�� �־ �ǰ� ����ȴ�.*/ FROM dual;
    ```