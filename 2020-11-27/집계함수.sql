2020-11-27-02)�����Լ�
    - �� ���̺��� �����͵��� Ư���÷��� �������� �׷�ȭ�ϰ� �� �׷쳻�� �����Ϳ� ���Ͽ�
      ����ó��(�հ�, ���, ����, �ִ밪, �ּҰ�)
    - sum, avg, count, min, max
    - select ���� �����Լ��� �Ϲ��÷��� ���� ���Ǹ� �ݵ�� group by���� ����Ǿ����.
    (�������)
    select �÷���1,...,
            sum(�÷���)|count(*|�÷���) |max(�÷���)|min(�÷���)
        from ���̺��
        [where ����]
        [group by �÷���1,..]
        [having ����]
        [order by �÷���|�÷��ε���];
        . select ������ '[�÷���1,...,]'�� �����Ǹ� group by ���� �ʿ� ����
        (���̺� ��ü�� �ϳ��� �׷�)
        . '[group by �÷���1,..]'�� ����Ǵ� �÷����� select ������ �����Լ� �̿��� 
        �÷����� ����ϰ� �ʿ信 ���� select������ ������� ���� �÷��� ��� ����
        . 'group by'������ ����Ǵ� �÷��� ������ �׷��� �Ǵ� ������.
        .'[having ����]' : �����Լ� ��ü�� ������ �ο��� ��� ���
        
1.sum(column)
    -'column'�� ����� �� �׷캰 �հ踦 ���Ͽ� ��ȯ
��)������̺��� ��ü ������� �޿� �հ踦 ���Ͻÿ�
    select sum(salary)
        from employees;

��)������̺��� �μ��� ������� �޿� �հ踦 ���Ͻÿ�
    select  department_id �μ���, sum(salary), count(*)
        from employees
        group by department_id
        order by 1;
��) ȸ�����̺��� ���� ȸ���� ���ϸ��� �հ踦 ��ȸ�Ͻÿ�.
    select * from member;
    select case when substr(mem_regno2,1,1) = 1 or substr(mem_regno2,1,1) = 3 then '����'
                else '����' end ����,
            sum(mem_mileage)
        from member
        group by case when substr(mem_regno2,1,1) = 1 or substr(mem_regno2,1,1) = 3 then '����'
                else '����' end
        order by 1;

��)2005�� 2-3�� ��ǰ�� ������Ȳ�� ��ȸ
    select * from buyprod;
    select buy_prod ��ǰ��, sum(buy_qty) �����հ�, to_char(sum(buy_qty*buy_cost), '99,999,999') �ݾ��հ�
        from buyprod
        where buy_date between '20050201' and '20050331'
        group by buy_prod
        order by 1;
        
��)2005�� 2-3�� ��ǰ�� ������Ȳ�� ��ȸ�ϵ� ���Լ����� 100�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�.
    select * from buyprod;
    select buy_prod ��ǰ��, sum(buy_qty) �����հ�, to_char(sum(buy_qty*buy_cost), '99,999,999') �ݾ��հ�
        from buyprod
        where buy_date between '20050201' and '20050331'
        having sum(buy_qty) >= 100          -- having���� sum(�����Լ�) ������ �������!
        group by buy_prod
        order by 1;
        
        
** ��ǰ���̺��� ����� �����Ͻÿ�
    ����� ��������� 130%�̸� �����̴�.
    select prod_totalstock ���, prod_properstock ������� from prod;
    update prod
        set prod_totalstock = to_number(prod_properstock + prod_properstock*0.3);

��)��ǰ���̺��� ��ǰ �з��� ��� �հ踦 ���Ͻÿ� 250�� �̻� �����ִ� �ڷḦ ��ȸ
    select * from prod;
    select prod_lgu as ��ǰ�з�,
            sum(prod_totalstock) as ����հ�
        from prod
        having sum(prod_totalstock) >=250
        group by prod_lgu
        order by 1;
    
��) ��ٱ������̺��� 2005�� 5�� ȸ���� ��������
    ȸ����ȣ, ��������հ�
    select * from cart;
    select cart_member ȸ����ȣ, sum(cart_qty) ��������հ�
        from cart
        where substr(cart_no,1, 6) = '200505'
        group by cart_member
        order by 1;
��) ��ٱ������̺��� 2005�� 5�� ��ǰ�� ��������
    ��ǰ�ڵ�, ��������հ�
    select cart_prod ��ǰ�ڵ�, sum(cart_qty)
        from cart
        where cart_no like '200505%'
        group by cart_prod
        order by 1;
��) ��ٱ������̺��� 2005�� 5�� ���ں� ȸ���� ��������
    ��¥, ȸ����ȣ, ��������հ�
    select to_date(substr(cart_no, 1, 8)) ��¥, 
            cart_member ȸ����ȣ,
            sum(cart_qty) ��������հ�
        from cart
        where substr(cart_no, 1, 6) = '200505' --cart_no like '200505%'
        group by to_date(substr(cart_no, 1, 8)), cart_member
        order by 1;
        