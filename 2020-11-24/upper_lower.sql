2020-11-24-01)
3) upper, lower 
    -�־��� ���ڿ��� ���Ե� ���ڸ� �빮��(upper) �Ǵ� �ҹ���(lower)��
    ��ȯ�Ͽ� ��ȯ
    (�������)
    UPPER(c), lower(c)
��)ȸ�����̺��� 'R001'ȸ�� ������ ��ȸ�Ͻÿ�
    select * from member;
    select mem_id ȸ����ȣ, mem_name ȸ����, mem_job ����, mem_mileage ���ϸ���
        from member
        where upper(mem_id) = ('R001');
     -- where mem_id = lower('R001');
��) �з����̺��� 'P200'���� ���� �з��ڵ带 ��ȸ�Ͻÿ�
    select * from lprod;
    select lprod_gu �з��ڵ�, lprod_nm �з���
        from lprod
        where upper(lprod_gu) like 'P20%';
        
        
4) ascii, chr
    - ascii : �־��� �����ڷḦ ascii �ڵ尪���� ��ȯ
    - chr : �־��� ����(����, 1~65535)�� �����ϴ� ���� ��ȯ
��)
    select ascii('Oracle'),
            ascii('���ѹα�'),
            chr(95)
        from dual;
        
        
5) lpad, rpad
    - Ư�����ڿ�(����)�� ������ �� ���
    (�������)
    lpad(c, n [,pattern]), rpad(c, n [,pattern])
    - �־��� ���ڿ� 'c'�� ���� 'n'�� �������� ���ʺ��� ä���(rpad) |
        �����ʺ��� ä���(lpad) ���� ������ 'parttern'���� ���ǵ� ���ڿ��� ä��
    - 'pattern'�� �����Ǹ� �������� ä����.
��)ȸ�����̺��� ȸ���� ��ȣ�� 10 �ڸ������� ���������ϰ� ���� ������ '#'�� �����Ͻÿ�
    select * from member;
    select mem_id ȸ����ȣ,
            mem_name ȸ����,
            mem_pass ��ȣ, 
            lpad(mem_pass, 10, '#') ��ȣ2
        from member;
��) �������̺��� 2005�� 2�� ������Ȳ�� ��ȸ�Ͻÿ�. ��, ���Դܰ��� 9�ڸ��� ����ϵ� ���� ���� ������ '*'�� �����Ͽ� ���
    select * from buyprod;
    select buy_date ��¥, buy_prod ���Ի�ǰ�ڵ�, buy_qty ����,
            lpad(buy_cost,9,'*') �ܰ�
        from buyprod
--        where extract(year from buy_date) = 2005 and extract(month from buy_date) = 2;
        where buy_date between '20050201' and '20050228';
        
        
6) ltrim, rtrim, trim
    - �־��� ���ڿ����� ����(ltrim) �Ǵ� ������(rtrim)�� �����ϴ� ���ڿ���
        ã�� ������ �� ���
    - ���ʿ� �����ϴ� ������ �����Ҷ��� trim ���
    (�������)
    ltrim(c1 [, c2]), rtrim(c1 [, c2]), trim(c1)
    -c2�� �����Ǹ� ������ ����

��) ������̺��� ����� �÷��� ������ Ÿ���� char(80) ���� �����Ͻÿ�
alter table employees
    modify emp_name char(80);
��) ������̺��� 'Steven King' ��������� ��ȸ�Ͻÿ�
    select * from employees;
    select employee_id �����ȣ, trim(emp_name) �����, department_id �μ��ڵ�, hire_date �Ի���
        from employees
        where trim(emp_name)='Steven King';
��) ��ǰ���̺��� '���'�� �����ϴ� ��ǰ���� '���'�� �����ϰ� ����Ͻÿ�
    select * from prod;
    select prod_id ��ǰ�ڵ�, prod_name ��ǰ��1, ltrim(prod_name, '��� ') ��ǰ��2, prod_lgu �з��ڵ�, prod_buyer �ŷ�ó�ڵ�
        from prod
        where prod_name like '���%';


7) substr(c, n1[, n2])
    - �־��� ���ڿ����� n1���� �����Ͽ� n2(����)��ŭ(�� ���ڰ���)�� �κ� ���ڿ��� �����Ͽ� ��ȯ
    - n2�� �����Ǹ� n1 ������ ��� ���ڿ��� �����Ͽ� ��ȯ
    - n1�� �����̸� �ڿ��� ���� ó����
    - n1�� 1���� counting

��)
    select substr('IL postino', 3,4),
            substr('ILpostino', 3,4),
            substr('IL postino', 3),
            substr('IL postino', -3,2)
        from dual;
��) ��ǰ���̺��� �з��ڵ�'P201'�� ���� ��ǰ�� �������� ����Ͻÿ�
    select * from prod;
    select count(*) "��ǰ�� ��"
        from prod
        where upper(substr(prod_id, 1, 4)) = 'P201';
��) ��ٱ������̺��� 2005�� 3���� �Ǹŵ� ��ǰ������ ��ǰ���� ����Ͻÿ�
    select *from cart;
    select a.cart_prod ��ǰ�ڵ�,
            b.prod_name ��ǰ��,
            nvl(sum(a.cart_qty),0) �����հ�,
            nvl(sum(a.cart_qty* b.prod_price),0) �Ǹűݾ�
        from cart a, prod b
        where substr(cart_no,1,6) = '200507' -- cart_no like '200503%'
            and a.cart_prod = b.prod_id
        group by a.cart_prod, b.prod_name
        order by 1;
����) ȸ�����̺��� '����'�� ����ִ� ȸ�������� ��ȸ�Ͻÿ� ��, like�����ڸ� ������� ����
    select * from member;
    select mem_id ȸ����ȣ, mem_name ȸ����, mem_add1 || '-' || mem_add2 �ּ�, mem_job ����, mem_mileage ���ϸ���
        from member
        where substr(mem_add1, 1, 2) = '����';
        
����) ������ 2005�� 7�� 28���̶�� �����ϰ� cart_no�� �ڵ����� �����ϴ� �ڵ带 �ۼ��Ͻÿ�.
--    1. 2005�� 7�� 28�� �ִ� ���� max
        select to_number(max(substr(cart_no,9))+1)
        from cart
        where substr(cart_no,1,8)= '20050728';
--    2. ��¥�� 1������ ���� ������ ����
        select to_char(sysdate,'YYYYMMDD')||
                trim(to_char(to_number(max(substr(cart_no,9))+1),'00000'))
            from cart
            where substr(cart_no,1,8)='20050728';
    
    select max(cart_no)+1
        from cart
        where substr(cart_no,1,8) = '20050728';

����) �з����̺��� '��������' �з��ڵ带 �űԷ� ��Ͻ�ų�� 'P200'������ �ڵ带 �����Ͻÿ�.
    select * from prod;
    --max�Լ� ������ ���� ��ü�� ���� ���� �� ����.
    select 'P'||(max(substr(lprod_gu,2))+1)
        from lprod
        where lprod_gu like 'P2%';
        
8) replace(c1, c2[, c3]) -- 'sad    adfas' ���� ���� ���ٶ�
    - �־��� ���ڿ� c1���� c2�� c3�� ��ġ(ġȯ) ��Ŵ
    - c3�� �����Ǹ� c2�� ������
    
��)��ǰ���̺��� ��ǰ�� �� '���'�� ã�� 'Apple'�� �����Ͻÿ�
    select * from prod;
    select prod_name ��ǰ��,replace(prod_name, '���', 'Apple') ����Ȼ�ǰ��
        from prod
        where prod_name like '%���%';

    select prod_id,
            prod_name,
        replace(prod_name,' ')
        from prod
        where prod_name like '%���%';

9) length(c), lengthb(c)
    - �־��� ���ڿ����� ���ڼ�(length) �Ǵ� �������� ũ��(byte��, lengthb)�� ��ȯ
    
    
    
    
    
    
    
    
        