2020-11-19-01)
3) long ������ Ÿ��
- �������� ���ڿ��� ����
- �ִ� 2gb ���� ���尡��
- longŸ���� �ϳ��� ���̺��� 1���� ��� ����
- clob�� ��ü(��� ���׷��̵� �ߴ�)
- select���� select��, update���� set��, insert���� values������ ��� ����
(�������)
�÷��� long

��)
create table temp03(
    col1 long,
    col2 varchar2(2000)
    );
insert into temp03 values('sadaf','asdfad');
select * from temp03;
select substr(col2, 2,5) from temp03;

4) clob(character large object) ������ Ÿ��
    - ��뷮 ���ڿ� �ڷḦ ó���ϱ� ���� ������ Ÿ��
    - �ִ� 4gb���� ó�� ����
    - �������� ���� �ڷ���
    - �� ���̺��� ���� �� �ִ� clob�� ������ ������ ����
    - �Ϻ� ��� ���� dbms_lob api�� ������ �޾ƾ� ��
    (�������)

create table temp04(
    col1 clob,
    col2 clob,
    col3 clob
    );
insert into temp04
    values('���ѹα��� ���� ��ȭ���̴�', '������ �߱� ���ﵿ 500 ���κ��� 3��',
            'Oracle Modling�� SQL'
    );
select * from temp04;

select lengthb(col2) from temp04;

select DBMS_LOB.SUBSTR(col1,5,3), --3��°���� 5���� �����. �����ʿ��� �о����
        DBMS_LOB.GETLENGTH(col2),
        length(col3)
    from temp04;
    
update temp04
    set col3 = 'Oracle Modeling�� SQL'
    
5) nclob, nvarchar2
    - �ٱ��� ���� ���·� ���� �ڷ�����
    - UTF-8, UTF-16 ������ encodding 
    - ������ ����� clob, varchar2�� ����

2. �����ڷ���
    - ������ �Ǽ� ������ ����
    - number Ÿ�� ����
    (�������)
    number[(���е�)*[,������])]
    - ǥ���� �� �ִ� ���� ���� : 1.0e-130 ~ 9.999..9e125
    - ���е� : ��ü �ڸ���(1~38)
    - ������ : �Ҽ��������� �ڸ���
    ex)number(5,2) : ��ü 5�ڸ��� Ȯ��(���� �κ� 3�ڸ�, �Ҽ������� 3�ڸ�����
        �ݿø��Ͽ� 2��° �ڸ����� ǥ��)
    - ���е� ��� '*'�� ����ϸ� 38�ڸ� �̳����� �ڵ��Ҵ�
    ex)number(*,2) : �Ҽ������� 3�ڸ����� �ݿø��Ͽ� 2��° �ڸ����� ǥ��, ��, �����κ���
    38�ڸ� �̳����� ũ�⸸ŭ �ڵ� �Ҵ�
    -�������� �����Ǹ� 0���� ����
    
��)
�Է°�                     ����                  ����� ��
12345678.7896           number              12345678.7896
12345678.7896           number(*,2)         12345678.79
12345678.7896           number(8)           12345679
12345678.7896           number(7,2)         ����
12345678.7896           number(10,-2)       12345700

    **���е� < ������ �� ��� --������ 0�̰� �Ҽ��� �ִ� ���. 0.12312312
    - ���е��� 0�� �ƴ� ��ȿ������ ��
    - (������-���е�) : �Ҽ������Ͽ� �����ؾ��� 0�� ����
    - ������ : �Ҽ��� ������ �������� ��
    
�Է°�                     ����                  ����� ��
1.234                   number(4,5)         ����
0.23                    number(3,5)         ����
0.0123                  number(3,4)         0.0123
0.0012345               number(3,5)         0.00123
0.00125676              number(3,5)         0.00126

3. ��¥�ڷ���
    - ��¥�ڷ�(��,��,��,��,��)�� �����ϱ� ���� ������ Ÿ��
    - �⺻���� date, �ð���(timezone)������ 10����� 1�ʴ����� �ð�������
    - �����ϴ� ������ Ÿ������ timestamp�� ����
    1)date Ÿ��
    - �⺻ ��¥��
    - '+', '-' ������ ���
    **sysdate : �ý����� �����ϴ� ��¥������ �����ϴ� �Լ�
    (�������)
    �÷��� date

��)
create table temp05(
    col1 date,
    col2 date,
    col3 date
    );
insert into temp05
    values(sysdate, '20101029', sysdate+30);
select * from temp05;
select col1 - 10 from temp05;

select mod(to_date('20100101')-to_date('00010101')-1,7) from dual;

select * from temp05;
select to_char(col1,'YYYY"��" MM"��" DD"��" AM HH24:MI:SS') from temp05;

2)timestamp Ÿ��
    - �ð��� ������ ������ �ð������� �ʿ��� �� ���
    (�������)
    �÷��� timestamp - �ð��� ���� ����
    �÷��� timestamp with time zone - �ð�������(�����/���ø�) ����
    �÷��� timestamp with local time zone 
            - ������ ��ġ�� �ð�������, ���� timestamp�� ����
��)
create table temp06(
    col1 date,
    col2 timestamp,
    col3 timestamp with time zone,
    col4 timestamp with local time zone
    );
insert into temp06
    values(sysdate,sysdate,sysdate,sysdate);
select*from temp06;
    
