select * from member;
select * from member where mem_add1 like '%대전%';
create table bankinfo(
    bank_no varchar2(40) not null, -- 계좌번호
    bank_name varchar2(40) not null, -- 은행이름
    bank_user_name varchar2(30) not null, -- 예금주명
    bank_date date not null,            -- 개설 날짜
    constraint pk_bankinfo primary key (bank_no)
);

INSERT INTO bankinfo (bank_no, bank_name, bank_user_name, bank_date)
    VALUES ('123-444-5555', '하나은행', '홍길동', sysdate);
    
select * from bankinfo;


-- "select * from member where mem_id = '" + name + "'";
-- name ==> a001
-- a001' or '1'='1

select * from member where mem_id = 'a001';
select * from member where mem_id = 'a001' or '1'='1';

-- prepareStatement 쓰는 이유! 빠르고 안전하다!
-- "select * from member where mem_id = ?"
-- name ==> a001
-- a001' or '1'='1
select * from member where mem_id = 'a001';
select * from member where mem_id = 'a001'' or ''1''=''1';

select lprod_id 
from (select LPROD_ID from lprod
        order by lprod_id desc)
where rownum = 1;
--위의겉과 같은 결과가 나온다.ㅠㅠ
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
    