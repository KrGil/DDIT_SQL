2020-12-01-03) Join
    - rdb�� �ٽ� ���
    - ������������ ���̽��� �ڷᰡ ���� ���̺� �л�Ǿ� ����ǰ�
        ���̺� ���� ���谡 �ξ��� ����
    - ���� ���� ���̺��� �ʿ��� �ڷḦ ��ȸ�ϱ� ���� ���ο����� �ʿ�
    - ���ο����� ���꿡 �����ϴ� ���Ը� ���� ���谡 �ξ��� ������ ������ ��
    (������ ����)
    1)��Ŀ� ���� : �Ϲ�����, ansi ����
    2)���� ���ǿ� ����ϴ� �����ڿ� ���� equi join, non equi join
    3)�����ϴ� ����� Ȯ�� ���ο� ���� ��������(inner join), �ܺ�����(outer join)
    4)�� �ۿ� self join, cartesian product(cross join) ������ ����.
    (�������)
    select �÷�list
        from ���̺��1 [��Ī1], ���̺��2 [��Ī2] [,���̺��3 [��Ī3],...]
        where ��������1
        [and ��������2,...]
        [and ��������,...]
        . ���̺���� ��Ī�� ����Ͽ� ������ �÷����� �ΰ� �̻��� ���̺� ���� ��� �Ҽ��� ��������
        . ��Ī�� ������� �ʴ� ��� ������ �÷����� '���̺��, �÷���' �������� ����ؾ���
        . ���������� �� ���̺� ���̿� �����ϴ� ���� ���� ���� �÷����� ���('=')���� 
          ���ϱ� ���� �������� n���� ���̺��� ���� ��� ��� n-1���� ���������� �ʿ���
        . �Ϲ����ǰ� ���������� ��� ������ ������ ��Ģ�� ����.

1. cartesian product
    - ��� ��, ��� ���� ������ �߻�(����� ���� ��
    - Ư���� ������ �ƴ� ��� ������ ����
    - ���������� ���ų� �߸� ������ ��쿡�� �߻���.
    - ansi������ cross join
��);
select count(*) from cart;
select count(*) from customers;
select count(*)
    from cart a, customers b;
(ansi ����);
select count(*)
    from cart cross join customers;
select count(*)
    from cart cross join customers cross join prod;


select 55500*209 from dual;

2. equi join(���� ����)
    - ��κ��� ���� ����
    - �������ǿ� '='�����ڰ� ����
    - ansi������ inner join���� ������
    (ansi �������)
    select �÷�list
    from ���̺��1[��Ī]
        inner join ���̺��2[��Ī] on (��������
            [and �Ϲ�����])
        [inner join ���̺��3[��Ī] on (��������
            [and �Ϲ�����])]
    [where �Ϲ�����]

��)��ٱ������̺��� 2005�� 6�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
    ����, ȸ����, ��ǰ��, �Ǹż���, �Ǹűݾ�;
select * from cart;
select * from member;
select *from prod;

-- �����ؼ� �������� --
select to_date(substr(a.cart_no,1,8)) ����,
        b.mem_name ȸ����, 
        c.prod_name ��ǰ��, 
        a.cart_qty �Ǹż���, 
        a.cart_qty*c.prod_price �Ǹűݾ�
    from cart a, member b, prod c
    where a.CART_MEMBER = b.mem_id  --��������
        and a.cart_prod = c.prod_id --��������
        and A.cart_no like '200506%'
    order by 1;
    
    -- �θ����̺��� �ڽ����̺��� �⺻Ű�� �Ǵ°� �ĺ�����
    -- �θ����̺��� �ڽ����̺��� �Ϲ�Ű�� �Ǵ°� ��ĺ�����