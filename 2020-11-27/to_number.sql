2020-11-27-01)
1. to_number(c[,fmt])
 - ������������ ������ ���ڿ��� ���������� ��ȯ
 - ���Ǵ� fmt�� to_char���� ����ϴ� �������� ���ڿ��� ����
 ��) ������ 2005�� 7�� 28���̰� 'h001'ȸ���� ��ǰ'P201000003'�� 3�� �������� ��
    cart���̺� �ش� ������ �����Ͻÿ�.
    
    cart_no : �����+����(5�ڸ���)
            => '20050728';
             select '20050728'||trim(to_char(to_number(max(substr(cart_no, 9)))+1,'00000'))
                from cart
                where cart_no like '20050728%';
        
   insert into cart
            select 'g001', '20050728'||trim(to_char(to_number(max(substr(cart_no, 9)))+1,'00000')),
                    'P202000009',
                    13
                from cart
                where cart_no like '20050728%';
��) ������̺��� ��ȭ��ȣ�� ���ڷ� ��ȯ
    select emp_name, to_number(replace(phone_number,'.'))
        from employees;
    
    select emp_name, to_number(replace(to_char(hire_date),'/'))
        from employees;
        
4.to_date(c[,fmt])
 - ��¥������ ���ڿ��� ��¥Ÿ������ ��ȯ
 - �����������ڿ��� to_char�� �������� ���ڿ��� ����
 
 ��) 2005�� 6�� 13�� �Ǹ��Ϻ��� �ۼ��Ͻÿ�.
    ��¥, ��ǰ�ڵ�, �Ǹż���, ������
    ��¥, ��ǰ�ڵ�, �Ǹż���, ������
    select * from cart;
    select to_date(substr(cart_no, 0, 8), 'YYYY-MM-DD') ��¥, 
            cart_prod ��ǰ�ڵ�, 
            cart_qty �Ǹż���,
            cart_member ������
        from cart
        where substr(cart_no, 0,8) = '20050613'
        order by 3;
        