2020-11-17-01) SQL (structured query )

- ����Ŭ �����ͺ��̽��� �⺻ ��ü�� ���̺� ����
- create table ��� ����
(�������)
create table ���̺��(
    �÷���1 Ÿ�Ը�[(ũ��[BYTE|CHAR])] [Not Null] [default ��],
    �÷���2 Ÿ�Ը�[(ũ��[BYTE|CHAR])] [Not Null] [default ��],
    
    �÷���n Ÿ�Ը�[(ũ��[BYTE|CHAR])] [Not Null] [default ��],
    [Constraint �⺻Ű������ primary key(Į����1[,�÷���2,...]),]
    [Constraint �ܷ�Ű������ primary key(Į����1[,�÷���2,...])
        references ���̺��(�÷���1[,�÷Ÿ�2,...])];
    �⺻Ű������ : �ش����̺� �����̽����� ������ ��Ī�̾�� ��
    �ܷ�Ű������ : �ش����̺� �����̽����� ������ ��Ī�̾�� ��.
    '���̺��(�÷���1)' : �ܷ�Ű�� �����ϴ� ���� ���̺� �̸��̰�,
        '(�÷���1)'�� �������̺��� ���
    
    
    ��) �ѱ��Ǽ� ���� erd�� ���ʷ� ���̺��� �����Ͻÿ�.
    (1) EMP ���̺� ����
    create table EMP(
        emp_id char(5), 
        emp_name varchar2(30) not null,
        addr varchar2(80),
        tel_no varchar2(20),
        job_grade varchar2(50),
        dept_name varchar2(50),
        
        constraint pk_emp primary key(emp_id)
    );
    (2)site ���̺� ����
    create table site(
        site_no char(8), --�⺻Ű
        site_name varchar2(50) not null,
        site_tel_no varchar2(20),
        cons_amt number(12) default 0,
        input_per number(4),
        start_date date default sysdate,
        p_com_date date,
        com_date date,
        remarks varchar2(100),
        
        constraint pk_site primary key(site_no)
    );
    
    (3) MATERIALS ���̺� ����
    create table materials(
        mat_id char(10),
        mat_name varchar2(50) not null,
        mat_qty number(4) default 0,
        mat_price number(8) default 0,
        pur_date date,
        site_no char(8),
        
        constraint pk_materials primary key(mat_id),
        constraint fk_mat_site foreign key(site_no)
            references site(site_no)
    );
    site�� input_per ����Ʈ 0 �ֱ�
    alter table site
    modify(input_per number(4) default 0);
    
    (4)WORK ���̺� ����
    create table work(
        emp_id char(5),
        site_no char(8),
        wst_date date,
        
        constraint pk_work primary key(emp_id, site_no),
        constraint fk_work_emp foreign key(emp_id)
            references emp(emp_id),
        constraint fk_work_site foreign key(site_no)
            references site(site_no)
    );
)
commit;
select to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') from dual;

