2020-11-23-01)������
    4. ��Ÿ������
     1)in ������
        - ���� Ž���� ���� 2�� �̻��� ǥ����(�׸�)�� ����
        - or �����ڷ� ��ȯ ����
        (�������)
        �÷��� in(ǥ����1, ǥ����2,...)
        .'�÷���'�� ����� ����( )�ȿ� ����� ǥ���� �� ��� �ϳ��� ��ġ�ϸ� ��ü������ ��
    ��)������̺��� �μ��ڵ尡 20, 60, 80�� �μ��� ���� ����� �˻��Ͻÿ�.
        Alias�� �����ȣ, �����, �μ���, �޿�
        
    (in �����ڸ� ������� �ʴ� ���)
    select employee_id as �����ȣ,
            emp_name as �����,
            department_id as �μ��ڵ�,
            salary as �޿�
        from employees
        where department_id=20 or department_id = 60 or department_id =80
        order by department_id asc
    
    (in �����ڸ� ����ϴ� ���)
    select employee_id as �����ȣ,
            emp_name as �����,
            department_id as �μ��ڵ�,
            salary as �޿�
        from employees
        where department_id in(20,60,80)
        order by 3;
        
    2)some, any ������
    - �⺻ ����� in �����ڿ� ����
    (�������)
    �÷��� ���迬���� any|some (ǥ����1, ǥ����2,...)
    .in �����ڴ� ���ϼ��� �Ǵ�(=any, some)
    .any, some�� ũ�� �񱳵� ����
    select employee_id as �����ȣ,
            emp_name as �����,
            department_id as �μ��ڵ�,
            salary as �޿�
        from employees
        where department_id = some (20,60,80)
        order by 3;
    
    ��)ȸ�����̺��� ������ �������� ȸ���� ���� ���ϸ������� �� ���� ���ϸ����� ������ ȸ���� ��ȸ�Ͻÿ�.
    select mem_id as �����ȣ,
            mem_name as �����,
            mem_mileage as ���ϸ���,
            mem_job as ����
        from member
        where mem_job = '������' 
        order by mem_mileage desc;
        
    select mem_id as �����ȣ,
            mem_name as �����,
            mem_mileage as ���ϸ���,
            mem_job as ����
        from member
        where mem_mileage > any (select mem_mileage
                                from member 
                                where mem_job = '������');
    
    select mem_id as �����ȣ,
            mem_name as �����,
            mem_mileage as ���ϸ���,
            mem_job as ����
        from member
        where mem_mileage > any (select max(mem_mileage) -- ���� ū ��! 3200 �̻��� ������ �Ϸ���
                                from member 
                                where mem_job = '������');
    
    ����] ������̺��� �μ���ȣ�� 30,50,80 �μ��� ������ ���� ����� ��ȸ�Ͻÿ�
        select employee_id as �����ȣ,
                emp_name as �����,
                department_id as �μ���ȣ,
                hire_date as �Ի���
            from employees
            where department_id not in (30, 50, 80); 
            --where not department_id =any((some))(30,50,80);
            --
                
    ����] ȸ�����̺��� �����ڷ��� �ֹι�ȣ�� �����Ͻÿ�
        ȸ����ȣ : 'e001', �ֹι�ȣ : '750501-2406017' => '010501-4406017'
        ȸ����ȣ : 'n001', �ֹι�ȣ : '750323-1011014' => '000323-3011014'
        select * from member;
        select mem_id as ȸ����ȣ,
                mem_regno1 || '-' || mem_regno2 as �ֹι�ȣ
            from member;
            commit;
        update member
            set mem_regno1 = '010501',
                mem_regno2 = '4406017'
            where mem_id = 'e001';
        select mem_id as ȸ����ȣ, mem_regno1 || '-' || mem_regno2
            from member
            where mem_id = 'e001'or
                mem_id = 'n001';
            
        update member
            set mem_regno1 = '000323',
                mem_regno2 = '3011014'
            where mem_id = 'n001';
            
    ����]ȸ�����̺��� ����ȸ���̰� ���ϸ����� 3000�̻��� ȸ�������� ��ȸ�Ͻÿ�.
        select * from member;
        select mem_id as ȸ����ȣ, mem_name as ȸ����, mem_regno1 || '-' || mem_regno2 as �ֹι�ȣ,
                 mem_job as ����, mem_mileage as ���ϸ���
            from member
            where substr(mem_regno2, 1, 1) in (2,4) and mem_mileage >= 3000;
    
    ����]��ǰ���̺�(prod)���� �з��ڵ尡 'P102'�̰� �ǸŰ���(prod_price)�� 10���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
    select prod_lgu
            from prod
            where prod_lgu = 'P101';
            
    select prod_id as ��ǰ��ȣ,
            prod_name as ��ǰ��,
            prod_lgu as �з��ڵ�,
            prod_price as �ǸŰ���
        from prod
        where prod_lgu = 'P102' and prod_price >= 100000;
        
    ����] ��ٱ������̺��� 2005�� 7�� 1�� ~ 7�� 15�� �Ǹ������� ��ȸ�Ͻÿ�. ��, ���ż����� ������ ���� ���
    select * from cart;
    select * 
        from cart
        where substr(cart_no,1,8) between ('20050701') and ('20050715')
        order by cart_qty desc;
    
    ��) ������̺��� �����  �ټӳ���� ���ϰ� �ټӳ���� 15�� �̻��� ȸ���鿡�� ���ʽ��� �����Ϸ��Ѵ�.
        ���ʽ� : �޿��� 15%, ���޾� : �޿� + ���ʽ�
        select * from employees;
        select employee_id as �����ȣ, 
                emp_name as �����, 
                hire_date as �Ի���,
                --�⵵ �̱�. extract(month fromsysdate) �� �̱�
                extract(year from sysdate) - extract(year from hire_date) as �ټӳ��,
                salary *0.15 as ���ʽ�, 
                salary as �޿�,
                (salary * 0.15) + salary as ���޾�
            from employees
            where extract(year from sysdate) - extract(year from hire_date) >= 15;
        
    ��) ȸ�����̺��� ȸ������ ���̸� �ֹι�ȣ�� �������� ����Ͻÿ�.
    select * from member;
--    select mem_id as ���̵�, mem_name as �̸�, mem_regno1 || '-' || mem_regno2 �ֹι�ȣ,
--            '120'-substr(mem_regno1,1,2) as ����
    select '19'||substr(mem_regno1,1,2),
            extract(year from sysdate)-(1900+to_number(substr(mem_regno1,1,2)))
        from member;
    select mem_id ȸ����ȣ,
            mem_name as ȸ����,
            mem_regno1||'-'||mem_regno2 as �ֹι�ȣ,
            case when substr(mem_regno2,1,1)='1' or substr(mem_regno2,1,1)='2' then
                    extract(year from sysdate) -(1900+to_number(substr(mem_regno1,1,2)))
                else extract(year from sysdate) - (2000 + to_number(substr(mem_regno1,1,2)))
                end as ����
            from member;
            
    ����) �������̺�(buyprod)���� 2005�� 1�� �����ڷḦ ��ȸ�Ͻÿ�
    select * from buyprod;
    select buy_date ������, buy_prod "���Ի�ǰ �ڵ�", buy_qty ���Լ���, buy_cost ���Դܰ�, buy_qty * buy_cost ���԰�, extract(month from buy_date)
        from buyprod
        --where buy_date >= '20050101' and buy_date <= '20050131';
        where extract(year from buy_date) = 2005 and extract(month from buy_date) = 1;
        
        