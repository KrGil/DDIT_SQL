2020-12-11
--member ���̺��� �ΰ��� �÷��� ��ȸ : mem_id, mem_name
--�̸�(mem_name)�÷� ������������ ��ȸ�� ����� ����¡ ó���ϴ� ������ �ۼ��ϼ���.

SELECT *
FROM
    (SELECT ROWNUM rn, A.*
     FROM 
        (SELECT mem_id, mem_name
         FROM member
         ORDER BY mem_name) A )
WHERE rn BETWEEN (:page -1) * :pageSize + 1 AND (:page * :pageSize)  ;

������ ����(�����÷� ROWNUM)

ROWNUM �뵵
    - ����¡ ó��(row_1~3)
    - �ٸ� ��� ���еǴ� ������ ������ �÷� ����/Ȱ��
    - Ʃ�׽�
        inline view �ȿ��� rownum ��� �� view merging �� �Ͼ�� �ʴ´�.

SQL ���� ����
�����м�, �������� ==> ���ε� ==>
--����Ŭ �𺧷��۸� �ϱ� ���ؼ� ����Ŭ dbms�� ����Ǿ���Ѵ�(�˻�â�� ����Ŭservice�� ����ȴ�)
1.�����м�, �����ȹ
    ���� Ǯ���� ������ ���� ��ȹ�� �ִ� �� �˻�(Ŀ�� ����)
    -SQL Syntax �˻�
    -Semantic �˻�
    Data Dictionary
    -���� ��ü �˻�
    - ��Ű��, ��, ������
    ���� ��ȹ ����

������ SQL�̶�� ���� ���ڿ��� �Ϲ��ϰ� �����ؾ���
����, ��ҹ��ڵ� �Ϻ��ϰ� ��ġ �ؾ� ������ SQL�� �ν�
SELECT  /*DDIT*/ mem_id, mem_name
FROM member
WHERE mem_id = :id;

�����ȹ Ȯ�� ���
1. ������ SQL ���� EXPLAIN PLAN FOR �� �ۼ��ϰ� ����
2. ���� ��ȹ ��ȸ
    SELECT *--�Լ��� ������� TABLE�� �˷��ִ� ����
    FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM member;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3441279308
 �����ȹ �ؼ� ���
 1. ������ �Ʒ���
 2. ��, �ڽ� ���(�鿩����)�� ���� ��� �ڽĺ���
 1-0 �´�.
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
 *�� Pridicate��� ��. �ٷ� �ؿ� ��������.
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("MEM_ID"='a001')
   
   
--primary key�� �Բ� �����Ǵ� index...rowid
rowid --�ش� �࿡ ������ �� �ִ� �ּҸ� �ҷ�����
SELECT ROWID, mem_id
FROM MEMBER;
where mem_id = 'a001';

EXPLAIN PLAN FOR
SELECT mem_id
FROM MEMBER
WHERE mem_id ='a001';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

-----��ü�� ��ã�� �÷����� �־���� ������ ���̺� �����ؼ� �ε����� ã�� �ʿ䰡 ����.
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