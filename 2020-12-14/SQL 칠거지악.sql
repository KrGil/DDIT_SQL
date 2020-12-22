개발자 칠거지악
1. 좌변을 가공하지 말라
EX)
SELECT *
FROM emp
WHERE lower(ename) = 'smith';
--좌변을 가공하면 
1. INDEX를 못쓰게 된다.
2. 테이블 행만큼 실행됨.
--비효율
SELECT *
FROM emp
WHERE lower(ename) = 'smith';