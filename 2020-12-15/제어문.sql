2020-12-15-01)���
 - ���α׷��� ���� ������ ����
 - IF���� ����
 1)IF ��
 . ���ø����̼Ǿ���� IF���� ���� ���
 (�������)
 IF ���ǽ�1 THEN
    ���1
 [ELSE
    ���2;]
 END IF;
 
 (�������2)
 IF ���ǽ�1 THEN
    ���1;
    [ELSIF ���ǽ�2 THEN
        ���2;
 ELSE
    ���3;]
 END IF;

(�������3)
 IF ���ǽ�1 THEN
    ���1;
    IF ���ǽ�2 THEN
        ���;
    [ELSIF ���ǽ�2 THEN
        ���2;
     ELSE
        ���3;]
 ELSE
    ���4;
 END IF;
 
 SET SERVEROUTPUT ON;
 ��)Ű����� �⵵�� �Է� �޾� �������� ������� �Ǻ��ϴ� ���α׷� ����
 
ACCEPT P_YEAR PROMPT '�⵵ �Է� : '
DECLARE
    --������ ���� �����Ϸ��� ������ �ʱ�ȭ ������Ѵ�._NUMBER('&P_YEAR')
    V_YEAR NUMBER := 0; -- �Է¹��� �⵵
    V_MESSAGE VARCHAR2(30); --��� ����
    --P_YEARE ���� V_YEAR ���ڱ� ������ ����ȯ�� �ʿ��ϴ�.
    --&�� �ּҰ��� �ǹ���.
BEGIN
    V_YEAR := TO_NUMBER('&P_YEAR');
?    -- ����(4�� ����̸鼭(AND) 100�� ����� �ƴϰų�(OR), 400�� ����� �Ǵ� �⵵) �Ǻ�
    -- IF(  ) OR (  )  THEN
    IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)<>0) OR (MOD(V_YEAR,400)=0) THEN
        V_MESSAGE := V_YEAR ||'�� �����Դϴ�.';
    ELSE
        V_MESSAGE := V_YEAR ||'�� ����Դϴ�.';
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻� : ' || SQLERRM);
END;
/ --�������� ������ �����϶�.�� ��ɾ�
--�ּ�ó���� �����ϴ� �� ��.
ACCEPT P_YEAR PROMPT '�⵵ �Է� : '
DECLARE
    V_YEAR NUMBER := 0; -- �Է¹��� �⵵
    V_MESSAGE VARCHAR2(30); --��� ����
BEGIN
    V_YEAR := TO_NUMBER('&P_YEAR');
    IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)<>0) OR (MOD(V_YEAR,400)=0) THEN
        V_MESSAGE := V_YEAR ||'�� �����Դϴ�.';
    ELSE
        V_MESSAGE := V_YEAR ||'�� ����Դϴ�.';
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻� : ' || SQLERRM);
END;

��)������ ������(1~100) �Է��Ͽ� ¦������ Ȧ������ �Ǵ�
DECLARE
    V_NUM NUMBER := 0;
    V_RES VARCHAR2(50);
BEGIN
    V_NUM := ROUND(DBMS_RANDOM.VALUE(1,100));
    IF MOD(V_NUM,2) =0 THEN
        V_RES := V_NUM || '�� ¦��';
    ELSE
        V_RES := V_NUM || '�� Ȧ��';
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

��)LPROD���̺� ���� �����͸� �Է��Ͻÿ�
    �з��ڵ� : P501
    �з��� : '��갡����ǰ'
    
DECLARE
    V_CNT NUMBER := 0; --SELECT���� ���(VIEW)�� ���� ��
    
BEGIN
    SELECT COUNT(*) INTO V_CNT
    FROM LPROD
    WHERE LPROD_GU='p501';
    
    IF V_CNT = 0 THEN
        INSERT INTO LPROD -- �� �̷��� �ߴ��� �𸣰ڴ�.
            SELECT MAX(LPROD_ID)+1, 'p501', '��갡����ǰ'
            FROM LPROD;
    END IF;
    EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('����ó��' || SQLERRM);
END;

DECLARE
    V_CNT NUMBER := 0; --SELECT���� ���(VIEW)�� ���� ��
    
BEGIN
    SELECT COUNT(*) INTO V_CNT
    FROM LPROD_TEST
    WHERE LPROD_GU='P501';
    
    IF V_CNT = 0 THEN
        INSERT INTO LPROD_TEST(LPROD_GU, LPROD_NM) 
            VALUES ('P501', '��갡����ǰ');--LPROD_ID+1�� ���ֱ� ���ؼ� SUQUERY�� ���.
            --�����ϰ� INSERT INTO�� ��ȣ�� �ȹ��δ�.
    END IF;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('����ó��' || SQLERRM);
END;
    SELECT * FROM LPROD_TEST;
    
����] �� �������� 'P501' �з��ڵ忡 �з����� '�ӻ깰'�� �Է��Ͻÿ�
    ��, �ڷᰡ �����ϸ� �����Ͻÿ�
    
ACCEPT P_LPROD_NM PROMPT '�з����� �Է��Ͻÿ� : '
DECLARE
    V_LPROD_NM LPROD.LPROD_NM%TYPE := '&P_LPROD_NM';
    V_CNT NUMBER :=0;
BEGIN
    SELECT COUNT(*) INTO V_CNT
    FROM LPROD
    WHERE LPROD_GU = 'P501';
    
    IF V_CNT = 0 THEN
        INSERT INTO LPROD
            SELECT MAX(LPROD_ID)+1, 'P501', V_LPROD_NM
            FROM LPROD;
    ELSE
        UPDATE LPROD
            SET LPROD_NM = V_LPROD_NM
        WHERE LPROD_GU = 'P501';
    END IF;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('����ó��' || SQLERRM);
END;
SELECT * FROM LPROD;   
    
    