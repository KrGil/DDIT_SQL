2020-11-26-02) ����ȯ �Լ�
1. CAST(expr as Ÿ��[(ũ��)])
    - 'expr'�� �����Ǵ� �ڷḦ 'Ÿ��[(ũ��)]'    
    
select * from lprod;
��) �з����̺��� lprod_id �÷��� ������ Ÿ���� number(7)����
    char(10)���� ���� ����Ͻÿ�
    
    select cast(lprod_id as char(10)) ����,
            lprod_gu �з��ڵ�,
            lprod_nm �з���
        from lprod;
        
    ��) ������̺��� �μ��ڵ� 50�� ���� ������� �ټӳ���� ��ȸ�Ͻÿ�.
    �����ȣ, �����, �Ի���, �ټӳ���̸�, �ټӳ���� 'xx��' ������ ���ڿ��� ��ȯ ����Ͻÿ�.
    select employee_id �����ȣ, emp_name �����, hire_date �Ի���, 
            cast((extract(year from sysdate)-extract(year from hire_date)) as char(2))||'��' �ټӳ��,
            (extract(year from sysdate)-extract(year from hire_date))||'��' �ټӳ��
        from employees
        where department_id =50;

2.to_char(c) : char, clob Ÿ���� �ڷ� 'c'�� varchar2 Ÿ���� ���ڿ��� ��ȯ
    to_char(d[,fmt]) : ��¥�ڷ� d�� fmt �������� ���ڿ��� ��ȯ
    to_char(n[,fnt]) : �����ڷ� 'n'�� fmt ������ ���ڿ��� ��ȯ
        
    -�������� �������ڿ�
    ------------------------------------------------------------------
    ���� ���ڿ�                  �ǹ�              ��� ��
    ------------------------------------------------------------------
    AD, BC, CC             ���⸦ ���          To_char(sysdate, 'CC')
        ex) select to_char(sysdate, 'cc'),
                    to_char(sysdate, 'ad'),
                    to_char(sysdate, 'bc')
                from dual;
    YYYY,YYY,YY,Y           �⵵�� ���          To_char(sysdate, 'YY')
        ex) select to_char(sysdate, 'YYYY'),
                    to_char(sysdate, 'YYY'),
                    to_char(sysdate, 'YY'),
                    to_char(sysdate, 'Y')
                from dual;
    Q                       �б�               To_char(sysdate, 'YY Q')
        ex) select to_char(sysdate,'MM"����" Q"�б�"') from dual;
    Month, mon, MM RM       ��                 To_char(sysdate, 'YYYY-MM')
        ex) select to_char(sysdate, 'YYYY-MM'),
                    to_char(sysdate, 'YYYY-RM'),
                    to_char(sysdate, 'YYYY-MON'),
                    to_char(sysdate, 'YYYY-MONTH')
                from dual;
    W,WW,IW                 ����
         ex) select to_char(sysdate,'W'),
                    to_char(sysdate,'WW'),
                    to_char(sysdate,'IW')
                from dual;
    
    D, DD, DDD, J           ��
        D : �ش����� ���� �ֿ��� ����� �ϼ�
        DD : �ش����� ���� ������ ����� �ϼ�
        DDD : �ش����� ���� �⿡�� ����� �ϼ�
        J : ����� 4712�� ���� ����� �ϼ�
        ex) 
        select to_char(sysdate,'d'), to_char(sysdate,'dd'), to_char(sysdate,'ddd'), 
                    to_char(sysdate,'j') from dual; 
        
    DAY, DY                 ���� ����
        ex) 
        select to_char(sysdate, 'day'), to_char(sysdate, 'dy') from dual;
    HH, HH24, HH12          �ð� (HH�� HH12�� ���� ����)
    AM, PM, A.M, P.M        ����, ���� ǥ��
    MI                      ��
    SS, SSSSS               ��('SSSSS' : �������� ����� �ð��� �ʷ� ��ȯ)
    ��Ÿ                     ����ڰ� ���Ƿ� ���� ���ڿ��� "   "�ȿ� ���
    -----------------------------------------------------------------
    select to_char(mem_bir),
        to_char(mem_bir, 'YYYY-MM-DD day')
        from member;
    
    -�������� �������ڿ�
    ------------------------------------------------------------------
    ���Ĺ��ڿ�                 �ǹ�
    ------------------------------------------------------------------
    9                   �����Ǵ� ��ġ�� ���� ��ȿ�� ���̶�� �����͸� ����ϰ� ��ȿ�� 0�� ����ó��
    
    0                   �����Ǵ� ��ġ�� ���� ��ȿ�� ���̶�� �����͸� ����ϰ� ��ȿ�� 0�� ���
    
    $, L                ȭ���ȣ�� ���
    
    MI                  ���� ����� ��� ������ '-' ��ȣ ���
    
    pr                  ���� ����� ��� '-' ��ȣ '< >'�ȿ� ���
    
    ,(�޸�), .(�Ҽ���)
    
    ------------------------------------------------------------------
    
    000890000
    999,999,999.99 --9 ���
    000,000,000.00 --0 ���
    --------------
        890,000.00 --9 ���
    000,890,000.00 --0 ���
    
    
    ��) 2005�� 2�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
        ��ǰ�ڵ�, ���Լ���, ���Աݾ�
    select buy_prod ��ǰ�ڵ�, 
            to_char(sum(buy_qty),'999') ���Լ���, 
            to_char(sum(buy_qty*buy_cost),'L99,999,999') ���Աݾ�
        from buyprod
        where buy_date between '20050201' and last_day('20050201')
        group by buy_prod
        order by 3;
    