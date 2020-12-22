2020-12-16-01)
2)�ݺ���
 ���ø����̼� ���߾���� �ݺ����� ���� ��� ����
 - LOOP, WHILE, FOR���� ������
 1)loop��
 . �ݺ��� �� ���� �⺻���� ���� ����
 (�������)
 LOOP
    �ݺ���ó����(��);
    EXIT [WHEN ����];
    ..
 END LOOP;
 - 'EXIT [WHEN ����];' : ������ LOOP���� �����, �����̸� ���� ��� ����
 
 ��) �������� 5���� ����ϴ� ������ LOOP������ ����Ͽ� �ۼ��Ͻÿ�
 SET SERVEROUTPUT ON;
 ACCEPT p_base PROMPT '���� ������ �Է� : ';
 DECLARE
    v_base NUMBER := &p_base; --���� �����ϴ� ����
    v_cnt NUMBER := 0; --�������� ��(1~9) ����
    v_res NUMBER := 0; --��� ����
 BEGIN
    LOOP
        v_cnt := v_cnt+1;
        EXIT WHEN v_cnt > 9;
        v_res := v_base*v_cnt;
        DBMS_OUTPUT.PUT_LINE(v_base ||  ' * ' || v_cnt ||' = '|| v_res);
    END LOOP;
 END;
 /
 
 ��) �μ���ȣ�� �Է¹޾� �ش�μ��� �Ҽӵ� �����ȣ�� ����̸��� ����ϴ� Ŀ���� �����Ͻÿ�.
 ACCEPT p_id PROMPT '�μ���ȣ : '
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
    DBMS_OUTPUT.PUT_LINE('ó���Ǽ� : ' ||cur_emp02%ROWCOUNT);--ROWCOUNT ���� ������ �����ش�.
   CLOSE cur_emp02; 
 END;
 
 2)WHILE��
 . ���߾���� WHILE�� ���� ��� ����
 (�������)
 WHILE ���� LOOP
    �ݺ�ó�� ��ɹ�(��);
        ..
 END LOOP;
 . '����'�� ���̸� �ݺ�����, '����'�� �����̸� LOOP�� ���
 
 ��) �������� 5���� WHILE�� �̿��Ͽ� �ۼ�
 DECLARE
    v_cnt NUMBER := 1;
 BEGIN
    WHILE v_cnt <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('5*' || v_cnt || ' = ' || 5*v_cnt);
        v_cnt := v_cnt+1;
    END LOOP;
 END;

 ��) 1~50 ���̿� �����ϴ� FIBONACCI NUMBER�� �μ��Ͻÿ�.
    FIBONACCI NUMBER : 1,1 �� �־����� �� ���� ���� �� �μ��� ��
    
 DECLARE
    vp_num number := 1; --����
    vpp_num number := 1; --������
    vcur_num number := 0; --����
    v_res varchar2(100); --���
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
 ��)ȸ�����̺��� �������� ������ ȸ���� ã�� �� ȸ���� 2005�� ���� ������ ��ȸ�Ͻÿ�.
 DECLARE
    vid MEMBER.mem_id%TYPE;
    v_name MEMBER.mem_name%TYPE;
    v_tot NUMBER := 0; --�������հ�
    CURSOR cur_cart01
    IS
        SELECT mem_id, mem_name
        FROM member
        WHERE mem_add1 LIKE '�泲%';
 BEGIN
    OPEN cur_cart01;
    FETCH cur_cart01 INTO v_id, v_name;
    WHILE cur_cart01%FOUND LOOP
        -- v_id�� ����� ȸ���� ����� ���
        SELECT SUM(a.cart_qty * b.prod_price) INTO v_tot
        FROM cart a, prod b
        WHERE a.CART_PROD = b.prod_id
            AND a.cart_member=v_id
            AND a.cart_no LIKE '2005%';
        
        DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : ' || v_id);
        DBMS_OUTPUT.PUT_LINE('ȸ���� : ' || v_name);
        DBMS_OUTPUT.PUT_LINE('���űݾ� �հ� : ' || v_tot);
        DBMS_OUTPUT.PUT_LINE('------------------------------');
        
        FETCH cur_cart01 INTO v_id, v_name; 
        --WHILE������ FETCH�� �ݵ�� �ΰ�!���Ϲ� �ۿ� ������� �б�����
    END LOOP;
 END;
    
 3) FOR��
 .�����(INDEX)�� �̿��� �ݺ� ����
 .�����(INDEX)�� �ý��ۿ��� �ڵ�����(���� ���ʿ�)
 (�������)
 FOR index IN [REVERSE] �ʱⰪ..������ LOOP
    �ݺ�ó�� ��ɹ�(��);
 END LOOP;
 
 
 ��)������ ������ ���ϴ� ���α׷��� �ۼ�
    1)���� 1�� 1�� 1�Ϻ��� ����(2019��)12�� 31�ϱ��� ����� �ϼ�
    2)���� 1�� 1�Ϻ��� �����������ϱ��� �ϼ�
    3)�ݿ� 1�Ϻ��� ���ñ��� �ϼ�
    -----------------------------------------------------
    1)2)3)�� �հ踦 7�� ���� ������ ���
    --1)���⵵���� ��¥ ���ϱ�
 DECLARE
    v_tot NUMBER := 0;
    v_year NUMBER := EXTRACT(YEAR FROM SYSDATE);
    v_month NUMBER := EXTRACT(MONTH FROM SYSDATE);
    v_date NUMBER := EXTRACT(DAY FROM SYSDATE);
    v_mi varchar2(50); ---���� ����κ�
 BEGIN
    FOR Y IN 1..v_year -1 LOOP --1���� 2019���� ���ƶ�
        IF MOD(Y,4) = 0 AND MOD(Y,100) <> 0 OR (MOD(Y,400) = 0) THEN
            v_tot := v_tot+366; --����
        ELSE
            v_tot := 365; --���
        END IF;
    END LOOP;
    -- 2)���� 1�� 1�Ϻ��� ���� �������ϱ��� �ϼ�
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
    
    -- 3)�ݿ� 1�Ϻ��� ���ñ��� �ϼ�
    v_tot := v_tot+v_date; --
    CASE MOD(v_tot,7)
        WHEN 1 THEN v_mi := SYSDATE ||'�� ������';
        WHEN 2 THEN v_mi := SYSDATE ||'�� ȭ����';
        WHEN 3 THEN v_mi := SYSDATE ||'�� ������';
        WHEN 4 THEN v_mi := SYSDATE ||'�� �����';
        WHEN 5 THEN v_mi := SYSDATE ||'�� �ݿ���';
        WHEN 6 THEN v_mi := SYSDATE ||'�� �����';
        WHEN 7 THEN v_mi := SYSDATE ||'�� �Ͽ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_mi);
 END;
 
 **Ŀ���� ���Ǵ� FOR��
 1) �������
 FOR ���ڵ�� IN Ŀ����[(�Ű�����),...] LOOP
    �ݺ�ó����;
 END LOOP;
 . '���ڵ��'�� �ý����� �ڵ����� �Ҵ���
 . Ŀ������ �÷� ������ '���ڵ��.�÷���' �������� ����
 . OPEN, FETCH, CLOSE ���� ���ʿ���
 
 ��) �μ���ȣ�� �Է� �޾� �����ȣ, �����, �μ����� ����ϴ� �͸��� �ۼ�

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
        
 **Ŀ���� ���Ǵ� INLINE FOR��
 1) �������
 FOR ���ڵ�� IN Ŀ�����ǹ� LOOP
    �ݺ�ó����;
 END LOOP;
 . '���ڵ��'�� �ý����� �ڵ����� �Ҵ���
 . Ŀ������ �÷� ������ '���ڵ��.�÷���' �������� ����
 . OPEN, FETCH, CLOSE ���� ���ʿ���
 
 ��) �μ���ȣ�� �Է� �޾� �����ȣ, �����, �μ����� ����ϴ� �͸��� �ۼ�
 
 ACCEPT p_did PROMPT '�μ���ȣ�� �Է��Ͻÿ� : '
 DECLARE
 BEGIN
    FOR rec IN (SELECT a.employee_id eid, a.emp_name ename, b.department_name dname
                FROM employees a, departments b
                WHERE a.department_id = b.department_id
                    AND a.department_id = '&p_did') LOOP
        DBMS_OUTPUT.PUT_LINE(rec.eid || ', ' || rec.ename || ', ' || rec.dname);
    END LOOP;
 END;
 