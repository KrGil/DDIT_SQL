2020-12-14 SQL WINDOW �ǽ�����

SELECT empno, ename, sal
FROM emp;

SELECT *
FROM salgrade;

SELECT a.empno, a.ename, a.sal, b.grade
FROM emp a, salgrade b
WHERE a.sal between b.losal and b.hisal;
--WHERE a.sal >= salgrade.losal
--      AND a.sal <= salgrade.hisal;

--������ ����
14, 4 �ڽŰ� ���� ��ȣ�� ����!! 14*3�ϸ� �� 42���� ���´�.
SELECT *
FROM emp, dept
WHERE emp.DEPTNO != dept.DEPTNO;

�ǽ� --3
��� ����� ���� �����ȣ, ����̸�, �Ի�����, �޿��� �޿��� ���� ������
��ȸ �غ���. �޿��� ������ ��� �����ȣ�� ���� ����� �켱������ ����.

�켱������ ���� ���� ������� ���α����� �޿� ���� ���ο� �÷����� ����
WINDOW �Լ� ����...
SELECT ROWNUM,(select empno, ename,sal
                FROM emp
                ORDER BY sal;)
FROM emp;

SELECT a.empno, a.ename, a.sal, SUM(b.sal)
FROM 
    (select empno, ename,sal
    FROM emp
    ORDER BY sal) a,
    (select empno, ename,sal
    FROM emp
    ORDER BY sal) b
WHERE a.sal >= b.sal
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal;

SELECT a.empno, a.ename, a.sal, SUM(b.sal)
FROM emp a, emp b
WHERE a.sal >= b.sal
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal;

SELECT a.empno, a.ename, a.sal, SUM(b.sal) c_sum
FROM
    (SELECT a.*, ROWNUM rn
     FROM
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal, empno) a) a,
    (SELECT a.*, ROWNUM rn
     FROM
        (SELECT empno, ename, sal
         FROM emp
         ORDER BY sal, empno) a) b
 WHERE a.rn >= b.rn
 GROUP BY a.empno, a.ename, a.sal
 ORDER BY a.sal, a.empno;
 
 ----WINDOWING ����!! �м��Լ�
 SELECT a.empno, a.ename,a.sal, sum(a.sal) OVER (ORDER BY sal, empno)
 FROM emp a;
 
 --�ǽ� 0��
 ����� �μ��� �޿�(SAL) �� ���� ���ϱ�
 EMP ���̺� ���
 1. ���� ���Ƿ� ���� SINGLE ROW FUNCTION : LENGTH, LOWER
 SINGLE ROW FUNCTION : LENGTH, LOWER
 MULTI ROW FUNCTION : SUM , MAX, MIN
 
 SELECT *
 FROM dual; --���� �ϳ� �÷��� �ϳ�.
 --DUAL �� TEST�Ҷ�

 SELECT LENGTH('hello, World') 
 FROM emp;
 --���� ���Ƿ� ������ ��ȣ�� �ߺ����� �ʰ� �������.
 SELECT dual.*, LEVEL
 FROM dual
 CONNECT BY LEVEL <= 10; --�� �����ϱ�
 
 SELECT LEVEL
 FROM dual              -- ���뼺�� ����
 CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp);
 
 10 3
 20 5
 30 6
 
 SELECT deptno, COUNT(*)
 FROM emp
 GROUP BY deptno;
 
 ------------------------------------------
SELECT  A.empno, a.sal, a.deptno, B.rn
FROM
    (SELECT ROWNUM r, a.*
    FROM 
        (SELECT empno, sal, deptno
         FROM emp
         ORDER BY deptno, sal, empno) a ) a, 
     
    (SELECT ROWNUM r, b.*
     FROM 
        (SELECT a.deptno, b.rn
         FROM
            (SELECT deptno, COUNT(*) cnt
             FROM emp
             GROUP BY deptno) a,
        (SELECT LEVEL rn
         FROM dual
         CONNECT BY LEVEL <= (SELECT COUNT(*) FROM emp)) b
WHERE a.cnt >= b.rn
ORDER BY a.deptno, b.rn) b ) b
WHERE a.r = b.r;