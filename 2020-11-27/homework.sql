2020-11-27 -- ����

2005�� ��ݱ�(1-6��) �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�
    �ŷ�ó�ڵ�, �ŷ�ó��, ���Լ���, ���Աݾ�
select * from buyer; -- ���⿡ �ŷ�ó�� c.buyer_lgu
select * from buyprod; --���⿡ ���Աݾ� ���Լ��� 
select buyer_lgu �ŷ�ó�ڵ�, buyer_name �ŷ�ó�� -- sum(b.buy_qty) ���Լ���, sum(b.buy_cost) ���Աݾ�
    from buyer;--, b.buyprod
   -- where a.buyer_lgu = substr(b.prod_buyer,1,4);

select substr(buy_prod,1,4) buy_id,
        sum(buy_qty) t_qty,
        sum(buy_cost) t_cost
    from buyprod
    group by substr(buy_prod,1,4);

select a.buyer_lgu �ŷ�ó�ڵ�, 
        a.buyer_name �ŷ�ó��, 
        c.t_qty ���Լ���, 
        c.t_cost ���Աݾ�-- sum(b.buy_qty) ���Լ���, sum(b.buy_cost) ���Աݾ�
    from buyer a, (select substr(buy_prod,1,4) buy_id, buy_date daa,
                        sum(buy_qty) t_qty, 
                        sum(buy_cost) t_cost
                    from buyprod
                    group by substr(buy_prod,1,4),  buy_date) c
    where a.buyer_lgu = c.buy_id
        and extract(year from c.daa) = 2005
        and extract(month from c.daa) between 01 and 06
    order by 1;
    
��) ������̺��� �̿��Ͽ� �μ��� �޿��հ踦 ���Ͻÿ�
    �μ��ڵ�, �μ���, �޿��հ�
    select A.department_id as �μ��ڵ�,
            B.department_name as �μ���,
            sum(a.salary) as �޿��հ�
        from employees a, departments b
        where a.department_id = b.department_id
        group by a.department_id, b.department_name;