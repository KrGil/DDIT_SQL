2020-11-18-02)����Ŭ ������ Ÿ��
 - ����Ŭ���� �����ϴ� ������ Ÿ���� ���ڿ�, ����, ��¥, 2���ڷ����� �ִ�.
 
    1. ���ڿ� ������ Ÿ��
    - ''�� ���� �ڷḦ ���ڿ� �ڷ��� ��
    - CHAR, VARCHAR, VARCHAR2, NVARCHAR, NCHAR, LONG, RAW, CLOB ���� ����
    
    1)CHAR
    . �������� ���ڿ��� ���
    . �ִ� 2000BYTE ���� ����
    . �����Ұ� ������ �����ʿ� ������ ����
    . ���������� ū �����ʹ� ���� ����
    . �ѱ� �� ���ڴ� 3BYTE�� �����
    
    (�������)
    �÷��� char(ũ��[byte|char])
    .'ũ��'[byte|char]
    
    
��)
create table temp01(
    col1 char(20),
    col2 char(20 byte),
    col3 char(20 char)
    );

insert into temp01(col1, col2, col3)
    values('���ѹα�','il postino', '���������� �߱� ���ﵿ 500-1����');

select lengthb(col1), lengthb(col2), lengthb(col3)
    from temp01;
    
select * from temp01;

2)VARCHAR2
    .�������� ���ڿ� ó��
    . �ִ� 4000byte ó�� ����
    . ���ǵ� ���������� �������� ���� ��ŭ ����ϰ� ���� ������ �ý��ۿ� �ݳ�
    . varchar�� ���� ���(����Ŭ�� varchar2 ����� �ǰ�)
    (�������)
    �÷��� varchar2(ũ��[byte|char])
    '[byte|char]' : �����Ǹ� byte�� ���
    
��)

create table temp02(
    col1 varchar2(20),
    col2 varchar2(20 char)
    );

insert into temp02
    values('������','���ѹα���');
    
select * from temp02;

select lengthb(col1), lengthb(col2) from temp02;
    
    