2020-12-01-01)
2. cube(col1, col2,...)
    - �پ��� ����ó��(2^���� �÷���)
    - rollup�� ��� ����� ������ ������ ������� ����.
��)�����ܾ����̺�(kor_loan_status)���� �Ⱓ, ����, ���ⱸ�� �׸��� �̿��Ͽ� ���� ������ ��� ���踦 ��ȸ
    select period, region, gubun, sum(loan_jan_amt)
        from kor_loan_status
        group by cube(period, region, gubun)
        order by 1,2;
        
    select period, region, gubun, sum(loan_jan_amt)
        from kor_loan_status
        group by rollup(period, region, gubun)
        order by 1,2;