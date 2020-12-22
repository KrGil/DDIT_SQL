2020-11-30-02) rollup과 cube
    - sum 함수는 그룹별 집계만 반환하며 전체 합계를 반환하지 않음
    - group by 절에 기술된 컬럼을 기준으로만 집계반환
ex)
select period, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by period, gubun
    order by 1,2;
    
1. rollup
    - group by 절에 사용
    - rollup 다음에 기술된 컬럼들을 기준으로 레벨별 집계가 필요한 경우 사용
    (사용형식)
    group by rollup(컬럼명1(컬럼명2,..])
    . rollup 다음 기술된 컬럼의 수가 n개일 때 n +1 종류의 집계 반환
    . 컬럼명1과 컬럼명2를 적용한 집계(group by와 동일)
      컬럼명1을 기준으로 적용한 집계
      전체집계;
      
   select period, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by rollup(period, gubun)
    order by 1,2;
    
    select sum(loan_jan_amt)
        from kor_loan_status;
        
예) 대출테이블에서 기간별, 지역별, 구분별 대출잔액의 합계를 조회하시오.
(group by 절만 사용);
select period, region, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by period, region, gubun
    order by 1,2;
(rollup 계층별 집계사용 할때 자주 사용);
select period, region, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by cube(period, region, gubun)
    order by 1,2;
