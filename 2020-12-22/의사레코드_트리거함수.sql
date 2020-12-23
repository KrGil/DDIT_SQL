2020-12-22-01)
**�ǻ緹�ڵ�
    1) :new
    - insert�� update���� ���
    - �����Ͱ� ����(����)�� �� ���� �Էµ� ���� ��Ī��
    - delete �ÿ��� ��� Į���� null���� ��
    
    2) :old
    - delete�� update���� ���
    - �����Ͱ� ����(����)�� �� ����Ǿ� �ִ� ��
    - insert �ÿ��� ��� Į���� null���� ��
    
**Ʈ���� �Լ�
    - Ʈ���Ÿ� �˹߽�Ų event�� ������ �Ǵ��� �� ���
    1) inserting : Ʈ���ŵ� ������ insert�̸� true
    2) updating : Ʈ���ŵ� ������ update�̸� true
    3) deleting : Ʈ���ŵ� ������ delete�̸� true
    
��) ������ 2005�� 4�� 20���̶� �����ϰ� ���Ի�ǰ 'P2010000001'�� ���Լ����� 15������
    25���� �����Ͻÿ�.
    ���� �� ���������̺��� �ڷᵵ ����� �� �ֵ��� Ʈ���Ÿ� �ۼ��Ͻÿ�.
    
    (Ʈ���� ����)
CREATE OR REPLACE TRIGGER tg_buyprod_update
    AFTER INSERT OR UPDATE OR DELETE ON buyprod
    FOR EACH ROW
DECLARE
    v_qty NUMBER:= 0; -- ��ǰ���Լ���
    v_prod prod.prod_id%TYPE; -- ��ǰ�ڵ�
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
    
    DBMS_OUTPUT.PUT_LINE('�߰� ���� ���� : ' || v_qty);
    
--    --���ܹ߻���
--    EXCEPTION
--        WHEN other THEN
--            DBMS_OUTPUT.PUT_LINE('���ܹ߻�:' || SQLERRM);
END;

��) ������ 2005�� 4�� 20���̶� �����ϰ� ���Ի�ǰ 'P2010000001'�� ���Լ����� 15������
    25���� �����Ͻÿ�.
    ���� �� ���������̺��� �ڷᵵ ����� �� �ֵ��� Ʈ���Ÿ� �ۼ��Ͻÿ�.

(������ ���� �Ǵ� ����)
DECLARE
    v_cnt NUMBER := 0; --2005�� 4�� 20�� 'P2010000001' ��ǰ���� ���翩�� �Ǵ�
    v_qty NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM buyprod
    WHERE buy_prod = 'P201000001'
    AND buy_date = TO_DATE('20050420');
    
    IF v_cnt = 1 THEN -- UPDATE �ʿ�
        UPDATE buyprod
        SET buy_qty = buy_qty + v_qty
        WHERE buy_prod = 'P2010000001'
            AND buy_date = TO_DATE('20050420');
    ELSE
        INSERT INTO buyprod
            VALUES('20050420', 'P2010000001', v_qty, 21000);
    END IF;
END;
        

    