2020-12-14 PL/SQL 
------실습 2
registdept_test procedure 생성
param : deptno, dname, loc
logic : 입력받은 부서 정보를 dept_test 테이블에 신규 입력
exec registdept_test (99, 'ddit', 'daejeon');
dept_test 테이블에 정상적으로 입력 되었는지 확인(SQL-눈으로)

SELECT deptno, dname, loc
FROM dept;
SET SERVEROUTPUT ON;

-- 테이블 복사하기(나만의 수정 공간)
CTAS : CHECK 제약을 제외한 나머지 제약조건들은 적용되지 않는다.
CREATE TABLE dept_test AS
SELECT *
FROM dept;
where 1=2; --테이블 형태만 가지고 오기(값은 가지고오지말고)

rollback;

--데이터를 잘못 넣었을 경우 
INSERT INTO dept_test(deptno,dname, loc)
    VALUES (99, 'ddit', 'daejeon');
select * from dept_test;
select rowid, dept_test.* from dept_test;
--데이터를 삭제하기!!
delete dept_test
where rowid in ('AAAFCOAABAAALkCAAA','AAAFCOAABAAALkCAAB');


CREATE OR REPLACE PROCEDURE registdept_test(p_deptno dept_test.deptno%TYPE,
                                            p_dname dept_test.dname%TYPE,
                                            p_loc dept_test.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test(deptno,dname, loc)
    VALUES (p_deptno, p_dname, p_loc);
    COMMIT;
END;
/
EXEC registdept_test(98, 'DDIT', '대전');

SELECT *
FROM dept_test;

---- 실습문제 3
UPDATEdept_test procedure 생성
param : deptno, dname, loc
logic : 입력받은 부서 정보를 dept_test 테이블에 정보 수정
exec UPDATEdept_test (99, 'ddit', 'daejeon');
dept_test 테이블에 정상적으로 입력 되었는지 확인(SQL-눈으로)

UPDATE dept_test
SET dname = 'ddit', loc = 'daejeon'
WHERE deptno = 98;

CREATE OR REPLACE PROCEDURE UPDATEdept_test(p_deptno dept_test.deptno%TYPE,
                                            p_dname dept_test.dname%TYPE,
                                            p_loc dept_test.loc%TYPE)IS
BEGIN
    UPDATE dept_test
    SET dname = p_dname, loc = p_loc
    WHERE deptno = p_deptno;
END;
/

EXEC UPDATEdept_test(98, 'aa', 'aa');
CREATE OR REPLACE PROCEDURE PRINTdept_test(p_deptno dept_test.deptno%TYPE) IS
V_deptno dept_test.deptno%TYPE;
V_dname dept_test.dname%TYPE;
V_loc dept_test.loc%TYPE;
BEGIN
    SELECT deptno, dname, loc INTO V_deptno, V_dname, V_loc
    FROM dept_test
    WHERE deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE(V_deptno || ' / ' || V_dname || ' / ' || V_loc);
END;
/
EXEC PRINTdept_test(98);   

----[배열]
PL/SQL 복합 변수
점(컬럼) - 선(행)  -  면(테이블)
%TYPE    %ROWTYPE   TABLETYPE
          RECORD TYPE
          
ROWTYPE : 행 전체를 저장할 수 있는 변수
          컬럼이 많은 테이블의 값을 변수로 담을 때 컬럼별로 변수를 선언하지 않고
          행단위로 한번만 선언을 하고 사용하므로 편의성이 증대된다.
          
DEPT 테이블의 10번 부서정보를 담을 수 있는 ROWTYPE을 선언하여 활용
SET SERVEROUTPUT ON;
DECLARE
    -- 변수명 변수타입
    V_dept_row /*테이블명%TABLETYPE*/ dept%ROWTYPE;
BEGIN
    SELECT * INTO V_dept_row
    FROM dept
    WHERE deptno = 10;
    --컬럼의 값 접근 : rowtype.컬럼명
    DBMS_OUTPUT.PUT_LINE( v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/

RECORD TYPE : 개발자가 저장하려고하는 컬럼을 직접 지정 행에 대한 타입을 선언
              (JAVA에서 클래스를 선언)
선언방법
TYPE 타입명 IS RECORD(
--    컬럼명 컬럼타입,
--    컬럼명2 컬럼타입,
    ename EMP.ENAME%type,
    dname dept.dname%type
)

DECLARE
    --타입을 선언한 것
    TYPE name_row IS RECORD(
        ename EMP.ENAME%type,
        dname dept.dname%type);
    --변수명 변수타입
    names name_row;
BEGIN
    SELECT ename, dname INTO names
    FROM emp, dept
    WHERE emp.deptno = dept.deptno
        AND empno = 7839;
    DBMS_OUTPUT.PUT_LINE(names.ename || ' / ' || names.dname);
END;
/

TABLE TYPE : 여러행을 저장할 수 있는 타입
TYPE 타입이름 IS RECORD
TYPE 타입이름 IS TABLE OF 레코드 타입 / %ROWTYPE INDEX BY BINARY_INTEGER/*행정보표기*/
int[] arr = new int[50];

DECLARE
    --타입을 선언한 것
    TYPE name_row IS RECORD(
         ename EMP.ENAME%type,
         dname dept.dname%type);
    TYPE name_tab IS TABLE OF name_row INDEX BY BINARY_INTEGER;
    --변수명 변수타입
    names name_tab;
    
    -- names[1]; ==> names(1) 인덱스의 시작이1번
BEGIN                   -- into 단일, 여러개 담기
    SELECT ename, dname BULK COLLECT INTO names
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;
    --PL/SQL FOR문
    --for(int i = 0; i < names.length;)
    FOR i IN 1..names.count LOOP -- i가 1부터 names의 길이만큼
        DBMS_OUTPUT.PUT_LINE(names(i).ename || ' / ' || names(i).dname);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(names(1).ename || ' / ' || names(1).dname);
    DBMS_OUTPUT.PUT_LINE(names(2).ename || ' / ' || names(2).dname);
    DBMS_OUTPUT.PUT_LINE(names(3).ename || ' / ' || names(3).dname);
    DBMS_OUTPUT.PUT_LINE(names(14).ename || ' / ' || names(14).dname);
END;
/