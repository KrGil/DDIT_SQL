2020-11-23-02)between
3) All ������
- ���� Ž���� ���� 2�� �̻��� ǥ����(�׸�)�� ����
- ��� ǥ������ �� ����� ���̾�� where ���� ���̵Ǵ� ������
  (���� ���Ǵ� ��찡 ����)
- and �����ڷ� ��ȯ ����
�÷��� all (ǥ����1, ǥ����2,...)

4)exists ������
 - �ݵ�� �ڿ� ���������� ���;���
 (�������)
 where exists(��������)
 
 ��) ������̺��� ��ü ����� ��ձ޿����� ���� �޿��� �����ϴ�
    ����� �ٹ��ϴ� �μ��ڵ带 ��ȸ�Ͻÿ�.
    select *from employees;
    --��ձ޿�
    select round(avg(salary)) from employees; 
    select department_id, salary
        from employees
        where salary >= (select avg(salary) from employees);
--        where salary >= avg(salary); XXXXX
        where exists (select 1
                            from employees
                            where salary > (select round(avg(salary))
                                                from employees))
    order by 1;
    
    5) between ������
        - ������ �����Ͽ� ������ �����ϴ� ��� ���
        (�������)
        �÷��� between ��1 and ��2
        . �÷����� ���� '��1'���� '��2'������ ���̸� ��(true)�� ��ȯ
        
��) ȸ�����̺��� ���ϸ����� 1000 ~ 3000 ������ ȸ�������� ��ȸ�Ͻÿ�
    alias�� ȸ����ȣ, ȸ����, ���ϸ���
(and ������ ���)
select mem_id ȸ����ȣ, 
        mem_name ȸ����, 
        mem_mileage ���ϸ���
    from member
    --where mem_mileage >= 1000 and mem_mileage <= 3000;
    where mem_mileage between 1000 and 3000;
        
����) ��ٱ������̺��� 'a001'ȸ������ 'd001'ȸ������ ���������� ��ȸ�Ͻÿ�
select * from cart;
select cart_member ȸ����ȣ, cart_no ��ǰ�ڵ�, cart_qty ���ż���
        from cart
        where cart_member between 'a001' and 'd001'
--        where cart_member >= 'a001' and cart_member <='d001'
        order by 3 desc;
        
6) LIKE ������ --****���ڿ��� ���****
    - ������ ���ϴ� ��� ����ϴ� ������
    - ���ϵ�ī��(���Ϲ��ڿ�)�� '%'�� '_'�� ���
    -'%' : '%'�� ���� ��ġ���� �� ���Ŀ� ������ ��� ���ڿ��� ����
        ex) '��%' : '��'���� �����ϴ� ��� ���ڿ��� ����
            '%��' : '��'���� ������ ��� ���ڿ��� ����
            '%��%' : �ܾ� ���ο� '��'�� �����ϴ� ��� ���ڿ��� ����
    -'_' : '_'�� ���� ��ġ���� �ϳ��� ���ڿ� ����
        ex) '��_' : '��'���� �����ϰ� 2���ڷ� �����Ǹ� �ι�° ���ڴ� ������ڵ� �������
            '_��' : '��'���� ������ 2���ڷ� ������ ���ڿ��� ����
select *from member;
select mem_name �̸�
    from member
    where mem_name like '%��%';

��) ȸ�����̺��� ȸ���� �������� '�泲'�� ȸ�������� ����Ͻÿ�
select * from member;
select mem_name ȸ���̸�, mem_add1 || '-' || mem_add2 �ּ�, mem_job ����
    from member
    where mem_add1 like '�泲%';
    
