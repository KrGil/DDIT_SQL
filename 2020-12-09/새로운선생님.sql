
--������ �˱� 
explain plan for
select *
    from jobs j, employees e
    where j.job_id = e.job_id;

select *
from table(dbms_xplan.display);

--���� ���� �޿��� �޴� ����� employee_id ���ϱ�
select employee_id, Max(salary)
from employees
group by employee_id;

--14
select * from emp;
--4
select * from dept;

��������
0. Unique : ���� �ߺ��� ������� ����. �� null�� ����
1. Primary key == unique + not null
	==> �ߺ����� / �ش��÷� ���� ���̺��� �������� ����, null ���� �� �� ����.
2. fk(forein key) ���� ���Ἲ
3. check ����
not null

--��ü���� �������� ����
select * 
from user_constraints
where table_name in ('EMP', 'DEPT');

--primary key ����
select *
from user_cons_columns
--where constraint_name = upper('pk_lprod');
where constraint_name = upper('pk_buyer');

--����Ŭ���� ()�� ���� �Լ��� ()�� ����. ex) sysdate
����� �μ��� �޿�(sal)�� ���� ���ϱ�
select * from emp;
select 

�м��Լ� / window �Լ� -- �Ѵ� �������̴�.
select window_funtion([arg])
over ([partition by columns] [order by columns] [windowing])
--over�� ������ �м��Լ���!!


��������
partition by �÷��ڵ�

��������
order by �÷��ڵ� [desc|asc]

��������(windowing)
ROWS|RANGE BETWEEN UNBOUNDED PRECEDING[CURRENT ROW]
AND UNBOUNDED FOLLOWING[CURRENT ROW]


