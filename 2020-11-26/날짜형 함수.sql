2020-11-26-01) ��¥�� �Լ�

1. sysdate
 - �ý����� �����ϴ� �⺻ ��¥��
 - ��, ��, ��, ��, ��, �� ��������
 - '+'�� '-' ������ ���
 
 ��);-- �ϼ� -- ����ϱ�
 select sysdate, sysdate +10, sysdate-200 from dual;
 
 2. add_months(d,n) -- ���� -- ����ϱ�
    - 'd'�� �־��� ��¥���� 'n' ������ ���� ��¥ ��ȯ
��)  ȸ�����̺��� mem_memorial �÷��� �������̶�� �������� ��, ��� ȸ���� ��ȿ�Ⱓ�� 3�����̸�
    ��� ������ ��� �� ��� ��¥ 10������ ���ڵ����͸� �����ϰ��� �Ѵ�.
    �� ȸ���� �������� �������� ���Ͻÿ�.
    alias�� ȸ����ȣ, ȸ����, ������, ������, ����������
    
    select * from member;
    select mem_id ȸ����ȣ, mem_name ȸ����, mem_memorialday ������, 
            add_months(mem_memorialday,3) ������,
            add_months(mem_memorialday,3)-10 ����������
        from member;
    
    select add_months(sysdate,-4) from dual;  
3. next_day(d, char)
    - �־��� ��¥ 'd' ���� ó�� ������ char���� ��¥
    select next_day(sysdate, '��') from dual;
    select next_day(sysdate, '�����') from dual;

4. last_day(d)
    - �־��� ��¥ 'd'�� ���� �ش��ϴ� ���������� ��ȯ
    select last_day(sysdate), last_day('20000210') from dual;

5. months_between(d1, d2)
    - �� ��¥ �ڷ� 'd1'�� 'd2' ������ �������� ��ȯ
    select round(months_between(sysdate, '00010101')) from dual;
    
6. extract(fmt from d)
    - �־��� ��¥������ 'd'���� fmt�� ���ǵ� ���� �����Ͽ� ��ȯ
    - fmt�� year, month, day, hour, minute, second�� �ǹ���
    select extract(month from sysdate) �� from dual;
��) �������̺��� ���� ���������� ��ȸ�Ͻÿ�
    alias�� ��, ���Լ���, ���Աݾ�
    select * from buyprod;
    select extract(month from buy_date) �� , sum(buy_qty) ���Լ���, sum(buy_qty*buy_cost) ���Աݾ�,
            count(*) �Ǽ�
        from buyprod
        where extract(year from buy_date) = 2005
        group by extract(month from buy_date)
        order by 1;
��)�����ܾ����̺�(kor_loan_status)���� 2013�� ������Ȳ�� ��ȸ�Ͻÿ�
    ��, ����, ����, �����ܾ�
    select * from kor_loan_status;
    select substr(period, 5) ��, region ����, gubun ����, loan_jan_amt �����ܾ�
        from kor_loan_status
        where substr(period, 1,4) = 2013
        order by 1,3;
��) ������̺��� 11���� �Ի��� ��������� ��ȸ�Ͻÿ�
    �����ȣ, �����, �μ��ڵ�, �̸���
    select * from employees;
    select employee_id �����ȣ, emp_name �����, department_id �μ��ڵ�, email �̸���, hire_date �Ի���
        from employees
--        where extract(month from hire_date) = 11;
        where extract(month from hire_date) = extract(month from sysdate);        
        
        
        
        
        