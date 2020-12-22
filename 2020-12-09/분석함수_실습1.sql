2020-12-09 �м��Լ�
�м��Լ� : �ణ ���� ������ ���ִ� �Լ�
select �м��Լ��̸�([����]) over ( �������� �������� ��������)
from .....
�������� : PARTITION BY �÷� 
�������� : ORDER BY �÷�
�������� : PARTITION ������ Ư�� ����� ������ ����...(����)

�Ϸ��� �ϴ� �� : emp ���̺��� �̿��Ͽ� �μ���ȣ ���� �޿� ��ŷ�� ���
                (�޿� ��ũ ���� : sal���� ���� ����� ��ũ�� ���� ������ ���)
                
�������� : deptno
�������� : sal DESC;

SELECT ename, sal, deptno,
    --rank�� ���� 1�� ������ 3��
    RANK()OVER (PARTITION BY deptno ORDER BY SAL DESC) sal_rank,
    --dense_rank�� ����1�� �Ŀ� 2���� ��.
    DENSE_RANK()OVER (PARTITION BY deptno ORDER BY SAL DESC) sal_denserank, 
    --row_number�� �������� ��ü�� ����. ROWNUM�� �ٸ����� �׳� PARTITION�� ����.
    ROW_NUMBER()OVER (PARTITION BY deptno ORDER BY SAL DESC) sal_row_number
FROM emp;

-- ROWNUM ��ȣ�ο��ϱ�. 
select emp.*, ROWNUM
FROM emp;

RANK()OVER (PARTITION BY deptno ORDER BY SAL DESC) SAL_RANK
PARTITION BY deptno : 
ORDER BY sal : 
RANK() : 

�ǽ�1
��� ��ü �޿� ���� rank, dense_rank, row_number�� �̿��Ͽ�
��, �޿��� ������ ��� ����� ���� ����� ���� ������ �ǵ���.

SELECT empno, ename, sal, deptno, 
    RANK() OVER(ORDER BY sal desc, empno asc) sal_rank,
    dense_RANK() OVER(ORDER BY sal desc,empno ) dense_rank,
    row_number() OVER(ORDER BY sal desc) row_number
FROM emp;

�μ��� �����
10, 3
20, 5
30, 6
select deptno, count(*)
from emp
group by deptno;

select count(*)
from emp;

select * 
from emp
order by job, sal, hiredate;

�ǽ�2
������ ��� ������ Ȱ���Ͽ�,
��� ����� ���� �����ȣ, ����̸�, �ش����� ���� �μ��� ������� ��ȸ�ϴ� ������ �ۼ��ϼ���.
--�м��Լ�
select empno, ename, deptno, 
    count(*) OVER(partition by deptno) cnt
from emp;

--�м��Լ� �Ⱦ��� from_subquery join�̶� �θ���.
--���� ���̺� �ΰ��� �д´�.
select a.empno, a.ename, a.deptno, cnt
from emp a, (select deptno, count(*) cnt
            from emp
            group by deptno) b
where a.deptno = b.deptno;

--select �ȿ� ������ ��Į�� ���������� �θ���.
--���� ���� ������ ������ subquery�� �����Ѵ�.
10 : SELECT COUNT(*) 
     FROM emp 
     WHERE deptno = 10;
20 : SELECT COUNT(*)
     FROM EMP
     WHERE DEPTNO = 20;
select a.empno, a.ename, a.deptno, 
    (select count(*)
        from emp
        where deptno = a.deptno)cnt
from emp a
order by deptno;

WHERE : ��ȸ�Ǵ� ���� ����, WHERE���� ����� ������ �ش����� ������� ��(TREU)���� �Ǵ� �� ��� ��ȸ

SELECT *
FROM emp
WHERE 1=1;

--�μ��� �μ������� 4��° Į������ ��ȸ
�����Լ� : count, sum, avg, max, min
--ȿ�����̴�. table�� �ѹ��� ���ϱ�!
SELECT empno, ename, deptno,
    COUNT(*) OVER(PARTITION BY deptno) cnt
FROM emp
ORDER BY deptno desc;

�ǽ� 2

window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, ���α޿�, �μ���ȣ�� �ش� ����� ���� �μ��� �޿� �����
��ȸ�ϴ� ������ �ۼ��ϼ���.(�޿� ����� �Ҽ��� ��° �ڸ����� ���Ѵ�)

SELECT empno �����ȣ, ename ����̸�, sal ���α޿�, deptno �μ���ȣ, 
       round(AVG(SAL) OVER ( PARTITION BY deptno ), 2 ) sal_avg,
       TO_CHAR(AVG(SAL) OVER ( PARTITION BY deptno ), 'fm9999.00' ) sal_avg1
FROM emp;

�ǽ� 3
window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, ���� �޿�, �μ��� ���� ���� �޿��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�

SELECT empno �����ȣ, ename ����̸�, sal ���α޿�, 
        MAX(sal) OVER (PARTITION BY deptno) max_sal,
        MIN(sal) OVER (PARTITION BY deptno) min_sal
FROM emp;

���� : ���� sql�� �м��Լ��� ������� �ʰ� �ۼ��ϱ�
--1.
SELECT a.empno �����ȣ, a.ename ����̸�, a.sal ���α޿�, max, min
    from emp a, (SELECT deptno a, max(sal) max, min(sal) min
                from emp
                group by deptno) b
    where a.deptno = b.a
    order by 3;
--2.
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

    
    
    