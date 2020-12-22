2020-11-27-01)
1. to_number(c[,fmt])
 - 숫자형식으로 제공된 문자열을 숫자형으로 변환
 - 사용되는 fmt는 to_char에서 사용하는 형식지정 문자열과 동일
 예) 오늘이 2005년 7월 28일이고 'h001'회원이 상품'P201000003'을 3개 구입했을 때
    cart테이블에 해당 내용을 삽입하시오.
    
    cart_no : 년월일+순번(5자리수)
            => '20050728';
             select '20050728'||trim(to_char(to_number(max(substr(cart_no, 9)))+1,'00000'))
                from cart
                where cart_no like '20050728%';
        
   insert into cart
            select 'g001', '20050728'||trim(to_char(to_number(max(substr(cart_no, 9)))+1,'00000')),
                    'P202000009',
                    13
                from cart
                where cart_no like '20050728%';
예) 사원테이블의 전화번호를 숫자로 변환
    select emp_name, to_number(replace(phone_number,'.'))
        from employees;
    
    select emp_name, to_number(replace(to_char(hire_date),'/'))
        from employees;
        
4.to_date(c[,fmt])
 - 날짜형식의 문자열을 날짜타입으로 변환
 - 형식지정문자열은 to_char의 형식지정 문자열과 동일
 
 예) 2005년 6월 13일 판매일보를 작성하시오.
    날짜, 상품코드, 판매수량, 구매자
    날짜, 상품코드, 판매수량, 구매자
    select * from cart;
    select to_date(substr(cart_no, 0, 8), 'YYYY-MM-DD') 날짜, 
            cart_prod 상품코드, 
            cart_qty 판매수량,
            cart_member 구매자
        from cart
        where substr(cart_no, 0,8) = '20050613'
        order by 3;
        