2020-12-08-01)
��) 2005�� 1~6�� ��� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
    �ŷ�ó�ڵ�, �ŷ�ó��, �����

(�Ϲ� outer join);
    select a.buyer_id �ŷ�ó�ڵ�, 
            a.buyer_name �ŷ�ó��, 
            sum(b.cart_qty*c.prod_price) �����
        from buyer a,cart b, prod c
        where b.cart_prod(+) = c.prod_id
            and a.buyer_id = c.prod_buyer(+)
            and substr(b.cart_no, 1,6) between '200501' and '200506'
        group by a.buyer_id, a.buyer_name
        order by 1;

select * from buyer;
select * from cart;
(ansi outer)   ;    
    select a.buyer_id �ŷ�ó�ڵ�, 
            a.buyer_name �ŷ�ó��, 
            sum(b.cart_qty*c.prod_price) �����
        from buyer a 
            left outer join prod c on(a.buyer_id = c.prod_buyer)
            left outer join cart b on(c.prod_id = b.cart_prod
            and substr(b.cart_no,1,6) between '200501' and '200506')
    group by a.buyer_id, a.buyer_name
    order by 1;
    
select * from buyer;
select * from cart;
select * from prod;
(subquery);
    select a.buyer_id �ŷ�ó�ڵ�,
            a.buyer_name �ŷ�ó��,
            b.amt �����
        from buyer a,(select buyer_id bid,
                            sum(cart_qty*prod_price) amt
                        from buyer, cart, prod
                        where buyer_id = prod_buyer
                            and prod_id = cart_prod
                            and substr(cart_no, 1, 6) between '200501' and '200506'
                        group by buyer_id) b
        where a.buyer_id=b.bid(+);
        
2005�� 1~6�� �ŷ�ó�� �����-��������
    select buyer_id bid,
    sum(cart_qty*prod_price) amt
    from buyer, cart, prod
    where buyer_id = prod_buyer
    and prod_id = cart_prod
    and substr(cart_no, 1, 6) between '200501' and '200506'
    group by buyer_id;
    
��) 2005�� ��� ��ǰ�� ����/������ ��ȸ�Ͻÿ�
    alice ��ǰ�ڵ�, ��ǰ��, ���Լ���, �������, ���Աݾ�, ����ݾ�
select * from prod;
select * from cart;
select * from buyprod;

select a.prod_id ��ǰ�ڵ�, 
        a.prod_name ��ǰ��, 
        b.bqty ���Լ���, 
        c.cqty �������, 
        b.bamt ���Աݾ�, 
        c.camt ����ݾ�
    from prod a,(select buy_prod bprod,
                        sum(buy_qty) bqty,
                        sum(buy_qty *buy_cost) bamt
                    from buyprod
                    where buy_date between '20050101' and '20051231'
                    group by buy_prod) b, (select cart_prod cprod, 
                                                    sum(cart_qty) cqty,
                                                    sum(cart_qty * prod_price) camt
                                                from cart, prod
                                                where cart_prod = prod_id
                                                and cart_no like '2005%'
                                                group by cart_prod) c
    where a.prod_id = b.bprod(+)
    and a.prod_id = c.cprod(+);

(2005�� ��ǰ�� ��������);
select buy_prod bprod,
        sum(buy_qty) bqty,
        sum(buy_qty *buy_cost) bamt
    from buyprod
    where buy_date between '20050101' and '20051231'
    group by buy_prod;

(2005�� ��ǰ�� ��������);
select cart_prod cprod, 
      sum(cart_qty) cqty,
      sum(cart_qty * prod_price) camt
    from cart, prod
    where cart_prod = prod_id
    and cart_no like '2005%'
    group by cart_prod;
    
select a.prod_id ��ǰ�ڵ�,
        a.prod_name ��ǰ��, 
        c.bqty ���Լ���, 
        b.CART_QTY �������, 
        c.bcost ���Աݾ�, 
        sum(b.cart_qty *a.prod_price) ����ݾ�
    from prod a,cart b,(select buy_qty bqty, 
                          sum(buy_qty * buy_cost) bcost
                         from buyprod
                        group by buy_qty) c
    group by a.prod_id, a.prod_name, c,bqty, b.cart_qty, c.bcost;
                        
    

��) ������̺��� �μ��� ���� ���� �޿��� ��ȸ�ϰ� ���� �� �޿��� �޴��� ��ȸ�Ͻÿ�
    �����ȣ, �����, �μ���ȣ, �μ���, �޿�
;
select * from employees;
select * from departments;
(�������� : ������̺��� �����ȣ, �����, �μ���ȣ, �μ���, �޿� ��ȸ);
select a.employee_id �����ȣ, 
        a.emp_name �����,
        d.did �μ���ȣ, 
        d.dname �μ���, 
        a.salary �޿�
    from employees a, (select b.department_id did, 
                                c.department_name dname, 
                                min(b.salary) msal
                             from employees b, departments c
                            where b.DEPARTMENT_ID = c.department_id
                            group by b.department_id, c.department_name
                            order by 1) d
    where a.department_id = d.did
        and a.salary = d.msal
    order by 3;
(�������� : �μ��� �ּ��ӱ� );
select b.department_id did, 
    c.department_name dname,
    min(b.salary) msal
from employees b, departments c
where b.DEPARTMENT_ID = c.department_id
group by b.department_id, c.department_name
order by 1;

select c.msal
    from employees b, (select department_id did, min(salary) msal
                            from employees a
                            group by department_id) c
    where b.DEPARTMENT_ID = c.did;
    
select department_id, min(salary) 
    from employees
    group by department_id;
    
��)������̺�� �������̺�(jobs)�� ����Ͽ� �� ������ �ּұ޿��� ��ȸ�ϰ�
    �ش� ������ ������ �ִ� ��� �� �ּұ޿��� �޴� ��������� ��ȸ�Ͻÿ�.
    �����ȣ, �����, �����ڵ�, ������, �޿�
    (�������� : �����ȣ, �����, �����ڵ�, ������, �޿�)
    ;
select * from employees;
select * from jobs;

select  a.employee_id �����ȣ,
        a.emp_name �����,
        a.job_id �����ڵ�,
        b.job_title ������,
        a.salary �޿�
    from employees a, jobs b
    where a.job_id = b.job_id
        and (a.job_id, a.salary) in (select job_id ����, min(salary)�����޿�
            --2���� �÷��� 2���� �÷� ��
                                         from employees
                                        group by job_id)
    order by 3;
        
    (�������� : ������ �����޿�(jobs���̺��� min_salary�� �ƴ� �̰� �ʺ���.);
select job_id ����, min(salary)�����޿�
    from employees
    group by job_id;
    

��) ������̺��� �μ����� '��ۺ�'�� ���������� ���������� ����Ͽ� ��ȸ
    �����ȣ, �����, �μ���, �޿�

select * from employees;
select * from departments;

select department_id did, department_name d
    from departments
    where department_name = '��ۺ�'; 
    
----- from���� ����    
select b.employee_id �����ȣ, 
        b.emp_name �����, 
        c.d �μ���, 
        b.salary �޿�
    from  employees b, (select department_id did, department_name d
                                        from departments
                                        where department_name = '��ۺ�') c
    where b.department_id = c.did;

----- where���� ����
select a.department_id �����ȣ, 
        b.emp_name �����, 
        a.DEPARTMENT_NAME �μ���, 
        b.salary �޿�
    from departments a, employees b
    where a.DEPARTMENT_id in (select department_id
                                    from departments
                                    where department_name = '��ۺ�') 
        and a.department_id = b.department_id;




