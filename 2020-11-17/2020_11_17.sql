2020-11-17-01) SQL (structured query )

- 오라클 데이터베이스의 기본 객체인 테이블 생성
- create table 명령 제공
(사용형식)
create table 테이블명(
    컬럼명1 타입명[(크기[BYTE|CHAR])] [Not Null] [default 값],
    컬럼명2 타입명[(크기[BYTE|CHAR])] [Not Null] [default 값],
    
    컬럼명n 타입명[(크기[BYTE|CHAR])] [Not Null] [default 값],
    [Constraint 기본키설정명 primary key(칼럼명1[,컬럼명2,...]),]
    [Constraint 외래키설정명 primary key(칼럼명1[,컬럼명2,...])
        references 테이블명(컬럼명1[,컬렴명2,...])];
    기본키설정명 : 해당테이블 스페이스에서 유일한 명칭이어야 함
    외래키설정명 : 해당테이블 스페이스에서 유일한 명칭이어야 함.
    '테이블명(컬럼명1)' : 외래키가 참조하는 원본 테이블 이름이고,
        '(컬럼명1)'은 원본테이블에서 사용
    
    
    예) 한국건설 물리 erd를 기초로 테이블을 생성하시오.
    (1) EMP 테이블 생성
    create table EMP(
        emp_id char(5), 
        emp_name varchar2(30) not null,
        addr varchar2(80),
        tel_no varchar2(20),
        job_grade varchar2(50),
        dept_name varchar2(50),
        
        constraint pk_emp primary key(emp_id)
    );
    (2)site 테이블 생성
    create table site(
        site_no char(8), --기본키
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
    
    (3) MATERIALS 테이블 생성
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
    site의 input_per 디폴트 0 주기
    alter table site
    modify(input_per number(4) default 0);
    
    (4)WORK 테이블 생성
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

