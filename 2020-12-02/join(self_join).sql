2020-12-02-02) join
3. self join --���������� ���°ɱ�?
    - �ϳ��� ���̺��� ���̺� ��Ī�� �̿��Ͽ� 2���� ���̺�ó��
    �ڽ��� ���̺��� �ڽ��� ���̺�� join�ϴ� ���
    
��)ȸ�����̺��� ȸ����ȣ 'T001' ȸ���� ������ ���ϸ������� ����
    ���ϸ����� ������ ȸ���� ��ȸ�Ͻÿ�.
    ȸ����ȣ, ȸ����, ���ϸ���
select * from member;
--�ϳ��� �̿��ϱ� subquary��
select mem_id, mem_name, mem_mileage
    from member
    where mem_mileage > (select mem_mileage
                            from member
                            where mem_id = 't001')
    order by 3 desc;
--sub���� ����
select mem_mileage
    from member
    where mem_id = 't001';

--self_join
select b.mem_id ȸ����ȣ, b.mem_name ȸ����, b.mem_mileage ���ϸ���
    from member a, member b --a: 'T001'ȸ��, b: ��üȸ��
    where lower(a.mem_id) = 't001'
            and a.mem_mileage < b.mem_mileage;
            
--self_join + subquary
select a.mem_id ȸ����ȣ, a.mem_name ȸ����, a.mem_mileage ���ϸ���
    from member as a, (select mem_mileage
                        from member
                        where mem_id = 't001') b --a: ��üȸ�� b: 'T001'ȸ���� ���ϸ���
    where a.mem_mileage > b.mem_mileage;
    
��)��ٱ������̺��� 't001'ȸ������ �Ǹ��� 2005�� ���� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�.
select * from cart;
select * from prod;
select * from buyer;
        ȸ����, �ֹι�ȣ, ��, ���ž��հ�

��)'������'�ŷ�ó�� ���� ������ �ּ����� �ΰ� �ִ� �ŷ�ó�� ��ȸ�Ͻÿ�
    �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, �����
select * from buyer;
-- self join
    select b.buyer_id �ŷ�ó�ڵ�, 
            b.buyer_name �ŷ�ó��, 
            b.buyer_add1||'-'||b.buyer_add2 �ּ�,
            b.buyer_charger �����
        from buyer a, buyer b
        where a.buyer_name ='������'
            and substr(a.buyer_add1,1,2) = substr(b.buyer_add1,1,2);

-- sub
select substr(buyer_add1,1,2)
    from buyer
    where buyer_name ='������';
    
    select buyer_id �ŷ�ó�ڵ�, 
            buyer_name �ŷ�ó��, 
            buyer_add1||'-'||buyer_add2 �ּ�,
            buyer_charger �����
        from buyer 
        where substr(buyer_add1,1,2) =(select substr(buyer_add1,1,2)
                                        from buyer
                                        where buyer_name ='������');
    
    