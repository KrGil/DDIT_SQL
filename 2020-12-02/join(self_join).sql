2020-12-02-02) join
3. self join --무엇때문에 쓰는걸까?
    - 하나의 테이블을 테이블 별칭을 이용하여 2개의 테이블처럼
    자신의 테이블을 자신의 테이블과 join하는 방식
    
예)회원테이블에서 회원번호 'T001' 회원이 보유한 마일리지보다 많은
    마일리지를 보유한 회원을 조회하시오.
    회원번호, 회원명, 마일리지
select * from member;
--하나만 이용하기 subquary만
select mem_id, mem_name, mem_mileage
    from member
    where mem_mileage > (select mem_mileage
                            from member
                            where mem_id = 't001')
    order by 3 desc;
--sub쿼리 쓰기
select mem_mileage
    from member
    where mem_id = 't001';

--self_join
select b.mem_id 회원번호, b.mem_name 회원명, b.mem_mileage 마일리지
    from member a, member b --a: 'T001'회원, b: 전체회원
    where lower(a.mem_id) = 't001'
            and a.mem_mileage < b.mem_mileage;
            
--self_join + subquary
select a.mem_id 회원번호, a.mem_name 회원명, a.mem_mileage 마일리지
    from member as a, (select mem_mileage
                        from member
                        where mem_id = 't001') b --a: 전체회원 b: 'T001'회원의 마일리지
    where a.mem_mileage > b.mem_mileage;
    
예)장바구니테이블에서 't001'회원에게 판매한 2005년 월별 판매현황을 조회하시오.
select * from cart;
select * from prod;
select * from buyer;
        회원명, 주민번호, 월, 구매액합계

예)'마르죠'거래처와 같은 지역에 주소지를 두고 있는 거래처를 조회하시오
    거래처코드, 거래처명, 주소, 담당자
select * from buyer;
-- self join
    select b.buyer_id 거래처코드, 
            b.buyer_name 거래처명, 
            b.buyer_add1||'-'||b.buyer_add2 주소,
            b.buyer_charger 담당자
        from buyer a, buyer b
        where a.buyer_name ='마르죠'
            and substr(a.buyer_add1,1,2) = substr(b.buyer_add1,1,2);

-- sub
select substr(buyer_add1,1,2)
    from buyer
    where buyer_name ='마르죠';
    
    select buyer_id 거래처코드, 
            buyer_name 거래처명, 
            buyer_add1||'-'||buyer_add2 주소,
            buyer_charger 담당자
        from buyer 
        where substr(buyer_add1,1,2) =(select substr(buyer_add1,1,2)
                                        from buyer
                                        where buyer_name ='마르죠');
    
    