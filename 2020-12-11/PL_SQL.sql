PL/SQL
- Procedural Language /SQL --절차적 언어
- 오라클에서 제공하는 프로그래밍 언어
- 집합적 성향이 강한 SQL에 일반 프로그래밍 언어 요소를 추가
    SQL에서 지원하지 않는 반복문, 조건문을 지원
- 데이터를 절차적으로 처리하는데 그 목적

java
변수타입 변수명 = 변수값;
pl/sql
변수명 변수타입 := 변수값;

기본구조
 Declare(선언부) --여기서만 선언 가능.
    - 변수, 상수를 선언
    - 생략가능
 Begin(실행부) --여기만 있으면 실행 가능.
    - 제어문, 반복문 등의 로직 실행
 Exception(예외 처리부)
    - 실행 도중 에러 발생을 catch, 후속조치
    - 생략가능
    
연산자
대입연산자 : :=

PL/SQL
구조 : DECLARE (생략가능) - 변수, 상수 등을 선언
      BEGIN(생략 불가) - 비지니스 로직(SQL, IF, LOOP)
      EXCEPTION(생략가능) - 예외처리(JAVA-TRY,CATCH)
      
  1. 10번 부서의 DNAME, LOC 컬럼 두개를 변수에 담는다.
  2. 두개의 변수값을 출력(System.out.println)
  
SELECT *
FROM dept;

--describe 
DESC dept;

변수 선언 : 변수명 변수타입;
pl/sql : 변수명 작명시 V_xxx 접두어 사용

--프린트 하려면 반드시 이거 해야함.
SET SERVEROUTPUT ON;
-- 익명블록! Anonymous block
DECLARE
     V_DNAME VARCHAR2(14); --딱 하나의 값만 저장가능! 여러개 저장하려면 배열이나 리스트!
     V_LOC VARCHAR2(13);
BEGIN
---------------------변수에 값 담기 INTO 변수명1, 변수명2
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
    FROM dept
    WHERE deptno = 10;
     --디버깅 목적. SYSOUT과 같은 효과
    --  System.out.println(v_dname + " / " + v_log);
    DBMS_OUTPUT.PUT_LINE(V_DNAME || '/ ' || V_LOC);
END;
/
--/가 ;과 같은 역할을 한다.


-- 여기 자체에서만 쓸 수 있다.
Anonymous block
--등록해서 쓰기
procedure
 - return 필요 없다.
function
 - return 필수


AOP(Aspect Oriented Programing)
OOP(Object Oriented Programing)

view는 쿼리이다
- view는 인라인뷰다.

참조변수 : 특정테이블의 컬러므이 데이터 타입을 자동으로 참조 ==> 컬럼의 데이터 타입이 바뀌어도
        PL/SQL 블록의 변수 선언부를 수정할 필요가 없어짐 : 유지보수에 유리
        테이블명.컬럼명%TYPE;
        
DECLARE
     V_DNAME dept.dname%TYPE;--<==VARCHAR2(14);
     V_LOC dept.loc%TYPE;--<==VARCHAR2(13);
BEGIN
---------------------변수에 값 담기 INTO 변수명1, 변수명2
    SELECT DNAME, LOC INTO V_DNAME, V_LOC
    FROM dept
    WHERE deptno = 10;
     --디버깅 목적. SYSOUT과 같은 효과
    --  System.out.println(v_dname + " / " + v_log);
    DBMS_OUTPUT.PUT_LINE(V_DNAME || '/ ' || V_LOC);
END;
/

pl/sql block 구분
1. 익명 블럭 : inline-view
2. procedure : 오라클 서버에 저장한 pl/sql 블럭, 리턴값은 없다.
3. function : 오라클 서버에 저장한 pl/sql 블럭, 리턴값이 있다.

오라클 객체
CREATE 오라클객체타입 객체이름....
CREATE TABLE 테이블명
CREATE [OR REPLACE] VIEW 뷰이름 --OR REPLACE 이름이 같으면 변경하라.

CREATE /*OR REPLACE */PROCEDURE printdept IS 
    --선언부(DECLARE)
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = 10;
    DBMS_OUTPUT.PUT_LINE(v_dname || ' / ' || v_loc); 
END;
/

프로시져 실행하기!;
EXEC 프로시져 명
EXEC printdept;

현재 프로시져는 10번 부서의 정보만 조회가 되게끔 코드가 구성됨(hard coding)
procedure 인자로 조회하고 싶은 부서번호를 받도록 수정하여 코드를 유연하게 만들어 보자

프로시져를 생성할 때 인자를 프로시져명 뒤에 선언할 수 있음
인자는 메소드와 마찬가지로 여러개를 받을 수 있음

수업시간에는 프로시져에서 인자 이름을 P_XXX 접두어를 사용하기로 합시다.

CREATE OR REPLACE PROCEDURE [(인자명 인자 타입)]
CREATE OR REPLACE PROCEDURE printdept(p_deptno dept.deptno%TYPE) IS 
    --선언부(DECLARE)
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = p_deptno; -- 파라미터 값을 받아서 유용성을 높이자! 10;
    DBMS_OUTPUT.PUT_LINE(v_dname || ' / ' || v_loc); 
END;
/

EXEC printdept(50);

실습 (procedure 생성 실습 pro_1)
printemp procedure 생성
param : empno
logic : empno에 해당하는 사원의 정보를 조회하여 사원이름, 부서이름을 화면에 출력

select * from emp;
select * from dept;
CREATE OR REPLACE PROCEDURE printempno(p_empno emp.empno%TYPE) IS
    V_empno emp.empno%TYPE
    V_dname dept.dname

BEGIN

END;
/

select * from emp;
select * from dept;
SELECT a.ename, b.DEPTNO
    from emp a, dept b
    where a.deptno = b.DEPTNO
        AND a.empno = 7369;
        
        
CREATE OR REPLACE PROCEDURE printempno(p_empno emp.empno%TYPE) IS
    V_ename emp.ename%TYPE;
    V_dname dept.dname%TYPE;
BEGIN
    SELECT a.ename, b.dname INTO V_ename, V_dname
    FROM emp a, dept b
    WHERE a.deptno = b.deptno
        AND a.empno = p_empno;
    DBMS_OUTPUT.PUT_LINE(V_ename || ' / ' || V_dname);
END;
/


EXEC printempno(7369);
rollback;

