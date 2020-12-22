2020-11-16-01)사용자 생성
 - create 명령으로 사용자 생성
 - grant 명령으로 권한 부여
 - developer에 등록
 **기호
 '[ ]' : 생략 가능
 '|' : 선택사용
 ',...' : 반복될 수 있음
1. create 명령
  - 오라클 개체(table, user, index, etc)를 생성시킴
  (사용형식)
  create user 계정명 identified by 암호;
  create user Gil identified by java;

2. 권한부여
grant 권한명,... to 계정명;
grant connect, resource, dba to Gil;