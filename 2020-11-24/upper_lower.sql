2020-11-24-01)
3) upper, lower 
    -주어진 문자열에 포함된 글자를 대문자(upper) 또는 소문자(lower)로
    변환하여 반환
    (사용형식)
    UPPER(c), lower(c)
예)회원테이블에서 'R001'회원 정보를 조회하시오
    select * from member;
    select mem_id 회원번호, mem_name 회원명, mem_job 직업, mem_mileage 마일리지
        from member
        where upper(mem_id) = ('R001');
     -- where mem_id = lower('R001');
예) 분류테이블에서 'P200'번의 대의 분류코드를 조회하시오
    select * from lprod;
    select lprod_gu 분류코드, lprod_nm 분류명
        from lprod
        where upper(lprod_gu) like 'P20%';
        
        
4) ascii, chr
    - ascii : 주어진 문자자료를 ascii 코드값으로 변환
    - chr : 주어진 숫자(정수, 1~65535)에 대응하는 문자 반환
예)
    select ascii('Oracle'),
            ascii('대한민국'),
            chr(95)
        from dual;
        
        
5) lpad, rpad
    - 특정문자열(패턴)을 사입할 때 사용
    (사용형식)
    lpad(c, n [,pattern]), rpad(c, n [,pattern])
    - 주어진 문자열 'c'를 길이 'n'의 기억공간에 왼쪽부터 채우고(rpad) |
        오른쪽부터 채우고(lpad) 남는 공간은 'parttern'으로 정의된 문자열을 채움
    - 'pattern'이 생략되면 공백으로 채워짐.
예)회원테이블에서 회원의 암호를 10 자리공간에 우측정렬하고 남는 공간에 '#'를 삽입하시오
    select * from member;
    select mem_id 회원번호,
            mem_name 회원명,
            mem_pass 암호, 
            lpad(mem_pass, 10, '#') 암호2
        from member;
예) 매입테이블에서 2005년 2월 매입현황을 조회하시오. 단, 매입단가는 9자리에 출력하되 남은 왼쪽 공간에 '*'를 삽입하여 출력
    select * from buyprod;
    select buy_date 날짜, buy_prod 매입상품코드, buy_qty 수량,
            lpad(buy_cost,9,'*') 단가
        from buyprod
--        where extract(year from buy_date) = 2005 and extract(month from buy_date) = 2;
        where buy_date between '20050201' and '20050228';
        
        
6) ltrim, rtrim, trim
    - 주어진 분자열에서 왼쪽(ltrim) 또는 오른쪽(rtrim)에 존재하는 문자열을
        찾아 삭제할 때 사용
    - 양쪽에 존재하는 공백을 제거할때는 trim 사용
    (사용형식)
    ltrim(c1 [, c2]), rtrim(c1 [, c2]), trim(c1)
    -c2가 생략되면 공백을 삭제

예) 사원테이블의 사원명 컬럼의 데이터 타입을 char(80) 으로 변경하시오
alter table employees
    modify emp_name char(80);
예) 사원테이블에서 'Steven King' 사원정보를 조회하시오
    select * from employees;
    select employee_id 사원번호, trim(emp_name) 사원명, department_id 부서코드, hire_date 입사일
        from employees
        where trim(emp_name)='Steven King';
예) 상품테이블에서 '대우'로 시작하는 상품명중 '대우'를 삭제하고 출력하시오
    select * from prod;
    select prod_id 상품코드, prod_name 상품명1, ltrim(prod_name, '대우 ') 상품명2, prod_lgu 분류코드, prod_buyer 거래처코드
        from prod
        where prod_name like '대우%';


7) substr(c, n1[, n2])
    - 주어진 문자열에서 n1에서 시작하여 n2(갯수)만큼(총 문자갯수)의 부분 문자열을 추출하여 반환
    - n2가 생략되면 n1 이후의 모든 문자열을 추출하여 반환
    - n1가 음수이면 뒤에서 부터 처리됨
    - n1은 1부터 counting

예)
    select substr('IL postino', 3,4),
            substr('ILpostino', 3,4),
            substr('IL postino', 3),
            substr('IL postino', -3,2)
        from dual;
예) 상품테이블에서 분류코드'P201'에 속한 상품의 사지수를 출력하시오
    select * from prod;
    select count(*) "상품의 수"
        from prod
        where upper(substr(prod_id, 1, 4)) = 'P201';
예) 장바구니테이블에서 2005년 3월에 판매된 상품정보를 상품별로 출력하시오
    select *from cart;
    select a.cart_prod 상품코드,
            b.prod_name 상품명,
            nvl(sum(a.cart_qty),0) 수량합계,
            nvl(sum(a.cart_qty* b.prod_price),0) 판매금액
        from cart a, prod b
        where substr(cart_no,1,6) = '200507' -- cart_no like '200503%'
            and a.cart_prod = b.prod_id
        group by a.cart_prod, b.prod_name
        order by 1;
예제) 회원테이블에서 '대전'에 살고있는 회원정보를 조회하시오 단, like연산자를 사용하지 말것
    select * from member;
    select mem_id 회원번호, mem_name 회원명, mem_add1 || '-' || mem_add2 주소, mem_job 직업, mem_mileage 마일리지
        from member
        where substr(mem_add1, 1, 2) = '대전';
        
예제) 오늘이 2005년 7월 28일이라고 가정하고 cart_no를 자동으로 생성하는 코드를 작성하시오.
--    1. 2005년 7월 28일 최대 순번 max
        select to_number(max(substr(cart_no,9))+1)
        from cart
        where substr(cart_no,1,8)= '20050728';
--    2. 날짜와 1번에서 구한 순번을 결합
        select to_char(sysdate,'YYYYMMDD')||
                trim(to_char(to_number(max(substr(cart_no,9))+1),'00000'))
            from cart
            where substr(cart_no,1,8)='20050728';
    
    select max(cart_no)+1
        from cart
        where substr(cart_no,1,8) = '20050728';

예제) 분류테이블에서 '여성정장' 분류코드를 신규로 등록시킬때 'P200'번대의 코드를 생성하시오.
    select * from prod;
    --max함수 숫자일 때만 전체의 수를 구할 수 있음.
    select 'P'||(max(substr(lprod_gu,2))+1)
        from lprod
        where lprod_gu like 'P2%';
        
8) replace(c1, c2[, c3]) -- 'sad    adfas' 안의 공백 없앨때
    - 주어진 문자열 c1에서 c2를 c3로 대치(치환) 시킴
    - c3가 생략되면 c2를 제거함
    
예)상품테이블에서 상품명 중 '대우'를 찾아 'Apple'로 변경하시오
    select * from prod;
    select prod_name 상품명,replace(prod_name, '대우', 'Apple') 변경된상품명
        from prod
        where prod_name like '%대우%';

    select prod_id,
            prod_name,
        replace(prod_name,' ')
        from prod
        where prod_name like '%대우%';

9) length(c), lengthb(c)
    - 주어진 문자열에서 글자수(length) 또는 기억공간의 크기(byte수, lengthb)를 반환
    
    
    
    
    
    
    
    
        