2020-12-15-02)Ŀ��(CURSOR)
Ŀ��(CURSOR)
Ŀ���� select�� �Ǵ� ������ ���۾� ���� sql���� �������� �� 
�ش� SQL���� ó���ϴ� ������ ������ �޸� ������ ���Ѵ�. 
Ŀ���� ����ϸ� ����� SQL���� ��� ���� ����� �� �ְ� �Ǵµ�
���� ��� SELECT ���� ��� ���� ���� ������ ������ �� 
�� �ະ�� Ư�� �۾��� �����ϵ��� ����� �����ϴ� ���� �����ϴ�.

 - ������ ���࿡ ���� ���� ����� ����(VIEW)
 - ������ Ŀ���� ����� Ŀ���� ����

 SELECT * FROM LPROD;
 --VIEW�� ������!
 
 DECLARE ���� ���� ������ ������
 ����, ���, Ŀ��
 
 1) ������ Ŀ��(IMPLICIT CURSOR)
 . SQL ����� ���� �Ǹ� �ڵ����� �����Ǵ� Ŀ��
 . �͸�Ŀ��
 . �������� ����� ����ʰ� ���ÿ� CLOSE�Ǿ� ����ڰ� ������ �� ����
 . Ŀ�� �Ӽ�
 ---------------------------------------------------------------
 �Ӽ���                ����
 ---------------------------------------------------------------
 SQL%FOUND            Ŀ���� �ϳ��� ���̶� �����ϸ� ��(TRUE) ��ȯ
 SQL%NOTFOUND         Ŀ���� �ϳ��� ���̶� �����ϸ� ����(FALSE) ��ȯ
 SQL%ISOPEN           Ŀ���� OPEN�Ǿ����� ��
 SQL%ROWCOUNT         Ŀ���� ���Ե� ���� ��

 ��) ȸ�����̺��� �������� '����'�� ȸ���� �̸��� �ڽ��� �̸����� �����ϰ�
    ����� ó���Ǿ����� Ȯ���ϴ� �͸����� �ۼ��Ͻÿ�.

DECLARE
BEGIN
    UPDATE MEMBER
    SET MEM_NAME = MEM_NAME
    WHERE mem_add1 LIKE '����%';
    
    DEMS_OUTPUT.PUT_LINE('ó���Ǽ� : ' || SQL%ROWOCUNT);
END;

 SELECT COUNT(*)
 FROM MEMBER
 WHERE mem_add1 LIKE '����%';
   -- ����� Ŀ���� ���� ���������� ������ ���� �� �ִ�.
 2) ����� Ŀ��(EXPLICIT CURSOR)
 . ����ڰ� ����ο��� ������ Ŀ��
 . Ŀ���� ��� �ܰ�� ���� -> OPEN -> FETCH -> CLOSE�̴�.
 . Ŀ�� ��������� ������� �����Ͽ� ������ �����͸� �̿��� ����ó���� ����(SELECT���� ����
   Ŀ�� ����)
 (��������)
 CURSOR Ŀ����[(�Ű����� [,�Ű�����,...])]
    IS SELECT ��;
 ��) �μ���ȣ�� �Է¹޾� �ش�μ��� �Ҽӵ� �����ȣ�� ����̸��� ����ϴ� Ŀ���� �����Ͻÿ�
 SELECT * FROM departments;
 DECLARE
    CURSOR cur_emp01(p_dept_id departments.department_id%TYPE) 
    IS 
      SELECT EMPLOYEE_ID, EMP_NAME
        FROM EMPLOYEES
        WHERE department_id = 60 --p_dept_id;
 
 OPEN
 . Ŀ���� ����ϱ� ���� �ݵ��(FOR�� ����) OPEN �ؾ���
 . OPEN����� �����(BEGIN ~ END)���� �ۼ�
 (�������)
 OPEN Ŀ���� [(�Ű�����, [,�Ű�����,...])]
 
 ��)2005�� 1�� �з��ڵ庰 ���Լ����� ���Աݾ��հ踦 ���ϴ� Ŀ��
 DECLARE
    CURSOR cur_buy01 
    IS
        SELECT lprod_gu, lprod_nm
        FROM lprod;
    v_gu LPROD.LPROD_GU%TYPE;  --�з��ڵ� 
    v_name LPROD.LPROD_NM%TYPE; --�з���
    v_sum NUMBER :=0;  --���Լ����հ�
    v_amt NUMBER :=0;  --���Աݾ��հ�
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
    DBMS_OUTPUT.PUT_LINE('ó���Ǽ� : ' || cur_buy01 % ROWCOUNT);
    CLOSE cur_buy01;
END;