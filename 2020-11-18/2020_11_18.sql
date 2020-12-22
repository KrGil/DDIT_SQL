2020-11-18-01) insert 문
 - 테이블에 자료를 삽입할 때 사용
 (사용형식) 
 insert into 테이블명([컬럼명1, 컬럼명2,...)]
    values(값1,값2,...);
    .'컬럼명1, 컬럼명2,...' : 은 생략할 수 있음
        생략하는 경우 테이블에 존재하는 모든 컬럼의 갯수와 순서 및 데이터 타입에
        맞게 자료를 values절에 기술해야함
    .'컬럼명1, 컬럼명2,...'을 사용하는 경우는 선택된 컬럼ㅁ에 자룔를 삽입하고자
        하는 경우 기술하며, values절에 기술된 값과 컬럼명은 1:1로 대응 되어야 함
    .'컬럼명1, 컬럼명2,...' 기술시 not null 컬럼은 생략 될 수 없음.
    
예)다음 자료를 emp테이블에 저장하시오.
[자료]
사원 id : c1001
사원명 : 홍길동
주소 : 대전시 중구 대흥동 500
부서명 : 총무기획부

사원 id : c1002
사원명 : 강감찬
주소 : 서울시 성북구 신장위동 300-10
직책 : 부장
부서명 : IT 개발부

사원 id : c1005
사원명 : 이민정
주소 : 대전시 대덕구 법동 100
전화번호 : 010-1234-5678
직책 : 과장
부서명 : 자금부

insert into emp(emp_id, emp_name, addr, dept_name) 
    values ('c1001', '홍길동', '대전시 중구 대흥동500', '총무기획부');
insert into emp
    values ('c1002', '강감찬', '서울시 성북구 신장위동 300-10', null, '부장', 'IT 개발부'); --null or ''
insert into emp
    values ('c1005', '이민정', '대전시 대덕수 법동 100', '010-1234-5678', '부장', '자금부');

delete emp;
rollback;
select * from emp;
commit;

2. update 문
- 저장되어 있는 자료(컬럼의 값)를 수정할 때 사용
(사용형식)
update 테이블명
    set 컬럼명 = 값 [,컬럼명 = 값,...]
    [where 조건];    --primary key롤 찾는게 좋다!
    .'컬럼명' : 변경할 자료의 컬럼명
    .'where'절이 생략되면 모든 자료의 해당 컬럼 값을 수정 
    
예)'홍길동' 사원의 전화번호를 '042-222-8282'로 수정하시오.
update emp 
    set tel_no = '042-222-8282'
    where emp_id = 'c1001';

예)'강감찬' 사원의 전화번호를 '010-9876-1234'로, 직위를 '차장'으로 수정하시오.
update emp
    set tel_no = '010-9876-1234', job_grade = '차장'
    where emp_name = '강감찬';

commit;
select * from emp;
rollback;
select emp_name, emp_id from emp;


문제] 다음 조건에 맞도록 work테이블 등에 자료를 삼입.
    [처리조건]
    사원번호  'c1001'인 홍길동 사원이 오늘 날짜로 'dae00001'사업장에
    발령 받아 출근함.
    'dae00001'사업장은 '대전 상수도 관리사업'으로 오늘부터 공사가
    개시되고 2021년 6월 30일에 완공을 목표로 하는 사업장이다.

select * from site;
insert into work 
    values ('c1001', 'dae00001', sysdate);

insert into site (SITE_NO, SITE_NAME, p_com_date)
    values ('dae00001','대전 상수도 관리사업', '20210630');

delete emp                          -- 안지워짐-> 끌어당겨쓰고있음.
    where emp_name = '홍길동'; 

delete table emp;                   -- 안지워짐-> 끌어당겨쓰고있음.

3. delete 문
    - 테이블에 저장된 자료를 삭제할 때 사용
    - 관계가 설정된 테이블에서 부모테이블의 행 중 참조되고 있는 자료는 삭제 거절
    (사용형식)
    -rollback의 대상
    
delete 테이블명
[where 조건];
delete work;
delete emp;

rollback;
select * from work;
select * from emp;
select * from site;
drop table emp;

4. drop 문
    - 오라클 객체를 삭제
    - rollback의 대상이 아님
    (사용형식)
    
drop 객체타입 객체명;

예)emp 테이블과 work 테이블 사이에 존재하는관계를 삭제하시오.
alter table work
    drop constraint fk_work_emp;

alter table work
    drop constraint fk_work_site;
    
drop table emp;
drop table site; -- materials가 자식테이블이다.
drop table materials;
drop table site;
drop table work; 


