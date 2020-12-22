PL/SQL
- Procedural Language /SQL --������ ���
- ����Ŭ���� �����ϴ� ���α׷��� ���
- ������ ������ ���� SQL�� �Ϲ� ���α׷��� ��� ��Ҹ� �߰�
    SQL���� �������� �ʴ� �ݺ���, ���ǹ��� ����
- �����͸� ���������� ó���ϴµ� �� ����

java
����Ÿ�� ������ = ������;
pl/sql
������ ����Ÿ�� := ������;

�⺻����
 Declare(�����) --���⼭�� ���� ����.
    - ����, ����� ����
    - ��������
 Begin(�����) --���⸸ ������ ���� ����.
    - ���, �ݺ��� ���� ���� ����
 Exception(���� ó����)
    - ���� ���� ���� �߻��� catch, �ļ���ġ
    - ��������
    
������
���Կ����� : :=

PL/SQL
���� : DECLARE (��������) - ����, ��� ���� ����
      BEGIN(���� �Ұ�) - �����Ͻ� ����(SQL, IF, LOOP)
      EXCEPTION(��������) - ����ó��(JAVA-TRY,CATCH)
      
  1. 10�� �μ��� DNAME, LOC �÷� �ΰ��� ������ ��´�.
  2. �ΰ��� �������� ���(System.out.println)
  
SELECT *
FROM dept;

--describe 
DESC dept;

���� ���� : ������ ����Ÿ��;
pl/sql : ������ �۸�� V_xxx ���ξ� ���

--����Ʈ �Ϸ��� �ݵ�� �̰� �ؾ���.
SET SERVEROUTPUT ON;
-- �͸���! Anonymous block
DECLARE
     V_DNAME VARCHAR2(14); --�� �ϳ��� ���� ���尡��! ������ �����Ϸ��� �迭�̳� ����Ʈ!
     V_LOC VARCHAR2(13);
BEGIN
---------------------������ �� ��� INTO ������1, ������2
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
    FROM dept
    WHERE deptno = 10;
     --����� ����. SYSOUT�� ���� ȿ��
    --  System.out.println(v_dname + " / " + v_log);
    DBMS_OUTPUT.PUT_LINE(V_DNAME || '/ ' || V_LOC);
END;
/
--/�� ;�� ���� ������ �Ѵ�.


-- ���� ��ü������ �� �� �ִ�.
Anonymous block
--����ؼ� ����
procedure
 - return �ʿ� ����.
function
 - return �ʼ�


AOP(Aspect Oriented Programing)
OOP(Object Oriented Programing)

view�� �����̴�
- view�� �ζ��κ��.

�������� : Ư�����̺��� �÷����� ������ Ÿ���� �ڵ����� ���� ==> �÷��� ������ Ÿ���� �ٲ�
        PL/SQL ����� ���� ����θ� ������ �ʿ䰡 ������ : ���������� ����
        ���̺��.�÷���%TYPE;
        
DECLARE
     V_DNAME dept.dname%TYPE;--<==VARCHAR2(14);
     V_LOC dept.loc%TYPE;--<==VARCHAR2(13);
BEGIN
---------------------������ �� ��� INTO ������1, ������2
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
    FROM dept
    WHERE deptno = 10;
     --����� ����. SYSOUT�� ���� ȿ��
    --  System.out.println(v_dname + " / " + v_log);
    DBMS_OUTPUT.PUT_LINE(V_DNAME || '/ ' || V_LOC);
END;
/

pl/sql block ����
1. �͸� �� : inline-view
2. procedure : ����Ŭ ������ ������ pl/sql ��, ���ϰ��� ����.
3. function : ����Ŭ ������ ������ pl/sql ��, ���ϰ��� �ִ�.

����Ŭ ��ü
CREATE ����Ŭ��üŸ�� ��ü�̸�....
CREATE TABLE ���̺��
CREATE [OR REPLACE] VIEW ���̸� --OR REPLACE �̸��� ������ �����϶�.

CREATE /*OR REPLACE */PROCEDURE printdept IS 
    --�����(DECLARE)
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE(v_dname || ' / ' || v_loc); 
END;
/

���ν��� �����ϱ�!;
EXEC ���ν��� ��
EXEC printdept;

���� ���ν����� 10�� �μ��� ������ ��ȸ�� �ǰԲ� �ڵ尡 ������(hard coding)
procedure ���ڷ� ��ȸ�ϰ� ���� �μ���ȣ�� �޵��� �����Ͽ� �ڵ带 �����ϰ� ����� ����

���ν����� ������ �� ���ڸ� ���ν����� �ڿ� ������ �� ����
���ڴ� �޼ҵ�� ���������� �������� ���� �� ����

�����ð����� ���ν������� ���� �̸��� P_XXX ���ξ ����ϱ�� �սô�.

CREATE OR REPLACE PROCEDURE [(���ڸ� ���� Ÿ��)]
CREATE OR REPLACE PROCEDURE printdept(p_deptno dept.deptno%TYPE) IS 
    --�����(DECLARE)
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = p_deptno; -- �Ķ���� ���� �޾Ƽ� ���뼺�� ������! 10;
    DBMS_OUTPUT.PUT_LINE(v_dname || ' / ' || v_loc); 
END;
/

EXEC printdept(50);

�ǽ� (procedure ���� �ǽ� pro_1)
printemp procedure ����
param : empno
logic : empno�� �ش��ϴ� ����� ������ ��ȸ�Ͽ� ����̸�, �μ��̸��� ȭ�鿡 ���

select * from emp;
select * from dept;
CREATE OR REPLACE PROCEDURE printempno(p_empno emp.empno%TYPE) IS
    V_empno emp.empno%TYPE
    V_dname dept.dname

BEGIN

END;
/

select * from emp;
select * from dept;
SELECT a.ename, b.DEPTNO
    from emp a, dept b
    where a.deptno = b.DEPTNO
        AND a.empno = 7369;
        
        
CREATE OR REPLACE PROCEDURE printempno(p_empno emp.empno%TYPE) IS
    V_ename emp.ename%TYPE;
    V_dname dept.dname%TYPE;
BEGIN
    SELECT a.ename, b.dname INTO V_ename, V_dname
    FROM emp a, dept b
    WHERE a.deptno = b.deptno
        AND a.empno = p_empno;
    DBMS_OUTPUT.PUT_LINE(V_ename || ' / ' || V_dname);
END;
/


EXEC printempno(7369);
rollback;

