-- vo��ü�� ��������� �ڵ����� �����
select 'private ' ||
    -- NUMBER�� ���� int , �� �ܴ� ��� String���� �Ѵ�.
    decode(lower(data_type), 'number', 'int ' , 'String ') ||
    lower(column_name) || ';'
    from cols
    where lower(table_name) = 'lprod';
    
