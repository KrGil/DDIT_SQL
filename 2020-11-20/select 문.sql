2020-11-20-01)�����ڿ� �Լ�
select ��
 - �����͸� ��ȸ�ϴ� ���
 - SQL ��� �� ���� ���� ���Ǵ� ���
 (�������)
 select [distinct]|*|�÷��� [AS]["]�÷���Ī["],
        �÷��� [AS]["]�÷���Ī["],
        ..
        �÷��� [AS]["]�÷���Ī["]
    from ���̺��
    [where ����]
    [group by �÷���[,�÷���,...]] --~~��
[having ����] -- 
    [order by �÷���|�÷��ε���[asc|desc][,�÷���|�÷��ε���[asc|desc],...]; -- 2 ������ select�� ���� 2��° �÷��� ������������.

.'[distinct]' : �ߺ��� �ڷḦ ������ �� ���
. '�÷���Ī' : �÷��� �ο��� �� �ٸ� �̸�
    - �÷��� as ��Ī
    - �÷���   ��Ī
    - �÷��� "��Ī" : ��Ī�� Ư������(��������)�� ���Ե� ��� �ݵ�� ""�� ���� ���
    - '�÷��ε���' : select ������ ����� �ش� �÷��� ����(1���� counting)
    - 'asc|desc' : ���Ĺ��(asc:������������ �⺻��, desc�� ��������)
    - select���� ���� ���� : form -> where�� ���� -> select��
    
1. ������
    - ���������(+,-,*,/)
    - ���迬����(>,<,>=,<=,=,!=(<>))
    - ��������(and,or,not)

2. �Լ�(function)
    - Ư�� ����� �����Ͽ� �ϳ��� ����� ��ȯ�ϵ��� ����� ���
    - �����ϵǾ� ���� ������ ���·� ����
    - ���ڿ�, ����, ��ȯ, �����Լ��� ���·� ����
    
1)���ڿ� �Լ�
    - ���ڿ� ������ ����� ��ȯ
    ** ���ڿ� ������ '||'
    �ڹ��� ���ڿ� ������ '+'�� ���� �� ���ڿ��� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ
    (�������)
    
��) ȸ�����̺��� ����ȸ������ ������ ��ȸ�Ͻÿ�.
    Alias�� ȸ����ȣ, ȸ����, �ּ�, ���ϸ���
select mem_id ȸ����ȣ, mem_name ȸ����, mem_add1||' '||mem_add2 �ּ�, mem_mileage ���ϸ���
    from member
    where substr(mem_regno2, 1,1)='2' or substr(mem_regno2, 1,1)='4'
    order by 4 desc;
    
    
1)concat(c1, c2)
    - c1�� c2�� �����Ͽ� ����� ��ȯ

    select 'my name is ' || mem_name
        from member;
    select concat('my name is ', mem_name)
        from member;
    
��) ȸ�����̺��� ȸ����ȣ, ȸ����, �ֹι�ȣ�� ��ȸ�Ͻÿ�
    ��, �ֹι�ȣ�� 'xxxxxx-xxxxxxx'�������� ����Ͻÿ�
    select mem_id ȸ����ȣ, mem_name ȸ����, concat(concat(mem_regno1,'-'), mem_regno2) �ֹι�ȣ
        from member;
    select mem_id ȸ����ȣ, mem_name ȸ����, mem_regno1||'-'||mem_regno2 �ֹι�ȣ
        from member;
��)
select 'oracle' ||', '|| 'Modeling' From dual;

��) ȸ�����̺��� ȸ����ȣ, ȸ����, �ֹι�ȣ�� ��ȸ�Ͻÿ�
    ��, �ֹι�ȣ�� 'xxxxxx-xxxxxxx'�������� ����Ͻÿ�
    
select mem_id ȸ����ȣ,
        mem_name ȸ����,
        mem_regno1 || '-' || mem_regno2 �ֹι�ȣ
    from member
    order by 2;
    
    
    
2)initcap
 - �ܾ��� ���ι��ڸ� �빮�ڷ� ���
 - ���� �̸� ��� �� ���
 (�������)
 initcap(c1)
select initcap(job_title)
    from jobs;
commit;    

update employees
    set emp_name = lower(emp_name);
select emp_name 
    from employees;

update employees
    set emp_name = initcap(emp_name);
select emp_name 
    from employees;
rollback;
    
��) ȸ�����̺��� ȸ����ȣ�� ȸ������ ��ȸ�Ͻÿ�.
select mem_id as "ȸ����ȣ",
        mem_name as "ȸ���̸�"
        from member;
        
select mem_id "   ȸ����ȣ",
        mem_name ȸ���̸�
        from member;
    
select * --column(��?)
    from lprod; -- table
       -- where --raw(��?)
select mem_id, mem_name, mem_bir, mem_mileage
    from member
    order by 2;--
select prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_sale * 55 ��ǰ����   
    from prod;
select lprod_id "id", lprod_nm "��ǰ"
    from lprod;
select *
    from lprod
    where lprod_nm = '����ĳ�־�';
    