select * from member;
select * from member where mem_add1 like '%����%';
create table bankinfo(
    bank_no varchar2(40) not null, -- ���¹�ȣ
    bank_name varchar2(40) not null, -- �����̸�
    bank_user_name varchar2(30) not null, -- �����ָ�
    bank_date date not null,            -- ���� ��¥
    constraint pk_bankinfo primary key (bank_no)
);

INSERT INTO bankinfo (bank_no, bank_name, bank_user_name, bank_date)
    VALUES ('123-444-5555', '�ϳ�����', 'ȫ�浿', sysdate);
    
select * from bankinfo;


-- "select * from member where mem_id = '" + name + "'";
-- name ==> a001
-- a001' or '1'='1

select * from member where mem_id = 'a001';
select * from member where mem_id = 'a001' or '1'='1';

-- prepareStatement ���� ����! ������ �����ϴ�!
-- "select * from member where mem_id = ?"
-- name ==> a001
-- a001' or '1'='1
select * from member where mem_id = 'a001';
select * from member where mem_id = 'a001'' or ''1''=''1';

select lprod_id 
from (select LPROD_ID from lprod
        order by lprod_id desc)
where rownum = 1;
--���ǰѰ� ���� ����� ���´�.�Ф�
select max(lprod_id) from lprod;

select lprod_gu 
from lprod
where lprod_gu = 'P502';

SELECT * FROM LPROD;
commit;

create table mymember(
    mem_id varchar2(15) not null,
    mem_name varchar2(30) not null,
    mem_tel varchar2(14) not null,
    mem_addr varchar2(90) not null,
    constraint pk_mymember primary key (mem_id)
);
    