2020-11-18-01) insert ��
 - ���̺� �ڷḦ ������ �� ���
 (�������) 
 insert into ���̺��([�÷���1, �÷���2,...)]
    values(��1,��2,...);
    .'�÷���1, �÷���2,...' : �� ������ �� ����
        �����ϴ� ��� ���̺� �����ϴ� ��� �÷��� ������ ���� �� ������ Ÿ�Կ�
        �°� �ڷḦ values���� ����ؾ���
    .'�÷���1, �÷���2,...'�� ����ϴ� ���� ���õ� �÷����� �ڷ㸦 �����ϰ���
        �ϴ� ��� ����ϸ�, values���� ����� ���� �÷����� 1:1�� ���� �Ǿ�� ��
    .'�÷���1, �÷���2,...' ����� not null �÷��� ���� �� �� ����.
    
��)���� �ڷḦ emp���̺� �����Ͻÿ�.
[�ڷ�]
��� id : c1001
����� : ȫ�浿
�ּ� : ������ �߱� ���ﵿ 500
�μ��� : �ѹ���ȹ��

��� id : c1002
����� : ������
�ּ� : ����� ���ϱ� �������� 300-10
��å : ����
�μ��� : IT ���ߺ�

��� id : c1005
����� : �̹���
�ּ� : ������ ����� ���� 100
��ȭ��ȣ : 010-1234-5678
��å : ����
�μ��� : �ڱݺ�

insert into emp(emp_id, emp_name, addr, dept_name) 
    values ('c1001', 'ȫ�浿', '������ �߱� ���ﵿ500', '�ѹ���ȹ��');
insert into emp
    values ('c1002', '������', '����� ���ϱ� �������� 300-10', null, '����', 'IT ���ߺ�'); --null or ''
insert into emp
    values ('c1005', '�̹���', '������ ����� ���� 100', '010-1234-5678', '����', '�ڱݺ�');

delete emp;
rollback;
select * from emp;
commit;

2. update ��
- ����Ǿ� �ִ� �ڷ�(�÷��� ��)�� ������ �� ���
(�������)
update ���̺��
    set �÷��� = �� [,�÷��� = ��,...]
    [where ����];    --primary key�� ã�°� ����!
    .'�÷���' : ������ �ڷ��� �÷���
    .'where'���� �����Ǹ� ��� �ڷ��� �ش� �÷� ���� ���� 
    
��)'ȫ�浿' ����� ��ȭ��ȣ�� '042-222-8282'�� �����Ͻÿ�.
update emp 
    set tel_no = '042-222-8282'
    where emp_id = 'c1001';

��)'������' ����� ��ȭ��ȣ�� '010-9876-1234'��, ������ '����'���� �����Ͻÿ�.
update emp
    set tel_no = '010-9876-1234', job_grade = '����'
    where emp_name = '������';

commit;
select * from emp;
rollback;
select emp_name, emp_id from emp;


����] ���� ���ǿ� �µ��� work���̺� � �ڷḦ ����.
    [ó������]
    �����ȣ  'c1001'�� ȫ�浿 ����� ���� ��¥�� 'dae00001'����忡
    �߷� �޾� �����.
    'dae00001'������� '���� ����� �������'���� ���ú��� ���簡
    ���õǰ� 2021�� 6�� 30�Ͽ� �ϰ��� ��ǥ�� �ϴ� ������̴�.

select * from site;
insert into work 
    values ('c1001', 'dae00001', sysdate);

insert into site (SITE_NO, SITE_NAME, p_com_date)
    values ('dae00001','���� ����� �������', '20210630');

delete emp                          -- ��������-> �����ܾ�������.
    where emp_name = 'ȫ�浿'; 

delete table emp;                   -- ��������-> �����ܾ�������.

3. delete ��
    - ���̺� ����� �ڷḦ ������ �� ���
    - ���谡 ������ ���̺��� �θ����̺��� �� �� �����ǰ� �ִ� �ڷ�� ���� ����
    (�������)
    -rollback�� ���
    
delete ���̺��
[where ����];
delete work;
delete emp;

rollback;
select * from work;
select * from emp;
select * from site;
drop table emp;

4. drop ��
    - ����Ŭ ��ü�� ����
    - rollback�� ����� �ƴ�
    (�������)
    
drop ��üŸ�� ��ü��;

��)emp ���̺�� work ���̺� ���̿� �����ϴ°��踦 �����Ͻÿ�.
alter table work
    drop constraint fk_work_emp;

alter table work
    drop constraint fk_work_site;
    
drop table emp;
drop table site; -- materials�� �ڽ����̺��̴�.
drop table materials;
drop table site;
drop table work; 


