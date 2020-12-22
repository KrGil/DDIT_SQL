2020-12-14 PL/SQL 
------�ǽ� 2
registdept_test procedure ����
param : deptno, dname, loc
logic : �Է¹��� �μ� ������ dept_test ���̺� �ű� �Է�
exec registdept_test (99, 'ddit', 'daejeon');
dept_test ���̺� ���������� �Է� �Ǿ����� Ȯ��(SQL-������)

SELECT deptno, dname, loc
FROM dept;
SET SERVEROUTPUT ON;

-- ���̺� �����ϱ�(������ ���� ����)
CTAS : CHECK ������ ������ ������ �������ǵ��� ������� �ʴ´�.
CREATE TABLE dept_test AS
SELECT *
FROM dept;
where 1=2; --���̺� ���¸� ������ ����(���� �������������)

rollback;

--�����͸� �߸� �־��� ��� 
INSERT INTO dept_test(deptno,dname, loc)
    VALUES (99, 'ddit', 'daejeon');
select * from dept_test;
select rowid, dept_test.* from dept_test;
--�����͸� �����ϱ�!!
delete dept_test
where rowid in ('AAAFCOAABAAALkCAAA','AAAFCOAABAAALkCAAB');


CREATE OR REPLACE PROCEDURE registdept_test(p_deptno dept_test.deptno%TYPE,
                                            p_dname dept_test.dname%TYPE,
                                            p_loc dept_test.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test(deptno,dname, loc)
    VALUES (p_deptno, p_dname, p_loc);
    COMMIT;
END;
/
EXEC registdept_test(98, 'DDIT', '����');

SELECT *
FROM dept_test;

---- �ǽ����� 3
UPDATEdept_test procedure ����
param : deptno, dname, loc
logic : �Է¹��� �μ� ������ dept_test ���̺� ���� ����
exec UPDATEdept_test (99, 'ddit', 'daejeon');
dept_test ���̺� ���������� �Է� �Ǿ����� Ȯ��(SQL-������)

UPDATE dept_test
SET dname = 'ddit', loc = 'daejeon'
WHERE deptno = 98;

CREATE OR REPLACE PROCEDURE UPDATEdept_test(p_deptno dept_test.deptno%TYPE,
                                            p_dname dept_test.dname%TYPE,
                                            p_loc dept_test.loc%TYPE)IS
BEGIN
    UPDATE dept_test
    SET dname = p_dname, loc = p_loc
    WHERE deptno = p_deptno;
END;
/

EXEC UPDATEdept_test(98, 'aa', 'aa');
CREATE OR REPLACE PROCEDURE PRINTdept_test(p_deptno dept_test.deptno%TYPE) IS
V_deptno dept_test.deptno%TYPE;
V_dname dept_test.dname%TYPE;
V_loc dept_test.loc%TYPE;
BEGIN
    SELECT deptno, dname, loc INTO V_deptno, V_dname, V_loc
    FROM dept_test
    WHERE deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE(V_deptno || ' / ' || V_dname || ' / ' || V_loc);
END;
/
EXEC PRINTdept_test(98);   

----[�迭]
PL/SQL ���� ����
��(�÷�) - ��(��)  -  ��(���̺�)
%TYPE    %ROWTYPE   TABLETYPE
          RECORD TYPE
          
ROWTYPE : �� ��ü�� ������ �� �ִ� ����
          �÷��� ���� ���̺��� ���� ������ ���� �� �÷����� ������ �������� �ʰ�
          ������� �ѹ��� ������ �ϰ� ����ϹǷ� ���Ǽ��� ����ȴ�.
          
DEPT ���̺��� 10�� �μ������� ���� �� �ִ� ROWTYPE�� �����Ͽ� Ȱ��
SET SERVEROUTPUT ON;
DECLARE
    -- ������ ����Ÿ��
    V_dept_row /*���̺��%TABLETYPE*/ dept%ROWTYPE;
BEGIN
    SELECT * INTO V_dept_row
    FROM dept
    WHERE deptno = 10;
    --�÷��� �� ���� : rowtype.�÷���
    DBMS_OUTPUT.PUT_LINE( v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/

RECORD TYPE : �����ڰ� �����Ϸ����ϴ� �÷��� ���� ���� �࿡ ���� Ÿ���� ����
              (JAVA���� Ŭ������ ����)
������
TYPE Ÿ�Ը� IS RECORD(
--    �÷��� �÷�Ÿ��,
--    �÷���2 �÷�Ÿ��,
    ename EMP.ENAME%type,
    dname dept.dname%type
)

DECLARE
    --Ÿ���� ������ ��
    TYPE name_row IS RECORD(
        ename EMP.ENAME%type,
        dname dept.dname%type);
    --������ ����Ÿ��
    names name_row;
BEGIN
    SELECT ename, dname INTO names
    FROM emp, dept
    WHERE emp.deptno = dept.deptno
        AND empno = 7839;
    DBMS_OUTPUT.PUT_LINE(names.ename || ' / ' || names.dname);
END;
/

TABLE TYPE : �������� ������ �� �ִ� Ÿ��
TYPE Ÿ���̸� IS RECORD
TYPE Ÿ���̸� IS TABLE OF ���ڵ� Ÿ�� / %ROWTYPE INDEX BY BINARY_INTEGER/*������ǥ��*/
int[] arr = new int[50];

DECLARE
    --Ÿ���� ������ ��
    TYPE name_row IS RECORD(
         ename EMP.ENAME%type,
         dname dept.dname%type);
    TYPE name_tab IS TABLE OF name_row INDEX BY BINARY_INTEGER;
    --������ ����Ÿ��
    names name_tab;
    
    -- names[1]; ==> names(1) �ε����� ������1��
BEGIN                   -- into ����, ������ ���
    SELECT ename, dname BULK COLLECT INTO names
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;
    --PL/SQL FOR��
    --for(int i = 0; i < names.length;)
    FOR i IN 1..names.count LOOP -- i�� 1���� names�� ���̸�ŭ
        DBMS_OUTPUT.PUT_LINE(names(i).ename || ' / ' || names(i).dname);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(names(1).ename || ' / ' || names(1).dname);
    DBMS_OUTPUT.PUT_LINE(names(2).ename || ' / ' || names(2).dname);
    DBMS_OUTPUT.PUT_LINE(names(3).ename || ' / ' || names(3).dname);
    DBMS_OUTPUT.PUT_LINE(names(14).ename || ' / ' || names(14).dname);
END;
/