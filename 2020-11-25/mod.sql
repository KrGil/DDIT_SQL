2020-11-25-02)
4.mod(n,c), remainder(n,c)
    - n�� c�� ���� ������
    - ���ο��� ���� �ٸ� �Լ��� ����Ͽ� �������� ����
    mod : n -c * floor(n/c)
    remainder : n - c* round(n/c)
        ** floor(n) : n�� ���ų� �����ʿ��� ���� ū ����(n�� �ʰ����� �ʴ� �ִ� ����)
        select mod(11,3), remainder(11,3) from dual;
    mod(10,3) : 10 - 3 * floor(10/3)
                10 - 3 * floor(3.33333)
                10 - 3*3 => 10-9 =>1
    remainder(10,3) : 10 - 3 * round(10/3)
                    10 - 3 * round(3.33333)
                    10 - 3 *3 => 10-9 =>1
                    
    mod(11,3) : 11 - 3 * floor(11/3)
                11 - 3 * floor(3.33333)
                11 - 3*3 => 11-9 =>2
    remainder(11,3) : 10 - 3 * round(10/6)
                     10 - 3 * round(3.666666)
                     10 - 3 *4 => 11-12 =>-1
                     
5. floor(n), ceil(n)
    -floor : n�� �ʰ����� �ʴ� �ִ�����
    -ceil : n�� ���ų� n���� ū ���� ���� ���� --�ø�
            .�Ҽ����� ������ �ʴ� �÷��� ���� �����Ͱ� �Է� �� ��� �Ҽ����� ������ �ݿø��Ͽ�
            �����ڷḸ �����ϴ� ��� �ַ� ���(�޿�, ���� ���� ��� �׸� �ַ� ���)
��)
select floor(-10), floor(-10.234), ceil(-10), ceil(-10.001) from dual;
select floor(-10), floor(-10.234), ceil(10), ceil(10.001) from dual;

6. width_bucket(n, min, max,b)
    - min�� max ���̸� b���� �������� �������� ��� �־��� �� n�� ��� ������ ���ϴ����� ��ȯ
    select width_bucket(90, 1, 100, 10) from dual;
��) ȸ�����̺��� ȸ������ ������ ���ϸ����� 1~10000���̸� 10�� �������� ������ �� ȸ���� ���� ���� ���� ��ȸ�Ͻÿ�.
    select mem_id ȸ����ȣ, mem_name ȸ����, mem_mileage ���ϸ���,
            width_bucket(mem_mileage, 1, 10000, 10) ������,
            width_bucket(mem_mileage, 10000, 1, 10) ���
        from member;

��) ������̺��� �޿��� 2000 ~ 30000�� 3���� �������� ������ �� �������� 1�ΰ��
    '�����޿�', 2�� ��� '�߰��޿�', 3�ΰ�� '�� �ӱ�' �̶�� �޼����� ������ ����Ͻÿ�
    select * from employees;
    select employee_id �����ȣ, emp_name �����, department_id �μ��ڵ�, salary �޿�, 
            width_bucket(salary, 2000, 30000, 3) ������,
            case when width_bucket(salary, 2000, 30000, 3) = 3 then '���ӱ�'
                when width_bucket(salary, 2000, 30000, 3) = 2 then '���ӱ�'
                else '���ӱ�' end ���
        from employees;
    
��) ������̺��� �޿��� 2000 ~ 30000�� 3���� �������� ������ �� �������� 1�ΰ��
    '�����޿�', 2�� ��� '�߰��޿�', 3�ΰ�� '�� �ӱ�' �̶�� �޼����� ������ ����Ͻÿ�.
    select* from employees;
    select employee_id �����ȣ, emp_name �����, department_id �μ��ڵ�, salary �޿�, 
            width_bucket(salary, 2000, 30000, 3) ������,
            case when width_bucket(salary, 2000, 30000, 3)=1 then '���� �޿�'
                when width_bucket(salary, 2000, 30000, 3)=2 then '�߰� �޿�'
            else '�� �ӱ�' end ���
        from employees; 
            
            
            
            
            