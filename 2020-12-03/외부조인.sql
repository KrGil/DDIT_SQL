2020-12-03-01)�ܺ����� -- ������ ������ ��...
 - ���������� ���������� �������� �ʴ� ��(row)�� �˻����� ����
 - �ܺ������� ������ ���̺� null������ ä���� ���� �����Ͽ� ���� ���� 
 - �������� ��� �� ������ ���̺� ���Ե� �÷��ڿ� �ܺ����� ������ 
   '(+)'�� ��� : �Ϲ� �ܺ�����
 - �ϳ� �̻��� ���� ������ �ܺ����εǴ� ��� ��� ���� ���ǿ� '(+)'������ ���
 - �ϳ��� ���̺��� ���ÿ� Ȯ��Ǵ� �ܺ������� ������ �ʴ´�. ��, a,b,c ���̺���
   �ܺ������ϴ� ��� a�� �������� b�� �ܺ������ϴ� ���ÿ� c�� �������� b�� 
   �ܺ��������� ���� --������ ���̺��ʿ��ٰ� (+)�� ���ش�.
   ex) where a.Col = b.Col(+) -- �� ���̺��ٰ� null�� �־ Ȯ���� �־��.
            and c.col = b.col(+) -- ���ȵ� �ϳ��� ���̺� ���δٸ����̺�� Ȯ���� ���� �ʴ´�.    
 - �Ϲ������� �߰��� �ܺ������� �Ϲݿܺ������� ����ϸ� �������ΰ���� ��ȯ -- ansi �ܺ����� �̳� subquery
 (ansi �ܺ����� ��� ����) --��Ȯ�� ���
 select �÷�list
    from ���̺��[��Ī]
    full|right|left outer join ���̺��2[��Ī] on(��������
                        [and �Ϲ�����1])
    [full|right|left outer join ���̺��3[��Ī] on(��������
                        [and �Ϲ�����2])]
    [where �Ϲ�����]
        .full : ���� ���̺� ��� Ȯ��
        .right : ���̺��2�� ���̺��1���� �� ���� ������ �ڷᰡ �ִ� ���(���̺��1�� Ȯ��Ǵ� ���)
        .left : ���̺��1�� ���̺��2���� �� ���� ������ �ڷᰡ �ִ� ���(���̺��2�� Ȯ��Ǵ� ���)
        .�Ϲ�����1, �Ϲ�����2�� �ش� ���̺�鿡�� ����Ǵ� ����
        .where ���� �Ϲ������� ��ü�� ����� ���� --����
        
��)��� ȸ���鿡 ���� �������踦 ��ȸ�Ͻÿ�
    ȸ����ȣ, ȸ����, ������հ�;
select *from member;
select distinct(cart_prod)from cart;
select distinct(prod_id) from prod;

select (a.cart_prod) a,
       (b.prod_id) b
    from cart a, prod b
    where a.cart_prod(+) = b.prod_id;
    
-- oracle
select a.mem_id ȸ����ȣ, a.mem_name ȸ����, 
        nvl(sum(b.CART_QTY*c.prod_price),0) ������հ�
    from member a, cart b, prod c
    where a.mem_id = b.cart_member(+)
        and b.CART_PROD = c.prod_id(+)
    group by a.mem_id, a.mem_name
    order by 1;
-- ansi
select a.mem_id ȸ����ȣ, a.mem_name ȸ����, 
        nvl(sum(b.CART_QTY*c.prod_price),0) ������հ�
    from member a
            left outer join cart b on (a.mem_id = b.cart_member)
            left outer join prod c on (b.CART_PROD = c.prod_id)
    group by a.mem_id, a.mem_name
    order by 1;
    
��) 2005�� 3�� ������ ��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�
(4���� �Ǹŵ� ��ǰ�� ����);
select count(distinct buy_prod) ��ǰ�ڵ�
    from buyprod
    where buy_date between '20050201' and '200502280';
    
(�Ϲݿܺ�����);
select a.BUY_PROD ��ǰ�ڵ�, b.prod_name ��ǰ��, sum(a.buy_qty) ���Լ���, sum(a.buy_qty*a.buy_cost)���Աݾ�
    from buyprod a, prod b
    where a.BUY_PROD(+) = b.prod_id --29��
--        and a.buy_date between '20050201' and '20050228' -- ���ϸ� 74��...
    group by a.BUY_PROD,b.prod_name;
    
--ansi
select b.pROD_id ��ǰ�ڵ�, b.prod_name ��ǰ��, nvl(sum(a.buy_qty),0) ���Լ���, nvl(sum(a.buy_qty*a.buy_cost),0)���Աݾ�
    from buyprod a
        right outer join prod b on(a.BUY_PROD(+) = b.prod_id
        and a.buy_date between '20050201' and '20050228') -- ���ϸ� 74��...
    group by b.pROD_id, b.prod_name
    order by 1;


--subquery
select buy_prod id, buy_qty qty, buy_cost 
    from buyprod
    where buy_date between '20050201' and '20050228';
select * from prod;

select a.prod_id ��ǰ�ڵ�, 
        a.prod_name ��ǰ��, 
        nvl(sum(b.qty),0) ���Լ���, 
        nvl(sum(b.qty*b.buy_cost),0) ���Աݾ�
    from prod a, (select buy_prod id, 
                        buy_qty qty, 
                        buy_cost 
                    from buyprod 
                    where buy_date between '20050201' and '20050228') b
    where b.id(+) = a.prod_id
    group by a.prod_id, a.prod_name
    order by 1;

����)��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�
��ǰ�з��ڵ�, �з���, ��ǰ�� ��
--ansi
select *from lprod;
select * from prod;
select count(distinct prod_lgu) from prod;
select a.lprod_gu ��ǰ�з��ڵ�, 
        a.lprod_nm �з���, 
        count(b.prod_lgu) "��ǰ�� ��"
    from lprod a
        left outer join prod b on(a.lprod_gu = b.prod_lgu)
    group by a.lprod_gu, a.lprod_nm
    order by 1;

--oracle
select a.lprod_gu ��ǰ�з��ڵ�, 
        a.lprod_nm �з���, 
        count(b.prod_lgu) "��ǰ�� ��" -- count()�ȿ� null���� ���� �⺻Ű�� ���°� ���� ������.
    from lprod a , prod b
    where a.lprod_gu = b.prod_lgu(+)
    group by a.lprod_gu, a.lprod_nm
    order by 1;

--subquery
select count(*) "��ǰ�� ��"
    from prod;
select a.lprod_gu ��ǰ�з��ڵ�, 
        a.lprod_nm �з���, 
        nvl(b.cnt,0) "��ǰ�� ��"
    from lprod a , (select count(*) cnt, prod_lgu
                        from prod 
                        group by prod_lgu) b
    where a.lprod_gu = b.prod_lgu(+)
    order by 1;
    
����) ������̺��� ��� �μ��� ��ձ޿��� ����Ͻÿ�
��ձ޿��� ���������� ����ϰ�, �μ��ڵ� �μ���, ��ձ޿��� ����Ұ�
select * from employees;
select * from departments;
--ansi
select a.department_id �μ��ڵ�, 
        nvl(a.DEPARTMENT_NAME,'����') �μ���, 
        round(avg(b.SALARY)) ��ձ޿�
    from departments a 
        full outer join employees b on(a.department_id = b.department_id)
    group by a.department_id, a.DEPARTMENT_NAME
    order by 1;
--oracle
select a.department_id,0 �μ��ڵ�, 
        a.DEPARTMENT_NAME �μ���, 
        round(avg(b.SALARY)) ��ձ޿�
    from departments a, employees b
    where a.department_id = b.department_id(+)
    group by a.department_id, a.DEPARTMENT_NAME
    order by 1;
--subquery
select department_id did, round(avg(salary)) avg 
    from employees
    group by department_id;
    
select a.department_id �μ��ڵ�, 
        a.DEPARTMENT_NAME �μ���, 
        avg ��ձ޿�
    from departments a, (select department_id did, round(avg(salary)) avg 
                            from employees
                            group by department_id) b
    where a.department_id = b.did(+)
    order by 1;

����) 2005�� 6�� ��ǰ�� ����� ��Ȳ�� ��ȸ�Ͻÿ�
    ��ǰ�ڵ�, ��ǰ��, �԰�����հ�, ���Ծ��հ�, �������հ�, ������հ�
select * from prod;
select * from buyprod;
select * from cart;

select c.prod_id ��ǰ�ڵ�,
        c.prod_name ��ǰ��, 
        nvl(sum(a.buy_qty),0) �԰�����հ�, 
        nvl(sum(a.buy_qty*c.prod_cost),0) ���Ծ��հ�, 
        nvl(sum(b.cart_qty),0)�������հ�,
        nvl(sum(b.cart_qty*c.prod_price),0)������հ�
    from prod c
        left outer join buyprod a on (c.prod_id = a.buy_prod
            and a.BUY_DATE between '20050601' and '20050630')
        left outer join cart b on(b.cart_prod = c.prod_id
            and substr(b.cart_no,1,6)='200506')
    group by c.prod_id, c.prod_name
    order by 4 desc;



