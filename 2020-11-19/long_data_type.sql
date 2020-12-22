2020-11-19-01)
3) long 데이터 타입
- 가변길이 문자열을 저장
- 최대 2gb 까지 저장가능
- long타입은 하나의 테이블에서 1개만 사용 가능
- clob로 대체(기능 업그레이드 중단)
- select문의 select절, update문의 set절, insert문의 values절에서 사용 가능
(사용형식)
컬럼명 long

예)
create table temp03(
    col1 long,
    col2 varchar2(2000)
    );
insert into temp03 values('sadaf','asdfad');
select * from temp03;
select substr(col2, 2,5) from temp03;

4) clob(character large object) 데이터 타입
    - 대용량 문자열 자료를 처리하기 위한 데이터 타입
    - 최대 4gb까지 처리 가능
    - 가변길이 문자 자료형
    - 한 테이블에서 사용될 수 있는 clob의 갯수에 제한이 없음
    - 일부 기능 들은 dbms_lob api의 지원을 받아야 함
    (사용형식)

create table temp04(
    col1 clob,
    col2 clob,
    col3 clob
    );
insert into temp04
    values('대한민국은 민주 공화국이다', '대전시 중구 대흥동 500 영민빌딩 3층',
            'Oracle Modling과 SQL'
    );
select * from temp04;

select lengthb(col2) from temp04;

select DBMS_LOB.SUBSTR(col1,5,3), --3번째에서 5개를 띄워라. 오른쪽에서 읽어들임
        DBMS_LOB.GETLENGTH(col2),
        length(col3)
    from temp04;
    
update temp04
    set col3 = 'Oracle Modeling과 SQL'
    
5) nclob, nvarchar2
    - 다국어 지원 형태로 문자 자료저장
    - UTF-8, UTF-16 형식의 encodding 
    - 나머지 기능은 clob, varchar2와 동일

2. 숫자자료형
    - 정수와 실수 데이터 저장
    - number 타입 제공
    (사용형식)
    number[(정밀도)*[,스케일])]
    - 표현할 수 있는 값의 범위 : 1.0e-130 ~ 9.999..9e125
    - 정밀도 : 전체 자리수(1~38)
    - 스케일 : 소숫점이하의 자리수
    ex)number(5,2) : 전체 5자리가 확보(정수 부분 3자리, 소숫점이하 3자리에서
        반올림하여 2번째 자리까지 표현)
    - 정밀도 대신 '*'를 사용하면 38자리 이내에서 자동할당
    ex)number(*,2) : 소수점이하 3자리에서 반올림하여 2번째 자리까지 표현, 단, 정수부분은
    38자리 이내에서 크기만큼 자동 할당
    -스케일이 생략되면 0으로 간주
    
예)
입력값                     선언                  저장된 값
12345678.7896           number              12345678.7896
12345678.7896           number(*,2)         12345678.79
12345678.7896           number(8)           12345679
12345678.7896           number(7,2)         오류
12345678.7896           number(10,-2)       12345700

    **정밀도 < 스케일 인 경우 --정수가 0이고 소수가 있는 경우. 0.12312312
    - 정밀도는 0이 아닌 유효숫자의 수
    - (스케일-정밀도) : 소숫점이하에 존재해야할 0의 갯수
    - 스케일 : 소숫점 이하의 데이터의 수
    
입력값                     선언                  저장된 값
1.234                   number(4,5)         오류
0.23                    number(3,5)         오류
0.0123                  number(3,4)         0.0123
0.0012345               number(3,5)         0.00123
0.00125676              number(3,5)         0.00126

3. 날짜자료형
    - 날짜자료(년,월,시,분,초)를 저장하기 위한 데이터 타입
    - 기본형은 date, 시간대(timezone)정보와 10억분의 1초단위의 시각정보를
    - 제공하는 데이터 타입으로 timestamp가 제공
    1)date 타입
    - 기본 날짜형
    - '+', '-' 연산의 대상
    **sysdate : 시스템이 제공하는 날짜정보를 제공하는 함수
    (사용형식)
    컬럼명 date

예)
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
select to_char(col1,'YYYY"년" MM"월" DD"일" AM HH24:MI:SS') from temp05;

2)timestamp 타입
    - 시간대 정보와 정교한 시간정보를 필요할 때 사용
    (사용형식)
    컬럼명 timestamp - 시간대 정보 없음
    컬럼명 timestamp with time zone - 시간대정보(대륙명/도시명) 포함
    컬럼명 timestamp with local time zone 
            - 서버가 위치한 시간대정보, 보통 timestamp와 동일
예)
create table temp06(
    col1 date,
    col2 timestamp,
    col3 timestamp with time zone,
    col4 timestamp with local time zone
    );
insert into temp06
    values(sysdate,sysdate,sysdate,sysdate);
select*from temp06;
    
