���� : ���� sql�� �м��Լ��� ������� �ʰ� �ۼ��ϱ�
--1. --����
SELECT a.empno �����ȣ, a.ename ����̸�, a.sal ���α޿�, max, min
    from emp a, (SELECT deptno a, max(sal) max, min(sal) min
                from emp
                group by deptno) b
    where a.deptno = b.a
    order by 3;
--2.
--��Į��
select a.empno �����ȣ, a.ename ����̸�, a.sal ���α޿�, 
        (SELECT max(sal) max
             from emp
             where deptno = a.deptno) max, 
        (SELECT min(sal) min
             from emp
             where deptno = a.deptno) min
from emp a
order by 3;
select * from emp;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP E;
WHERE E.EMPNO = C.DNO
ORDER BY 4;

SELECT a.DEPTNO AS DNO,
                    ROUND(AVG(a.SAL),2) AS avg_sal,
                    MAX(a.SAL) AS max_sal,
                    MIN(a.SAL) AS min_sal
                    FROM EMP a
                    GROUP BY a.DEPTNO;