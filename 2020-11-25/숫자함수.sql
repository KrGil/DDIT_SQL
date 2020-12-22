2020-11-25 01) �����Լ�
1. ������ �Լ�
    -abs(n) : n�� ���밪 ��ȯ
    -sign(n) : n�� ��ȣ�� ���� 0�ΰ�� 0, ������ 1, ������� -1�� ��ȯ --������� �������� �Ǻ��ϴ� �Լ�
    -sqrt(n) : n�� ����(root)
    -power(n1, n2) : n1�� n2�� ���� ��ȯ
    
��) ��ǰ���̺��� ��ǰ�� ���Դܰ��� �����ǸŴܰ��� ���Ͽ� ���� ������ ��Ÿ�� �� �ֵ��� ��ȸ�Ͻÿ�
    *���Ϳ��δ� ������ �߻��Ǹ� '����' ������ ������ '�����ǸŻ�ǰ' ���ذ� �߻��Ǹ� '���ó�л�ǰ'�̶�� ����Ͻÿ�.
    
    update prod
        set prod_sale = prod_cost
        where prod_id like 'P101%';
    
    update prod
        set prod_sale = prod_cost
        where prod_id like 'P102%';
    
    select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_cost ���Դܰ�, prod_sale �����ǸŰ�,
            case when sign(prod_sale - prod_cost) = 1 then '������ǰ'
                when sign(prod_sale - prod_cost) = 0 then '�����ǸŻ�ǰ'
            else '���ó�л�ǰ' end ���
        from prod;
    
    **ǥ���� (case when then ~ end)
    - ������ �Ǵ��Ͽ� ó���� ����� �ٸ��� ������ �� ���(IF���� ����� ���)
    - select ������ ���
    (�������)
    case when ����1 then ���1
        when ����2 then ��� 2
            ....
    else ���n end

��)ȸ�����̺��� �ֹι�ȣ�� �̿��Ͽ� ������ �����Ͻÿ�. ��, ���������� �����ϴ� ȸ����ȣ���� ��ȸ�Ͻÿ�
    select * from member;
    select mem_id ȸ����ȣ, mem_name ȸ����, mem_add1||'-'||mem_add2 �ּ�, 
            case when substr(mem_regno2,1,1) ='2' or substr(mem_regno2,1,1) ='4' then '����ȸ��' 
                when substr(mem_regno2,1,1) ='1' or substr(mem_regno2,1,1) ='3' then '����ȸ��'
                else '����' end ����
    from member
    where mem_add1 like '����%';


2. greatest(n1,n2[,n3,...]), least(n1,n2[,n3,...])
    - greatest: �־��� �� n1,n2[,n3,...] �� ���� ū ���� ��ȯ
    - least : �־��� �� n1, n2[,n3,...] �� ���� ���� ���� ��ȯ
    
��) select greatest(20,-15,70), least('������', '������', '������')
     from dual;
    
��) ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ������ ���ϸ����� 1000���� �ο��Ϸ��� �Ѵ�. �̸� �����Ͻÿ�(greatest) ���
     select * from member;
     select mem_id ȸ����ȣ, mem_name ȸ����, mem_mileage ���ϸ���, greatest(mem_mileage, 1000) ���ϸ���1
        from member
        where mem_mileage <=1000;
        
3. round(n[,L]), trunc(n,[,L])
    - round : �־��� �ڷ� n�� L+1��° �ڸ����� �ݿø��Ͽ� L�ڸ����� ǥ��
    - trunc : �־��� �ڷ� n�� L+1��° �ڸ����� �ڸ������Ͽ� L�ڸ����� ǥ��
    - 1�� �����̸� �����κ� 1�ڸ����� �ݿø�(round), �ڸ�����(trunc)
    - 1�� �����ϸ� 0���� ����
    
��)������̺��� �� �μ��� ����ӱ��� ��ȸ�Ͻÿ�
    ����ӱ��� �Ҽ� 2�ڸ����� ����Ͻÿ�
    select * from employees; 
    
    alter table
    modify emp_name varchar2(80);
    
    update employees
        set emp_name=trim(emp_name);
        
    select a.department_id �μ��ڵ�, b.department_name �μ���,
            to_char((round(avg(a.salary),2)),'99,999.99') ����ӱ�
        from employees a, departments b
        where a.department_id = b.department_id
        group by a.department_id, b.department_name
        order by 1;
        
��) ������̺��� �̿��Ͽ� ������� �̹��� �޿��� �����Ϸ��Ѵ�.
    ���޾��� ���ʽ�+�޿�-�����̰� ���ʽ��� ��������(commission_pct)*�޿��̴�.
    �� ������ ���ʽ�+�޿��� 3%�̴�. �Ҽ� ù�ڸ����� ��Ÿ���ÿ�.;
    select * from employees;
    
    select employee_id �����ȣ, emp_name �����, department_id �μ��ڵ�, 
           salary �޿�, 
           nvl(commission_pct*salary,0) ���ʽ�, 
           to_char(trunc(((salary +nvl(salary*commission_pct,0))*0.03),1),'99,999.9') ����, 
           to_char(trunc((salary+nvl(salary*commission_pct,0)-((salary +nvl(salary*commission_pct,0))*0.03)),1),'99,999.9' )���޾�
        from employees;


    
    