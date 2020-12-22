2020-12-21-02)Ʈ����(trigger)

- � �̺�Ʈ�� �߻��Ǹ� �� �̺�Ʈ�� ���Ͽ� �ٸ� ���̺��� ���� �ڵ�����
����(����/update,����) �ǵ��� ������ ���ν���
- ������ ���Ἲ ����

    (�������)
    create trigger Ʈ���Ÿ�
    [before|after] [insert|update|delete]
    on ���̺��
    [for each row]
    [when ����]
    [declare]
    �����; �ʿ������ �����ص� �ȴ�.
    begin
    Ʈ���� ó���� ;
    end;
    .before|after : Ʈ������ timming, �����ϸ� after�� ����
    Ʈ���� ����(Ʈ���� ó����)�� �̺�Ʈ �߻� ���̸� before,
    �̺�Ʈ �߻� ���̸� after�� ���
    .'insert|update|delete' : Ʈ���� �̺�Ʈ, Ʈ���Ÿ� �߻���Ű�� ��������
    or �����ڸ� �̿��Ͽ� ������ ���� ����(ex insert or delete)

    .'for each row' : ����� Ʈ���� �߻��� ���, �����ϸ� ������� Ʈ����

    .'when ����' : ����� Ʈ���ſ����� ����ϸ� Ʈ���� �̺�Ʈ���� ���ǵ� ���̺� �̺�Ʈ��
    �߻��� �� ���� ��ü���� ������ �˻� ���Ǻο��� ���

    - * ������� ������� Ʈ����
    (1) ������� Ʈ���� : �̺�Ʈ �߻��� ���� �ѹ��� Ʈ���� �߻�(���� ������� ����)
    (2) ����� Ʈ���� : 'for each row' ���
    �̺�Ʈ ��� �� �ึ�� Ʈ���� ����,
    �ǻ緹�ڵ�(pesudo record) �� :new, :old ��� ����
    ��κ��� Ʈ���Ű� ����
    ��, �� Ʈ���� ������ �Ϸ���� ���� ���¿��� �� �ٸ� Ʈ���Ÿ� ȣ��
    �� ��� �ý��ۿ� ���� Ʈ���� ���� ����

    ��) �з����̺� ���ο��ڷḦ �Է��ϰ� �Է��� ���������� ó���Ǿ�����
    '�ű� �з��ڷᰡ ���� �ԷµǾ����ϴ�.!!' �޼����� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�
    [�ڷ�]
    �з��ڵ� : p502
    ���� : 12
    �з��� : ��깰

    create trigger tg_lprod01
    after insert on lprod
    begin
    dbms_output.put_line( '�ű� �з��ڷᰡ ���� �ԷµǾ����ϴ�.!!');
    end;

    insert into lprod
    values(12,'p502','��깰');
    select * from lprod;

    ��) �԰����̺�(buyprod)���� 2���� 3�� �԰�� ��ǰ�� ���Լ����� ��ȸ�Ͽ� ���������̺���
    �����Ͻÿ�.
    (�������� : 2���� 3�� �԰�� ��ǰ�� ���Լ����� ��ȸ)

    SELECT buy_prod,
    SUM(buy_qty)
    FROM buyprod
    WHERE buy_date BETWEEN '20050201' AND '20050331'
    GROUP BY buy_prod
    ORDER BY 1;

    (�������� : remain���̺� UPDATE)
    UPDATE remain a
    SET (a.remain_i, a.remain_j_99, a.remain_date) =
    (SELECT a.remain_i + b.iamt, a.remain_j_99 + b.iamt, to_date('20050331')
    FROM (SELECT buy_prod AS bid,
    SUM(buy_qty) AS iamt
    FROM buyprod
    WHERE buy_date BETWEEN '20050201' AND '20050331'
    GROUP BY buy_prod) b
    WHERE a.remain_prod = b.bid)
    WHERE a.remain_year = '2005'
    AND a.remain_prod IN (SELECT DISTINCT buy_prod
    FROM buyprod
    WHERE buy_date BETWEEN '20050201' AND '20050331')
    select * from remain;

    ## ��) ������ 2005�� 4�� 1���̶�� �����ϰ� ���� �ڷḦ ��ٱ��� ���̺� �Է��Ͻÿ�.
    ��ٱ������̺� �Էµ� �� ���������̺��� �����Ͻÿ�
    �Է��ڷ� : (29, 21, 0, 50, 2005-01-31:remain���̺��� �ڷ�)
    ����ȸ�� : c001
    ���Ż�ǰ : P302000014
    ���ż��� : 5

    (Ʈ����)
    CREATE OR REPLACE TRIGGER tg_cart_insert
    AFTER INSERT ON cart
    FOR EACH ROW
    BEGIN
    UPDATE remain
    SET remain_o = remain_o + :new.cart_qty,
    remain_j_99 = remain_j_99 - :new.cart_qty,
    remain_date ='20050401'
    WHERE remain_prod = :new.cart_prod
    AND remain_year = '2005';
    END;

    rollback;
    select * from remain;
    SELECT * FROM cart;
    (���� : CART���̺� �ڷᰡ ���Ե� ��)
    INSERT INTO cart
    SELECT 'c001', max(cart_no) + 1, 'P302000014', 5
    FROM cart
    WHERE SUBSTR(cart_no, 1, 8) = '20050401'