2020-11-27 -- 숙제

2005년 상반기(1-6월) 거래처별 매입현황을 조회하시오
    거래처코드, 거래처명, 매입수량, 매입금액
select * from buyer; -- 여기에 거래처명 c.buyer_lgu
select * from buyprod; --여기에 매입금액 매입수량 
select buyer_lgu 거래처코드, buyer_name 거래처명 -- sum(b.buy_qty) 매입수량, sum(b.buy_cost) 매입금액
    from buyer;--, b.buyprod
   -- where a.buyer_lgu = substr(b.prod_buyer,1,4);

select substr(buy_prod,1,4) buy_id,
        sum(buy_qty) t_qty,
        sum(buy_cost) t_cost
    from buyprod
    group by substr(buy_prod,1,4);

select a.buyer_lgu 거래처코드, 
        a.buyer_name 거래처명, 
        c.t_qty 매입수량, 
        c.t_cost 매입금액-- sum(b.buy_qty) 매입수량, sum(b.buy_cost) 매입금액
    from buyer a, (select substr(buy_prod,1,4) buy_id, buy_date daa,
                        sum(buy_qty) t_qty, 
                        sum(buy_cost) t_cost
                    from buyprod
                    group by substr(buy_prod,1,4),  buy_date) c
    where a.buyer_lgu = c.buy_id
        and extract(year from c.daa) = 2005
        and extract(month from c.daa) between 01 and 06
    order by 1;
    
예) 사원테이블을 이용하여 부서별 급여합계를 구하시오
    부서코드, 부서명, 급여합계
    select A.department_id as 부서코드,
            B.department_name as 부서명,
            sum(a.salary) as 급여합계
        from employees a, departments b
        where a.department_id = b.department_id
        group by a.department_id, b.department_name;