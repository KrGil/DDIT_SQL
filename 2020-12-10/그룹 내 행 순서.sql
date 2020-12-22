�׷� �� �� ����

--�ణ ��� �̰� �� ��� ��
window �Լ��� ����� �Ǵ� ���� ����
UNBOUNDED PRECEDING
    ���� ����� ��� ������
CURRENT ROW
    ������
UNBOUNDED FOLLOWING
    ���� �� ���� ��� ������

��Ÿ ���� : ���� ������ �𸣴��� �ƴ� ��Ȳ
--�� ������ �� �ڽű��� order by
SELECT empno, ename, sal, 
    SUM(sal) OVER (ORDER BY sal)
FROM emp;

SELECT empno, ename, sal, -- row
       SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM emp;

-- �ణ ����ϱ�!! ��� ������ �� �� �ִ�.
windowing
    - window �Լ��� ����� �Ǵ� ���� ����
    n PRECEDING
    - ���� �� ���� ����N��
    n FOLLOWING
    - ���� �� ���� ����N��
    
�ǽ� 7
�����ȣ, ����̸�, �μ���ȣ, �޿� ������ �μ����� �޿�, �����ȣ
������������ ���� ���� ��, �ڽ��� �޿��� �����ϴ� ������� �޿� ����
��ȸ�ϴ� ������ �ۼ��Ͻÿ�(WINDOW �Լ� ���)
SELECT * FROM emp;
SELECT empno, ename, deptno, sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal, empno 
--                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                 ) c_sum
FROM emp;

�������� WINDOWING - DEFAULT
RANGE UNBOUNDED PRECEDING
--�ΰ� ���� ǥ���̴�.
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

-- RANGE�� ROWS�� ������.
�м��ռ����� ORDER BY �� ���Ŀ� WINDOWING ���� ������ ��� ������WINDOWING�� �⺻���� ����ȴ�.
RANGE UNBOUNDED PRECEDING
== RANGE BETWEEN INBOUNDED PRECEDING AND CURRENT ROW
ROWS: �������� ���� ���� (������ ���� �����ϰ� �ڱ� �ڽŸ���)
RANGE : ������ ���� ���� (������ ���� �����ϰ� �ڱ� �ڽŸ���) --������ ���� ��� ������ �ϳ��� ������ �����. �������� ����.

SELECT empno, ename, sal,
    SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
    SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) range_sum,
    SUM(sal) OVER (ORDER BY sal) default_sum
FROM emp;


ROWNUM : select ������� ��ȯ�� ���� ��ȣ�� 1���� �ο����ִ� �Լ�
Ư¡ : WHERE������ ��� ����
      ���� �ǳʶٴ� ���·� ��� �Ұ�
      ==> ROWNUM�� 1���� ���������� ���� ��쿡�� ��밡��
      WHERE ROWNUM = 1; (O)
      WHERE ROWNUM = 2; (X) //1�� �ǳ� �پ��� ������ ���������� ��ȸ���� ����.
      WHERE ROWNUM < 5; (0) 1~4
      WHERE ROWNUM > 5; (X) 1~4�� ���� �ʰ� �ǳ� ��
      
        
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM =1;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM =2;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM < 5;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM >5;

SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate DESC;

--������ ����� 10�� �� 
1 PAGE : 1~10
2 PAGE : 11~20
N PAGE : (N-1) * 10 + 1 ~ N*10
--N PAGE : (:page - 1) * :pageSize + 1 ~ :page * :pageSize

--������ ����� 5�� ��
1 PAGE : 1~5
2 PAGE : 6~10
3 PAGE : 11~15

SELECT ROWNUM, a.*
 FROM 
    (SELECT empno, ename, hiredate
     FROM emp
     ORDER BY hiredate DESC) a 
WHERE ROWNUM BETWEEN 1 AND 10; -- 1PAGE
     
--����Ŭ�� �̷��� �ζ��κ並 �̿��ؼ� ROWNUM�� �ؾ��Ѵ�.
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM -- ���⸸ �ٲٸ� �ȴ�.
        (SELECT empno, ename, hiredate
         FROM emp
         ORDER BY hiredate DESC) a )
WHERE rn BETWEEN 11 AND 20; -- 2PAGE

--���ε� 
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM -- ���⸸ �ٲٸ� �ȴ�.
        (SELECT empno, ename, hiredate
         FROM emp
         ORDER BY hiredate DESC) a )
WHERE rn BETWEEN :st AND :ed; -- 2PAGE

-- ����¡ ����!
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM -- ���⸸ �ٲٸ� �ȴ�.
        (SELECT empno, ename, hiredate
         FROM emp
         ORDER BY hiredate DESC) a )
WHERE rn BETWEEN (:page - 1) * :pageSize + 1 AND :page * :pageSize ; -- ����¡ ����
-- �� �� �� ���Ͱ� ���� �ȵȴ�!!