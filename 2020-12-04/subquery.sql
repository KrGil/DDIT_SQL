2020-12-04-01)��������
    - ���� �ȿ� ���Ե� �Ǵٸ� ������ ����������� ��
    - ���������� '( )'�ȿ� ���
    - �� ������ ���� ���� �����
    - �����ڿ� ���� ���� ��� ������ �����ʿ� ����ؾ� ��
    (���������� ����)
    - ���������� ������ ���ο� ���� : ������ �ִ� ��������(Correlated Subquery)�� 
      �񿬰��� ��������(Noncorrelated subquery)�� ����
    - ���Ǵ� ��ġ�� ���� : �Ϲݼ�������(select ���� ���), �ζ��� ��������(from ���� ���),
                          ��ø��������(where ���� ���)���� ����
    - ��ȯ�ϴ� ��/���� ���� ���� : ������/���Ͽ�, ������/���Ͽ�, ������/���߷� ������ ���еǸ�
      �̴� ����ϴ� �����ڿ� ���� ������.
      
1. ������ ���� ��������
    - ���������� �����������̿� ������ �߻����� �ʴ� ��������
    ��) ������̺��� ��ձ޿����� ���� �޿��� �޴� �������(�����ȣ, �����, �μ��ڵ�, �޿�) ��ȸ
    (�������� : �����ȣ, �����, �μ��ڵ�, �޿� ��ȸ)
    
    select employees_id as �����ȣ,
            emp_name as �����,
            department_id as �μ��ڵ�,
            salary as �޿� 
        from employees
        where salary >=(��ձ޿�);
    
    (�������� : ��ձ޿�)
    select avg(salary)
    from employees;
    
   select employee_id as �����ȣ,
        emp_name as �����,
        department_id as �μ��ڵ�,
        salary as �޿� 
    from employees
    where salary >= (select avg(salary)
                    from employees);

��)�θ�μ��ڵ�(parent_id)�� null�� �μ��� �Ҽӵ� ��������� ��ȸ�Ͻÿ�
    �����ȣ, �����, �μ��ڵ�, ��å�ڵ�(job_id)
    (�������� : ������̺��� ��������� ��ȸ)
select employee_id �����ȣ,
        emp_name �����, 
        department_id �μ��ڵ�, 
        job_id ��å�ڵ�(job_id)
    from employees
    where department_id =�θ�μ��ڵ�(parent_id)�� null�� �μ�;
    
(�������� : �μ����̺��� �θ�μ��ڵ�(parent_id)�� null�� �μ��ڵ�)
select department_id
    from departments
    where parent_id is null;

�μ����̺��� �μ��ڵ� 60(IT)�� �θ�μ��ڵ带 null�� ����)
    update departments
        set parent_id = null
        where department_id = 60;   

(����);
select a.employee_id �����ȣ,
        a.emp_name �����, 
        a.department_id �μ��ڵ�, 
        a.job_id ��å�ڵ�
    from employees a
    where exists (select department_id
                     from departments b
                    where parent_id is null
                    and a.department_id = b.DEPARTMENT_ID);
2. ������ ��������
    - ���������� �������� ���̿� ������ �߻��Ǵ� ��������

��) �����̷����̺�(job_history)�� ��������� ��ȸ�Ͻÿ�
    �����ȣ, �����, �μ��ڵ�, �μ����̴�.
select * from job_history;
select * from employees;

select a.employee_id �����ȣ, 
       (select b.emp_name
            from employees b
            where a.employee_id = b.employee_id) �����,
        a.department_id �μ��ڵ�,
        (select c.department_name
            from departments c
            where a.department_id = c.department_id) �μ���
    from job_history a;
    
����) ��ǰ���̺��� ���������� ����Ͽ� 'P300'������ ��ǰ��
    ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �з����� ����Ͻÿ�
select * from prod;
select * from lprod;
select lprod_gu 
    from lprod b
    where a.prod_lgu = b.lprod_gu and b.lprod_gu like 'P30%';

select a.prod_id ��ǰ�ڵ�, 
        a.prod_name ��ǰ��, 
        a.prod_lgu �з��ڵ�, 
       (select lprod_gu 
            from lprod b
            where a.prod_lgu = b.lprod_gu ) �з���
    from prod a
    where a.prod_lgu like 'P3%';

��)������� ��ձ޿��� ����Ͽ� ��ձ޿����� �� ���� �޿��� �޴� ������� �Ҽӵ�
    �μ��ڵ�� �μ����� ����Ͻÿ�(subquery ���)
    (�������� : �μ����̺��� �μ��ڵ�� �μ����� ���)
select a.department_id �μ��ڵ�,
        a.department_name �μ���
    from department a
    where a.department_id in (��ձ޿����� �� ���� �޿��� �޴� ������� �Ҽӵ� �μ�);

(��������1 : ������̺��� ��ձ޿����� �� ���� �޿��� �޴� ������� �Ҽӵ� �μ�);
select b.department_id
    from employees b
    where b.salary > (��ձ޿�);

select b.department_id
    from employees b
    where b.salary > (select avg(salary)
                        from employees);

(��������2 : ��ձ޿�);
select avg(salary)
    from employees;

(����); -- in
select a.department_id �μ��ڵ�,
        a.department_name �μ���
    from departments a
    where a.department_id in (select b.department_id
                                from employees b
                                where b.salary > (select avg(salary)
                                                    from employees))
    order by 1;
-- exists
select a.department_id �μ��ڵ�,
        a.department_name �μ���
    from departments a
    where exists (select 1
                    from employees b
                    where a.DEPARTMENT_ID = b.department_id
                        and b.salary > (select avg(salary)
                                        from employees))
    order by 1;
    
��)�����μ���(parent_id) 90���μ�(��ȹ��)�� ������� �޿��� �ڽ��� �����ִ� �μ���
    ��ձ޿��� 10% �λ��Ͻÿ�.
select * from departments;
select *from employees;

(���� : �����μ��� 90���� �μ��� �μ��� ��� �޿�;
select a.department_id, 
        avg(a.salary) 
    from employees a, departments b
    where a.department_id = b.department_id 
        and b.parent_id = 90
    group by a.department_id;

commit;
(update);
update employees c
    set c.salary = (select round(c.salary + aa.avg)
                    from (select a.department_id deptid,
                                (avg(a.salary)*0.1) avg
                            from employees a, departments b
                            where a.department_id=b.department_id
                                and b.parent_id = 90
                            group by a.department_id) aa
                    where c.department_id = aa.deptid)
    where c.department_id in (select department_id
                                from departments
                                where parent_id=90);
    
select c.department_id �μ���ȣ, 
        c.salary �޿�
    from employees c, (select aa.avg
                            from (select a.department_id deptid,
                                        round(avg(a.salary)*1.1) avg
                                    from employees a, departments b
                                    where a.department_id=b.department_id
                                        and b.parent_id = 90
                                    group by a.department_id) aa
                            where c.department_id = aa.deptid);
select aa.avg
    from (select a.department_id deptid,
                round(avg(a.salary)*1.1) avg
            from employees a, departments b
            where a.department_id=b.department_id
                and b.parent_id = 90
            group by a.department_id) aa;
            
select a.department_id,
        round(avg(a.salary)*1.1) avg
    from employees a, departments b
    where a.department_id=b.department_id
        and b.parent_id = 90
    group by a.department_id;

select department_id ����̸�, �μ���, avg(salary)��ձ޿�
    from departments a;

create or replace view v_emp01
as
    select a.emp_name, a.salary, a.department_id
        from employees a
        where a.department_id in(select department_id
                                    from departments
                                    where parent_id =90)
        order by 3
        with read only;
--
select * from v_emp01;

select a.emp_name, a.salary, a.department_id
    from employees a
    where a.department_id in(select department_id
                                from departments
                                where parent_id =90)
    order by 3;
rollback;
select salary, emp_name 
    from employees
    where department_id = 70;
    8200
    7700
    7800
    6900
    
update employees
    set salary = 8200
    where emp_name = 'John Chen';
