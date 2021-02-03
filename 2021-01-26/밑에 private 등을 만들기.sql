-- vo객체의 멤버변수를 자동으로 만들기
select 'private ' ||
    -- NUMBER일 때는 int , 그 외는 모두 String으로 한다.
    decode(lower(data_type), 'number', 'int ' , 'String ') ||
    lower(column_name) || ';'
    from cols
    where lower(table_name) = 'lprod';
    
