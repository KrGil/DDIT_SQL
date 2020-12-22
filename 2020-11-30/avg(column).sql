2020-11-30-01)
2. AVG(column)
    - 'column'�� �������� �׷����� ���� ���ܿ� ���� ��հ� ��ȯ
    ��) ������̺��� �� �μ��� ��� �޿��� �Ҽ� 1�ڸ����� ���Ͻÿ�.
    select department_id as �μ��ڵ�,
--            emp_name as ����̸�,
            round(avg(salary),1)
        from employees
        group by department_id--, emp_name
        order by 1;
    
��) ��ǰ���̺��� ��ǰ�з��� ��ո��԰��� ���Ͻÿ�.
select * from prod;
select prod_lgu �з��ڵ�,
        round(avg(prod_cost), -1) as ��ո��԰�
    from prod
    group by prod_lgu;
    
����)2005�� ���� ��ǰ�� ��ո��Լ����� ���Աݾ��հ踦 ���Ͻÿ�.
select * from buyprod;
select * from prod;
select extract(month from buy_date)��, 
        buy_prod ��ǰ, 
        round(avg(buy_qty),0) ��ո��Լ���, 
        sum(buy_qty*buy_cost)���Աݾ��հ�
    from buyprod
    where extract(year from buy_date) = 2005
    group by extract(month from buy_date), buy_prod
    order by 1;
    
����) 2005�� 5�� ���ں� ����Ǹ� ������ ���Ͻÿ�,
select * from cart;
select to_date(substr(cart_no,1,8)) ����,
        round(avg(cart_qty),0) ����Ǹż���
    from cart
    where cart_no like '200505%'
    group by substr(cart_no,1,8)
    order by 1;

����) ������̺��� �� �μ��� ��ձ޿����� ���� �޿��� �޴� ��������� ����Ͻÿ�.
select * from employees;
select department_id did,
        avg(salary) asal
       from employees
       group by  department_id;


select a.employee_id �����ȣ,
        a.emp_name �����, 
        a.department_id �μ��ڵ�, 
        b.department_name �μ���,
        round(c.asal) ��ձ޿�,
        a.salary �޿�
       from employees a, departments b,
            (select department_id did,
                    avg(salary) asal
               from employees
               group by department_id) c
       where a.department_id = b.department_id
            and a. department_id = c.did
            and a.salary >=asal
       order by 3,5; 
        
3. count(*|column)
    - �׷����� ���� �� �׷쿡 ���Ե� �ڷ� ��(���� ��)
    - �ܺ����ο� count�Լ��� ����� ��� '*' ��� �÷����� ����ؾ� ��

��) ������̺��� �� �μ��� �ο����� ���Ͻÿ�
select department_id �μ��ڵ�, count(*) �ο���, count(emp_name) �����
    from employees
    group by department_id;
    
��)2005�� 6�� ��ǰ�� �ǸŰǼ��� ��ȸ�Ͻÿ�
select prod_id ��ǰ�ڵ�, -- �������� ���ش�.
        prod_name ��ǰ��,
        count(cart_member) �ǸŰǼ�, -- outer join���� count(*�̰� ���� �ȵȴ�)
        cart_no ��¥
    from cart
    right outer join prod on (cart_prod = prod_id
        and cart_no like '200506%')
    group by prod_id, prod_name, cart_no
    order by 1;

        
����) ��ǰ���̺��� �� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
select * from prod;
select * from cart;

select cart_qty qty, substr(cart_prod,1,4) from cart;
select prod_lgu, 
        count(prod_name) 
    from prod
    group by prod_lgu
    order by 1;
    

����) ȸ�����̺��� �� ���ɴ뺰 ȸ������ ��ȸ�Ͻÿ�.
select * from member;    
    
select trunc(extract(year from sysdate) - extract(year from mem_bir),-1)||'��' as ���ɴ�,
        count(*) ȸ����
     from member
     group by trunc(extract(year from sysdate) - extract(year from mem_bir),-1)
     order by 1;

����) ȸ�����̺��� ���� ������ ȸ������ ���Ͻÿ�.
    select * from member;
    select mem_job ��������, 
            count(*) ȸ����
        from member
        group by mem_job;
    -- distinct (�ߺ�����)
����) ȸ�����̺��� ������ ������ ����Ͻÿ�
    ������
    select distinct(mem_job) ��������
        from member
        order by 1;
        
4. max(column), min(column)
    - 'column'���� ��� �÷��� ����� �� �� �ִ밪�� �ּҰ��� ���Ͽ� ��ȯ
    - ���������� ������ϴ� ����� 'column'�� �������� ������������(min), �Ǵ�
      �������� ���� �� �� �� ù��° ���� ���� ��ȯ
      ���� ó���ð��� �ټ� ���� �ҿ��.
    
    **�ǻ�Į�� rownum
        - ���� ���(��)�� ���࿡ �ο��� ���� ��
        - ���� 5�� �Ǵ� ���� 5�� �� �ʿ��� ������ ������� ����� �� ���(�ٸ� dbms������ top �Լ��� ������)
        
��) ȸ���� ���ϸ��� �� �ִ븶�ϸ��� ���� ���Ͻÿ�
select max(mem_mileage)
from member;

select mem_mileage
    from member
    where rownum <= 5
    order by 1 desc; -- order by ���� where���� ���� ����Ǽ� 5�� �߿��� ���������Ѵ�.?
    
-------------------------------------������ �߿��ϴ�!!--------------------------------------------
select a.mem_mileage
    from (select mem_mileage from member order by 1 desc) a -- �׷��� ���⿡ ���� ����.
    where rownum <=1;
    
��) ������̺��� �μ��� �ִ� �޿��� �ּұ޿��� ��ȸ�Ͻÿ�
select department_id �μ�, max(salary) �ִ�޿�, min(salary) �ּұ޿�
    from employees
    group by department_id
    order by 1;


