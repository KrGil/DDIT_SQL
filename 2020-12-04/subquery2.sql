2020-12-04-02)
��)������� ��ձ޿����� ���� �޿��� �޴� ����� ����Ͻÿ�
    ȸ����ȣ, �����, �޿�
    
(where ���� �������� ���);
--�ѹ��ѹ� �������� �����.. ������
select employee_id �����ȣ,
        emp_name �����,
        salary �޿�
    from employees
    where salary > (select avg(salary)
                        from employees)
    order by 3 desc;

(from ���� �������� ���);
--�ѹ��� �������� ���
select employee_id �����ȣ,
        emp_name �����,
        salary �޿�
    from employees a, (select avg(salary) sal
                        from employees) b
    where salary > b.sal
    order by 3 desc;