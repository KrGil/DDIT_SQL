2020-12-01-01)
2. cube(col1, col2,...)
    - 다양한 집계처리(2^사용된 컬럼수)
    - rollup과 사용 방식은 같으나 레벨이 적용되지 않음.
예)대출잔액테이블(kor_loan_status)에서 기간, 지역, 대출구분 항목을 이용하여 조합 가능한 모든 집계를 조회
    select period, region, gubun, sum(loan_jan_amt)
        from kor_loan_status
        group by cube(period, region, gubun)
        order by 1,2;
        
    select period, region, gubun, sum(loan_jan_amt)
        from kor_loan_status
        group by rollup(period, region, gubun)
        order by 1,2;