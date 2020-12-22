2020-12-10

SELECT empno, ename, deptno
FROM emp;

SELECT *
FROM dept;

--cross join ������ ��� ������ �� �Ѵ�.
SELECT *
FROM emp, dept;
--14��, 4��
--56���� ������ �� ���´�.

SELECT *
FROM emp, dept
WHERE emp.deptno != dept.deptno;
--14��, 3��
--42���� ������ ���´�.

--����¡����(����¡�ϱ�)

����
�м���
1. ���� : OVER, PRATITION BY, ORDER BY,
   �Լ� : RANK, DENSE_RANK, ROW_NUMBER
         �����Լ� - SUM, AVG, MAX, MIN, COUNT


(�׷� ������ �� ����)
LAG(col) 
 - ��Ƽ�Ǻ� �����쿡�� ���� ���� �÷� ��
LEAD(col)
 - ��Ƽ�Ǻ� �����쿡�� ���� ���� �÷� ��
==> ���� ���� ���� Ư�� �÷��� �����ϴ� �Լ�

�����ȣ, ����̸�, �Ի�����, �޿�, �ڽź��� �޿� ������ �Ѵܰ� ���� ����� �޿�
�޿� ���� : 1. �޿��� ���� ���
            2. �޿��� ���� ��� �Ի����ڰ� ���� ���;
SELECT empno, ename, hiredate, sal,
    LEAD(sal) OVER(ORDER BY sal DESC, hiredate ASC ),
    --(col, ���� ��� ���� row.
    LEAD(sal,3) OVER(ORDER BY sal DESC, hiredate ASC )
FROM emp
ORDER BY sal DESC, hiredate ASC;

�ǽ� 5
window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, �Ի�����, �޿�,
��ü ����� �޿� ������ 1�ܰ� ���� ����� �޿��� ��ȸ�ϴ� ������ �ۼ� �ϼ���(�޿��� ���� ��� �Ի����� ���� ����� ���� ����)
SELECT * FROM emp;
SELECT empno, ename, hiredate, sal,
    LAG(sal) OVER (ORDER BY sal DESC, hiredate asc)
FROM emp
ORDER BY sal desc, hiredate asc;

select emp.*, rownum from emp;

select b.empno, b.ename, b.hiredate,a.sal, rownum
from emp b , (select ename, sal
                        from emp
                        order by sal desc) c, (select d.empno, d.ename, d.hiredate,c.sal, rownum
                                            from emp d , (select ename, sal
                                                    from emp
                                                    order by sal desc) e
                where d.ename = c.ename)
where b.ename = a.ename;

select b.empno, b.ename, b.hiredate,a.sal sal1, rownum
from emp b ,(select ename, sal
                        from emp
                        order by sal desc) a
where b.ename = a.ename;

select g.*, h.sal1, j.sal1
from emp g,
    (select b.empno, b.ename, b.hiredate,a.sal sal1, rownum aa
    from emp b ,(select ename, sal
                            from emp
                            order by sal desc) a
    where b.ename = a.ename) h,
    (select d.empno, d.ename, d.hiredate,c.sal sal1, rownum bb
    from emp d ,(select ename, sal
                            from emp
                            order by sal desc) c
    where d.ename = c.ename) j
where h.aa = j.bb-1;

        
�ǽ� 5_1
SELECT * FROM emp;

SELECT a.*, b.sal, a.sal
FROM (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) a,
     (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) b
where a.rn  = b.rn-1;

SELECT a.empno, a.ename, a.hiredate, a.sal, b.sal
FROM (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) a left outer join
     (select empno, ename, hiredate, sal,
        row_number() over(order by sal desc, hiredate asc) rn
        from emp) b on (a.rn  = b.rn+1)
ORDER BY a.rn;
a�� 2���̸� b�� 1���� ����
a�� 3���̸� b�� 2���� ����
a�� n���̸� b�� n-1���� ����
a.rn -1 = b.rn

window function�� �̿��Ͽ� ��� ����� ���� �����ȣ, ����̸�, �Ի�����, ����(job), �޿� ������
������(job) �� �޿� ������ 1�ܰ� ���� ����� �޿��� ��ȸ�ϴ� ������ �ۼ��ϼ���
(�޿��� ���� ��� �Ի����� ���� ����� ��������);
SELECT * FROM emp;
SELECT empno, ename, hiredate, job, sal,
    LAG(sal) OVER(PARTITION BY job ORDER BY sal desc)
FROM EMP
ORDER BY job, sal desc, hiredate asc;


��Ÿ ���� : ���� ������ �𸣴��� �ƴ� ��Ȳ
select empno, ename, hiredate, job, sal, 
    ROW_NUMBER() OVER(PARTITION BY job ORDER BY sal desc)
FROM emp;

��Ÿ ���� : ���� ������ �𸣴��� �ƴ� ��Ȳ
--�� ������ �� �ڽű��� order by
SELECT empno, ename, sal, 
    SUM(sal) OVER (ORDER BY sal)
FROM emp;











