2020-12-22-01)
**의사레코드
    1) :new
    - insert와 update에서 사용
    - 데이터가 삽입(갱신)될 때 새로 입력된 값을 지칭함
    - delete 시에는 모든 칼럼이 null값이 됨
    
    2) :old
    - delete와 update에서 사용
    - 데이터가 삭제(갱신)될 때 저장되어 있던 값
    - insert 시에는 모든 칼럼이 null값이 됨
    
**트리거 함수
    - 트리거를 촉발시킨 event의 종류를 판단할 때 사용
    1) inserting : 트리거된 문장이 insert이면 true
    2) updating : 트리거된 문장이 update이면 true
    3) deleting : 트리거된 문장이 delete이면 true
    
예) 오늘이 2005년 4월 20일이라 가정하고 매입상품 'P2010000001'의 매입수량을 15개에서
    25개로 수정하시오.
    수정 후 재고수불테이블의 자료도 변경될 수 있도록 트리거를 작성하시오.
    
    (트리거 생성)
CREATE OR REPLACE TRIGGER tg_buyprod_update
    AFTER INSERT OR UPDATE OR DELETE ON buyprod
    FOR EACH ROW
DECLARE
    v_qty NUMBER:= 0; -- 제품매입수량
    v_prod prod.prod_id%TYPE; -- 상품코드
BEGIN 
    IF inserting THEN
        v_qty := NVL(:new.buy_qty, 0);
        v_prod := :new.buy_prod;
    ELSIF updating THEN
        v_qty := :new.buy_qty - :old.buy_qty;
        v_prod := :new.buy_prod;
    ELSE
        v_qty := :old.buy_qty;
        v_prod := :old.buy_prod;
    END IF;
    
    UPDATE remain
    SET remain_i = remain_i + v_qty,
        remain_j_99 = remain_j_99 + v_qty
    WHERE remain_year = '2005'
    AND remain_prod = v_prod;
    
    DBMS_OUTPUT.PUT_LINE('추가 변경 수량 : ' || v_qty);
    
--    --예외발생시
--    EXCEPTION
--        WHEN other THEN
--            DBMS_OUTPUT.PUT_LINE('예외발생:' || SQLERRM);
END;

예) 오늘이 2005년 4월 20일이라 가정하고 매입상품 'P2010000001'의 매입수량을 15개에서
    25개로 수정하시오.
    수정 후 재고수불테이블의 자료도 변경될 수 있도록 트리거를 작성하시오.

(매입장 갱신 또는 삽입)
DECLARE
    v_cnt NUMBER := 0; --2005년 4월 20일 'P2010000001' 상품정보 존재여부 판단
    v_qty NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM buyprod
    WHERE buy_prod = 'P201000001'
    AND buy_date = TO_DATE('20050420');
    
    IF v_cnt = 1 THEN -- UPDATE 필요
        UPDATE buyprod
        SET buy_qty = buy_qty + v_qty
        WHERE buy_prod = 'P2010000001'
            AND buy_date = TO_DATE('20050420');
    ELSE
        INSERT INTO buyprod
            VALUES('20050420', 'P2010000001', v_qty, 21000);
    END IF;
END;
        

    