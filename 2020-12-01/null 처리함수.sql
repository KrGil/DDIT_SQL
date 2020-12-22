2020-12-01-02) null ó���Լ�
    - ���꿡 ���Ǵ� �׸� �� null�� ���� �ϴ� ��� ����� null�� ��ȯ
    - is [not] null, nvl, nvl2, nullif ���� �Լ�(������)�� ���� ��

1. is [not] null
    - null �� ���θ� ���ϱ� ���ؿ� '-' ����� ������ ����.
    - �ݵ�� is[not] null �����ڸ� ����ؾ� ��.

��)������̺��� ���������ڵ�(commission_pct)�� null�� �ƴ� ����� ��ȸ�Ͻÿ�.
    �����ȣ, �����, �μ��ڵ�, ��������
    select employee_id �����ȣ,emp_name �����, department_id �μ��ڵ�, commission_pct ��������
        from employees
        where commission_pct = nvl(commission_pct,0);
        where commission_pct is not null;
    
2. nvl(c, val)
    - 'c'(�÷���)�� ���� null�̸� 'val'�� ��ȯ�ϰ� null�� �ƴϸ� 'c'�� ���� ��ȯ
    - ���꿡 ���Ǵ� ���� �׸��� ���� null�� ������ ������ �ִ� ��� ���
    - 'c'�� ������ Ÿ�԰� val�� ������ Ÿ���� ��ġ�ؾ���.
��) create table temp(
    col1 number(6),
    col2 varchar2(20) not null,
    col3 date);
    
    insert into temp(col2) values('������');
    insert into temp values(10, '�߱�', sysdate);
    
temp�� col1�� 5�� ���� ���� ����Ͻÿ�.
select col1+5 from temp WHERE col1 is not null;
select * from temp;

��) ������̺��� ���������� ���� ���ʽ��� ����Ͻÿ�
    �����ȣ, �����, ��������, ���ʽ� (nvl �̻��)
    select employee_id �����ȣ, 
            emp_name �����, 
            commission_pct ��������, 
            commission_pct*salary ���ʽ�
        from employees;
        
    select employee_id �����ȣ, 
            emp_name �����, 
            nvl(commission_pct,0) ��������, 
            nvl(commission_pct*salary,0) ���ʽ�
        from employees;
        
**ȸ�����̺��� ȸ����ȣ 'r001', 'd001', 'k001'ȸ���� ���ϸ����� null�� �ٲٽÿ�.
    select * from member;
    select mem_id ȸ����ȣ, mem_mileage ���ϸ���
        from member
        where mem_id in ('r001', 'd001', 'k001');
    
    update member
        set mem_mileage = null
        where lower(mem_id) in('r001', 'd001', 'k001');
����) ��� ȸ���鿡�� 500���ϸ����� �߰��� �����Ϸ��Ѵ�.
    ȸ����ȣ, ȸ����, �������ϸ���, ���渶�ϸ����� ���
    select mem_id ȭ����ȣ,
            mem_name ȸ����, 
            mem_mileage �������ϸ���, 
            nvl(mem_mileage,0) + 500 ���渶�ϸ���
        from member;
        
��)�������̺��� 2005�� 3�� ��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
    ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�
    select * from prod;
    select * from buyprod;
    select a.buy_prod ��ǰ�ڵ�, 
            b.prod_name ��ǰ��, 
            sum(buy_qty) ���Լ���, 
            sum(buy_cost*buy_qty) ���Աݾ�
         from buyprod a, prod b
         where b.prod_id = a.buy_prod and a.buy_date between '20050301' and '20050331'
         group by a.buy_prod, b.prod_name;
    -- outer jon
    select b.prod_id ��ǰ�ڵ�, 
            b.prod_name ��ǰ��, 
            nvl(sum(a.buy_qty),0) ���Լ���, 
            nvl(sum(a.buy_cost*a.buy_qty),0) ���Աݾ�
         from buyprod a
                right outer join prod b on(a.buy_prod = b.prod_id
                and a.buy_date between '20050301'and '20050331')
         group by b.prod_id, b.prod_name
         order by 1;
         
3.nvl2(c, val1, val2)
    -'c'�� ����  null�� �ƴϸ� val1�� ///// null�̸� val2�� ��ȯ��
    'val1'�� 'val2'�� ���� ������ Ÿ���̾�� ��.
    
    
��) ȸ�����̺��� ���ϸ����� null�� ȸ���� ��ȸ�Ͽ� ������ 'Ż��ȸ��'��,,
    null�� �ƴ� ȸ���� '����ȸ��'�� ����Ͻÿ�
    
select * from member;
select mem_id ȸ����ȣ, 
        mem_name ȸ����, 
        mem_mileage ���ϸ���, 
        nvl2(mem_mileage,'����ȸ��','Ż��ȸ��') ���
--        nvl(to_char(mem_mileage),'Ż��ȸ��') ���
    from member;
    
����) ��� ȸ���鿡�� 500���ϸ����� �߰��� �����Ϸ��Ѵ�.
ȸ����ȣ, ȸ����, �������ϸ���, ���渶�ϸ����� ���
select mem_id ȭ����ȣ,
    mem_name ȸ����, 
    mem_mileage �������ϸ���, 
    nvl(mem_mileage,mem_mileage,0) + 500 ���渶�ϸ���
from member;

4.nullif(c1, c2)
    -'c1'�� 'c2'�� ������ null, �ٸ� ���̸� c1�� ��ȯ
    
** ��ǰ���̺��� �з��ڵ尡 'P201'�� ��ǰ�� �����ǸŰ����� ���԰������� �����Ͻÿ�.
select * from prod where prod_lgu = 'P201';
commit;
update prod
    set prod_sale = prod_cost 
    where prod_lgu = 'P201';
    
��) ��ǰ���̺��� ���԰��ݰ� �����Ǹ� ������ ���� ��ǰ�� '����ó����ǰ',
    ���� �ٸ��� '�����ǰ'�� ������ ���
select * from prod;
select prod_id ��ǰ�ڵ�, 
        prod_cost ���԰���, 
        prod_sale �����ǸŰ���, 
        nvl2(nullif(prod_cost, prod_sale),'�����ǰ', '����ó����ǰ')���
    from prod;
    
    
    
    
    