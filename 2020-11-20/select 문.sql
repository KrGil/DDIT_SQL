2020-11-20-01)연산자와 함수
select 문
 - 데이터를 조회하는 명령
 - SQL 명령 중 가장 많이 사용되는 명령
 (사용형식)
 select [distinct]|*|컬럼명 [AS]["]컬럼별칭["],
        컬럼명 [AS]["]컬럼별칭["],
        ..
        컬럼명 [AS]["]컬럼별칭["]
    from 테이블명
    [where 조건]
    [group by 컬럼명[,컬럼명,...]] --~~별
[having 조건] -- 
    [order by 컬럼명|컬럼인덱스[asc|desc][,컬럼명|컬럼인덱스[asc|desc],...]; -- 2 적으면 select에 적은 2번째 컬럼을 오름차순으로.

.'[distinct]' : 중복된 자료를 배제할 때 사용
. '컬럼별칭' : 컬럼에 부여된 또 다른 이름
    - 컬럼명 as 별칭
    - 컬럼명   별칭
    - 컬럼명 "별칭" : 별칭에 특수문자(공백포함)가 포함된 경우 반드시 ""로 묶어 사용
    - '컬럼인덱스' : select 절에서 기술된 해당 컬럼의 순번(1부터 counting)
    - 'asc|desc' : 정렬방법(asc:오름차순으로 기본값, desc는 내림차순)
    - select문의 실행 순서 : form -> where절 이하 -> select절
    
1. 연산자
    - 산술연산자(+,-,*,/)
    - 관계연산자(>,<,>=,<=,=,!=(<>))
    - 논리연산자(and,or,not)

2. 함수(function)
    - 특정 기능을 수행하여 하나의 결과를 반환하도록 설계된 모듈
    - 컴파일되어 실행 가능한 상태로 제공
    - 문자열, 숫자, 변환, 집계함수의 형태로 제공
    
1)문자열 함수
    - 문자열 조작한 결과를 반환
    ** 문자열 연산자 '||'
    자바의 문자열 연산자 '+'와 같이 두 문자열을 결합하여 하나의 문자열을 반환
    (사용형식)
    
예) 회원테이블에서 여성회원들의 정보를 조회하시오.
    Alias는 회원번호, 회원명, 주소, 마일리지
select mem_id 회원번호, mem_name 회원명, mem_add1||' '||mem_add2 주소, mem_mileage 마일리지
    from member
    where substr(mem_regno2, 1,1)='2' or substr(mem_regno2, 1,1)='4'
    order by 4 desc;
    
    
1)concat(c1, c2)
    - c1과 c2를 결합하여 결과를 반환

    select 'my name is ' || mem_name
        from member;
    select concat('my name is ', mem_name)
        from member;
    
예) 회원테이블에서 회원번호, 회원명, 주민번호를 조회하시오
    단, 주민번호는 'xxxxxx-xxxxxxx'형식으로 출력하시오
    select mem_id 회원번호, mem_name 회원명, concat(concat(mem_regno1,'-'), mem_regno2) 주민번호
        from member;
    select mem_id 회원번호, mem_name 회원명, mem_regno1||'-'||mem_regno2 주민번호
        from member;
예)
select 'oracle' ||', '|| 'Modeling' From dual;

예) 회원테이블에서 회원번호, 회원명, 주민번호를 조회하시오
    단, 주민번호는 'xxxxxx-xxxxxxx'형식으로 출력하시오
    
select mem_id 회원번호,
        mem_name 회원명,
        mem_regno1 || '-' || mem_regno2 주민번호
    from member
    order by 2;
    
    
    
2)initcap
 - 단어의 선두문자만 대문자로 출력
 - 보통 이름 출력 시 사용
 (사용형식)
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
    
예) 회원테이블에서 회원번호와 회원명을 조회하시오.
select mem_id as "회원번호",
        mem_name as "회원이름"
        from member;
        
select mem_id "   회원번호",
        mem_name 회원이름
        from member;
    
select * --column(열?)
    from lprod; -- table
       -- where --raw(행?)
select mem_id, mem_name, mem_bir, mem_mileage
    from member
    order by 2;--
select prod_id 상품코드, prod_name 상품명, prod_sale * 55 상품가격   
    from prod;
select lprod_id "id", lprod_nm "제품"
    from lprod;
select *
    from lprod
    where lprod_nm = '여성캐주얼';
    