2020-11-30-02) rollup�� cube
    - sum �Լ��� �׷캰 ���踸 ��ȯ�ϸ� ��ü �հ踦 ��ȯ���� ����
    - group by ���� ����� �÷��� �������θ� �����ȯ
ex)
select period, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by period, gubun
    order by 1,2;
    
1. rollup
    - group by ���� ���
    - rollup ������ ����� �÷����� �������� ������ ���谡 �ʿ��� ��� ���
    (�������)
    group by rollup(�÷���1(�÷���2,..])
    . rollup ���� ����� �÷��� ���� n���� �� n +1 ������ ���� ��ȯ
    . �÷���1�� �÷���2�� ������ ����(group by�� ����)
      �÷���1�� �������� ������ ����
      ��ü����;
      
   select period, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by rollup(period, gubun)
    order by 1,2;
    
    select sum(loan_jan_amt)
        from kor_loan_status;
        
��) �������̺��� �Ⱓ��, ������, ���к� �����ܾ��� �հ踦 ��ȸ�Ͻÿ�.
(group by ���� ���);
select period, region, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by period, region, gubun
    order by 1,2;
(rollup ������ ������ �Ҷ� ���� ���);
select period, region, gubun,
        sum(loan_jan_amt)
    from kor_loan_status
    group by cube(period, region, gubun)
    order by 1,2;
