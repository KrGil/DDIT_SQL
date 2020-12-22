2020-11-18-02)오라클 데이터 타입
 - 오라클에서 제공하는 데이터 타입은 문자열, 숫자, 날짜, 2진자료형이 있다.
 
    1. 문자열 데이터 타입
    - ''로 묶인 자료를 문자열 자료라고 함
    - CHAR, VARCHAR, VARCHAR2, NVARCHAR, NCHAR, LONG, RAW, CLOB 등이 존재
    
    1)CHAR
    . 고정길이 문자열을 취급
    . 최대 2000BYTE 저장 가능
    . 기억장소가 남으면 오른쪽에 공백이 삽입
    . 기억공간보다 큰 데이터는 저장 오류
    . 한글 한 글자는 3BYTE로 저장됨
    
    (사용형식)
    컬럼명 char(크기[byte|char])
    .'크기'[byte|char]
    
    
예)
create table temp01(
    col1 char(20),
    col2 char(20 byte),
    col3 char(20 char)
    );

insert into temp01(col1, col2, col3)
    values('대한민국','il postino', '대전광역시 중구 대흥동 500-1번지');

select lengthb(col1), lengthb(col2), lengthb(col3)
    from temp01;
    
select * from temp01;

2)VARCHAR2
    .가변길이 문자열 처리
    . 최대 4000byte 처리 가능
    . 정의된 기억공간에서 데이터의 길이 만큼 사용하고 남는 공간은 시스템에 반납
    . varchar와 같은 기능(오라클은 varchar2 사용을 권고)
    (사용형식)
    컬럼명 varchar2(크기[byte|char])
    '[byte|char]' : 생략되면 byte로 취급
    
예)

create table temp02(
    col1 varchar2(20),
    col2 varchar2(20 char)
    );

insert into temp02
    values('대전시','대한민국은');
    
select * from temp02;

select lengthb(col1), lengthb(col2) from temp02;
    
    