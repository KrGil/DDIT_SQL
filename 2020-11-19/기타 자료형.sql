2020-11-19-02)기타 자료형
    -2진 자료를 저장하기 위한 자료 타입
    -blob, raw, long law, bfile 등이 제공
    1) raw
    - 상대적으로 작은 용량의 2진 자료를 저장
    - 인덱스 처리가 가능
    - oracle에서 해석이나 변환작업을 수행하지 않음
    - 최대 2000byte까지 처리 가능
    -16진수와 2진수 저장
    (사용형식)
    컬럼명 raw(크기)
    
    예)
    create table temp07(
        col1 raw(1000),
        col2 raw(2000)
        );
        
    INSERT INTO temp07
        VALUES (hextoraw('3De5ff77'),hextoraw('00'));
    insert into temp07
        values('00111101111011111111111011110111','00000000');
select * from temp07;

2)bfile
    - 이진자료 저장
    - 대상 이진자료를 데이터베이스 외부에 저장
    - 경로 정보(directory 객체)정보만 테이블에 저장
    - 4gb까지 저장 가능
    (사용형식)
    컬럼명 bfile
        .디렉토리 별칭(alias) 설정(30byte)과 파일명(256byte)설정
    
    그림파일 저장순서
    1. 그림파일 저장된 폴더 확인
    2. 디렉토리 객체 생성 - 그림이 저장된 디렉토리의 절대 주소
        create directory test_dir as 'D:\A_TeachingMaterial\2.Oracle\other';
    3. 그림을 저장할 테이블 생성
        create table temp08(
            col bfile);
    4. 그림을 삽입한다.
        insert into temp08
            values(bfilename('test_dir', 'SAMPLE.PNG'));
        select * from temp08;
        
    - 이진자료 저장
    - 대상 이진자료를 데이터베이스 내부에 저장
    - 4gb까지 저장 가능
    (사용가능)
    컬럼명 blob
    
    (그림저장순서)
    1.그림파일 준비(SAMPLE.PNG)
    2.디렉토리객체 생성(test_dir)
    3.익명블록생성
    
    declare
    l_dir varchar2(20):='test_dri';
    l_file varchar2(30):='SAMPLE.PNG';
    l_bfile bfile;
    l_blob blob;
    begin
    insert into temp08(col1) values(empty_blob())
        return col1 into l_blob;
    
    l_bfile := bfilename(l_dir, l_file);
    dbms_lob.fileopen(l_bfile, dbms_lob.file_readonly);
    dbms_lob.loadfromfile(l_blob,l_bfile,dbms_lob.getlength(l_bfile));
    dbms_lob.fileclose(l_bfile);
    
    8-3*2-1+1 = 0
    
    end;
    commit;
        
        