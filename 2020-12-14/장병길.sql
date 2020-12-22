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