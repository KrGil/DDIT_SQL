2020-12-11
--member 테이블에서 두개의 컬럼만 조회 : mem_id, mem_name
--이름(mem_name)컬럼 오름차순으로 조회된 결과를 페이징 처리하는 쿼리를 작성하세요.

SELECT *
FROM
    (SELECT ROWNUM rn, A.*
     FROM 
        (SELECT mem_id, mem_name
         FROM member
         ORDER BY mem_name) A )
WHERE rn BETWEEN (:page -1) * :pageSize + 1 AND (:page * :pageSize)  ;

데이터 정렬(가상컬럼 ROWNUM)

ROWNUM 용도
    - 페이징 처리(row_1~3)
    - 다른 행과 구분되는 유일한 가상의 컬럼 생성/활용
    - 튜닝시
        inline view 안에서 rownum 사용 시 view merging 이 일어나지 않는다.

SQL 실행 절차
구문분석, 실행절차 ==> 바인드 ==>
--오라클 디벨로퍼를 하기 위해선 오라클 dbms가 실행되어야한다(검색창에 오라클service가 실행된다)
1.구문분석, 실행계획
    공유 풀에서 동일한 실행 계획이 있는 지 검색(커서 공유)
    -SQL Syntax 검사
    -Semantic 검사
    Data Dictionary
    -참조 객체 검사
    - 스키마, 롤, 구너한
    실행 계획 접수

동일한 SQL이라는 것은 문자열이 완벅하게 동일해야함
공백, 대소문자도 완벽하게 일치 해야 동일한 SQL로 인식
SELECT  /*DDIT*/ mem_id, mem_name
FROM member
WHERE mem_id = :id;

실행계획 확인 방법
1. 실행할 SQL 위에 EXPLAIN PLAN FOR 을 작성하고 실행
2. 실행 계획 조회
    SELECT *--함수의 결과값을 TABLE로 알려주는 쿼리
    FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM member;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3441279308
 실행계획 해석 방법
 1. 위에서 아래로
 2. 단, 자식 노드(들여쓰기)가 있을 경우 자식부터
 1-0 맞다.
 0-1
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |    24 |  7152 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS FULL| MEMBER |    24 |  7152 |     2   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Note
-----
   - dynamic sampling used for this statement (level=2)

    
EXPLAIN PLAN FOR
SELECT *
FROM member
WHERE mem_id = 'a001';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

-----------------------------------------------------------------------------------------
| Id  | Operation                   | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |           |     1 |   298 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY   ROWID| MEMBER    |     1 |   298 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_MEM_ID |     1 |       |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------
 *는 Pridicate라고 함. 바로 밑에 설명해줌.
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("MEM_ID"='a001')
   
   
--primary key에 함께 생성되는 index...rowid
rowid --해당 행에 접근할 수 있는 주소를 불러오는
SELECT ROWID, mem_id
FROM MEMBER;
where mem_id = 'a001';

EXPLAIN PLAN FOR
SELECT mem_id
FROM MEMBER
WHERE mem_id ='a001';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

-----전체를 안찾고 컬럼명을 주어줬기 때문에 테이블에 접속해서 인덱스로 찾을 필요가 없다.
-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     1 |     9 |     1   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_MEM_ID |     1 |     9 |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("MEM_ID"='a001')
   
EXPLAIN PLAN FOR
SELECT *
FROM prod, lprod
WHERE prod.prod_lgu = lprod_gu;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
 
----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |    74 |   175K|     6  (17)| 00:00:01 |
|*  1 |  HASH JOIN         |       |    74 |   175K|     6  (17)| 00:00:01 |
|   2 |   TABLE ACCESS FULL| LPROD |     9 |   369 |     2   (0)| 00:00:01 |
|   3 |   TABLE ACCESS FULL| PROD  |    74 |   172K|     3   (0)| 00:00:01 |
----------------------------------------------------------------------------
2-3-1-0
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("PROD"."PROD_LGU"="LPROD_GU")
 
Note
-----
   - dynamic sampling used for this statement (level=2)