2020-12-02-01)
��)��ǰ���̺��� ��ǰ�� �з��ڵ尡 'P200'���� ��ǰ�� ��ȸ�Ͻÿ�
��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �з���, �ǸŰ���
(�Ϲ� ����)
select * from prod;
select * from lprod;
select a.prod_id ��ǰ�ڵ�, a.prod_name ��ǰ��, a.prod_lgu �з��ڵ�, 
        b.lprod_nm �з���, a.prod_price �ǸŰ���
    from prod a , lprod b
    where a.prod_lgu like 'P2%' --�Ϲ�����
        and a.prod_lgu = b.lprod_gu
    order by 3;

(ansi ����)
select a.prod_id ��ǰ�ڵ�, a.prod_name ��ǰ��, a.prod_lgu �з��ڵ�, 
        b.lprod_nm �з���, a.prod_price �ǸŰ���
    from prod a
        inner join lprod b on(a.prod_lgu = b.lprod_gu) --��������
    where a.prod_lgu like 'P2%' --�Ϲ�����
    order by 3;
    
����) 2005�� 1�� 1�� ~ 15�� ���� �߻��� �����ڷ�

select * from buyprod;
select * from prod;
select buy_date  
    from buyprod
    where buy_date between '20050101' and '20050115';
select a.buy_date ����, 
        a.BUY_PROD ��ǰ�ڵ�, 
        b.prod_name ��ǰ��,
        a.BUY_QTY ����,
        a.buy_qty * a.BUY_COST �ݾ�
    from buyprod a, prod b
    where a.BUY_PROD = b.prod_id --join����
        and a.BUY_DATE between '20050101' and '20050115';
-- outer ��� ���̺��� ����Ѵ�.
-- inner ���ǿ� �ش��ϴ� ���鸸 ����Ѵ�.
-- ansi
select a.buy_date ����, 
        a.BUY_PROD ��ǰ�ڵ�, 
        b.prod_name ��ǰ��,
        a.BUY_QTY ����,
        a.buy_qty * a.BUY_COST �ݾ�
    from buyprod a 
        inner join prod b on(a.BUY_PROD = b.prod_id --join����
        and a.BUY_DATE between '20050101' and '20050115') --�Ϲ�����
    order by 1;

����)2005�� 5�� ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ�
    ��ǰ�ڵ�, ��ǰ��, ������հ�, ���Ծ��հ�
select * from prod;
select * from buyprod;
select * from cart;

select a.prod_id ��ǰ�ڵ�, a.prod_name ��ǰ��,
        sum(c.cart_qty*a.prod_price) ������հ�,
        sum(b.buy_qty*b.buy_cost) ���Ծ��հ�
    from prod a, buyprod b, cart c
    where a.prod_id = b.buy_prod and b.buy_prod = c.cart_prod --join condition
        and c.cart_no like '200505%'
        and b.BUY_DATE between '20050501' and '20050531'
    group by a.prod_id, a.prod_name
    order by 1;

����)2005�� 5�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
select c.prod_id ��ǰ�ڵ�, 
        c.prod_name ��ǰ��,
        sum(a.cart_qty * c.prod_price) ������հ�
    from cart a, prod c
    where a.cart_prod = c.prod_id --join condition
        and a.cart_no like '200505%'
    group by c.prod_id, c.prod_name
    order by 1;

--ansi
select c.prod_id ��ǰ�ڵ�, c.prod_name ��ǰ��,
        sum(a.cart_qty*c.prod_price) ������հ�,
        sum(b.buy_qty*b.buy_cost) ���Ծ��հ�
    from cart a
        right outer join prod c on(a.cart_prod = c.prod_id
        and a.cart_no like '200505%')
        left outer join buyprod b on(b.buy_prod=c.prod_id
        and b.BUY_DATE between '20050501' and '20050531')
    group by c.prod_id, c.prod_name
    order by 1;
    
����) 2005�� 1~6�� ���� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
    �ŷ�ó�ڵ�, �ŷ�ó��, ���Ծ��հ�
select distinct(buyer_name) from buyer;
select * from prod;
select * from buyprod;

select a.buyer_id �ŷ�ó�ڵ�, a.buyer_name �ŷ�ó��, sum(c.BUY_QTY*c.buy_cost) ���Ծ��հ�
    from buyer a, prod b, buyprod c
    where a.buyer_id(+) = b.prod_buyer
        and b.prod_id = c.BUY_PROD(+)
        and c.buy_date between '20050101' and '20050630'
    group by a.buyer_id, a.buyer_name
    order by 1;

--ansi
select a.buyer_id �ŷ�ó�ڵ�, a.buyer_name �ŷ�ó��, sum(c.BUY_QTY*c.buy_cost) ���Ծ��հ�
    from buyer a
        right outer join prod b on(a.buyer_id = b.prod_buyer)
        left outer join buyprod c on(b.prod_id = c.buy_prod
        and c.buy_date between '20050101' and '20050630')
    group by a.buyer_id, a.buyer_name
    order by 1;
    
select a.buyer_id �ŷ�ó�ڵ�, a.buyer_name �ŷ�ó��, sum(c.BUY_QTY*c.buy_cost) ���Ծ��հ�
    from buyer a
        inner join prod b on(a.buyer_id = b.prod_buyer)
        inner join buyprod c on(b.prod_id = c.buy_prod
        and c.buy_date between '20050101' and '20050630')
        --where�� �Ϲ������� 2���� �� ���� ����� �̻�������!!
    group by a.buyer_id, a.buyer_name
    order by 1;
    
����) ��ٱ������̺��� 2005�� 5�� ȸ���� ���űݾ��� ��ȸ�Ͻÿ�
    ȸ����ȣ, ȸ����, ���ž�
select *from cart;
select *from member;
select *from prod;
    select b.mem_id ȸ����ȣ, 
            b.mem_name ȸ����, 
            nvl(sum(a.cart_qty*c.prod_price),0) ���ž�
        from cart a, member b, prod c
        where a.CART_PROD = c.prod_id   --join ���� ���ž��� ���ϱ� ����(prod_price).
            and a.CART_MEMBER = b.mem_id --join ���� ȸ���̸� �������� ����.
            and substr(a.cart_no,1,6) = 200505
--            and a.cart_no like '200505%'
        group by b.mem_id, b.mem_name
        order by 1;

--ansi ȸ���̸��� ��� ���̺� �����ִ��� �˰�. ���� �����ִ� ���̺�(member)�� ��������
--���̺�(member)�� �����ʿ� ������ right ���ʿ� ������ left
        select b.mem_id ȸ����ȣ, 
            b.mem_name ȸ����, 
            sum(a.cart_qty*c.prod_price) ���ž�
        from cart a
            right outer join member b on( a.CART_MEMBER = b.mem_id)
            left outer join prod c on (a.CART_PROD = c.prod_id
            and substr(a.cart_no,1,8) like '200505%')
        group by b.mem_id, b.mem_name
        order by 1;
            
--ansi inner
        select b.mem_id ȸ����ȣ, 
            b.mem_name ȸ����, 
            sum(a.cart_qty*c.prod_price) ���ž�
        from cart a  --�̰Ͱ� member�� ������ �־�� ���� ���Ͽ� ���� �ִ�.
            inner join member b on( a.CART_MEMBER = b.mem_id)
            inner join prod c on (a.CART_PROD = c.prod_id
            and substr(a.cart_no,1,8) like '200505%')
        group by b.mem_id, b.mem_name
        order by 1;
        
         select b.mem_id ȸ����ȣ, 
            b.mem_name ȸ����, 
            sum(a.cart_qty*c.prod_price) ���ž�
        from member b  --member�� cart�� ������ �־�� ���� ���Ͽ� ���� �ִ�.
            inner join cart a on( a.CART_MEMBER = b.mem_id
            and substr(a.cart_no,1,8) like '200505%')
            inner join prod c on (a.CART_PROD = c.prod_id)
        group by b.mem_id, b.mem_name
        order by 1;

����) ������̺��� ������(manager_id)�� ��������� ��ȸ�Ͻÿ�.

select *from employees;
select * from departments;
select manager_id �����ڹ�ȣ, 
        department_name �μ���,
        count(*) �Ҽӻ���� 
    from departments
    group by manager_id, department_name
    order by 1;
select a.manager_id �����ڹ�ȣ, 
        b.emp_name �����ڸ�, 
        count(a.department_name) �Ҽӻ����, 
        a.department_name �μ���
    from departments a, employees b
    where a.DEPARTMENT_ID = b.department_id
    group by rollup(a.manager_id, a.department_name, b.emp_name)
    order by 3;


