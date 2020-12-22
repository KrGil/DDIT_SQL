2020-12-21-02)트리거(trigger)

- 어떤 이벤트가 발생되면 그 이벤트로 인하여 다른 테이블의 값이 자동으로
변경(삽입/update,삭제) 되도록 구성된 프로시져
- 데이터 무결성 유지

    (사용형식)
    create trigger 트리거명
    [before|after] [insert|update|delete]
    on 테이블명
    [for each row]
    [when 조건]
    [declare]
    선언부; 필요없으면 생략해도 된다.
    begin
    트리거 처리문 ;
    end;
    .before|after : 트리거의 timming, 생략하면 after로 간주
    트리거 수행(트리거 처리문)이 이벤트 발생 전이면 before,
    이벤트 발생 후이면 after를 기술
    .'insert|update|delete' : 트리거 이벤트, 트리거를 발생시키는 원인으로
    or 연산자를 이용하여 복수개 정의 가능(ex insert or delete)

    .'for each row' : 행단위 트리거 발생시 기술, 생략하면 문장단위 트리거

    .'when 조건' : 행단위 트리거에서만 사용하며 트리거 이벤트에서 정의된 테이블에 이벤트가
    발생할 때 보다 구체적인 데이터 검색 조건부여시 사용

    - * 행단위와 문장단위 트리거
    (1) 문장단위 트리거 : 이벤트 발생시 오직 한번만 트리거 발생(많이 사용하지 않음)
    (2) 행단위 트리거 : 'for each row' 기술
    이벤트 결과 각 행마다 트리거 수행,
    의사레코드(pesudo record) 인 :new, :old 사용 가능
    대부분의 트리거가 속함
    단, 한 트리거 수행이 완료되지 않은 상태에서 또 다른 트리거를 호출
    할 경우 시스템에 의해 트리거 강제 종류

    예) 분류테이블에 새로운자료를 입력하고 입력이 정상적으로 처리되었으면
    '신규 분류자료가 정상 입력되었습니다.!!' 메세지를 출력하는 트리거를 작성하시오
    [자료]
    분류코드 : p502
    순번 : 12
    분류명 : 농산물

    create trigger tg_lprod01
    after insert on lprod
    begin
    dbms_output.put_line( '신규 분류자료가 정상 입력되었습니다.!!');
    end;

    insert into lprod
    values(12,'p502','농산물');
    select * from lprod;

    예) 입고테이블(buyprod)에서 2월과 3월 입고된 상품별 매입수량을 조회하여 재고수불테이블을
    수정하시오.
    (서브쿼리 : 2월과 3월 입고된 상품별 매입수량을 조회)

    SELECT buy_prod,
    SUM(buy_qty)
    FROM buyprod
    WHERE buy_date BETWEEN '20050201' AND '20050331'
    GROUP BY buy_prod
    ORDER BY 1;

    (메인쿼리 : remain테이블 UPDATE)
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

    ## 예) 오늘이 2005년 4월 1일이라고 가정하고 다음 자료를 장바구니 테이블에 입력하시오.
    장바구니테이블에 입력된 후 재고수불테이블을 수정하시오
    입력자료 : (29, 21, 0, 50, 2005-01-31:remain테이블의 자료)
    구매회원 : c001
    구매상품 : P302000014
    구매수량 : 5

    (트리거)
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
    (실행 : CART테이블에 자료가 삽입된 후)
    INSERT INTO cart
    SELECT 'c001', max(cart_no) + 1, 'P302000014', 5
    FROM cart
    WHERE SUBSTR(cart_no, 1, 8) = '20050401'