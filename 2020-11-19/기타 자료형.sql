2020-11-19-02)��Ÿ �ڷ���
    -2�� �ڷḦ �����ϱ� ���� �ڷ� Ÿ��
    -blob, raw, long law, bfile ���� ����
    1) raw
    - ��������� ���� �뷮�� 2�� �ڷḦ ����
    - �ε��� ó���� ����
    - oracle���� �ؼ��̳� ��ȯ�۾��� �������� ����
    - �ִ� 2000byte���� ó�� ����
    -16������ 2���� ����
    (�������)
    �÷��� raw(ũ��)
    
    ��)
    create table temp07(
        col1 raw(1000),
        col2 raw(2000)
        );
        
    INSERT INTO temp07
        VALUES (hextoraw('3De5ff77'),hextoraw('00'));
    insert into temp07
        values('00111101111011111111111011110111','00000000');
select * from temp07;

2)bfile
    - �����ڷ� ����
    - ��� �����ڷḦ �����ͺ��̽� �ܺο� ����
    - ��� ����(directory ��ü)������ ���̺� ����
    - 4gb���� ���� ����
    (�������)
    �÷��� bfile
        .���丮 ��Ī(alias) ����(30byte)�� ���ϸ�(256byte)����
    
    �׸����� �������
    1. �׸����� ����� ���� Ȯ��
    2. ���丮 ��ü ���� - �׸��� ����� ���丮�� ���� �ּ�
        create directory test_dir as 'D:\A_TeachingMaterial\2.Oracle\other';
    3. �׸��� ������ ���̺� ����
        create table temp08(
            col bfile);
    4. �׸��� �����Ѵ�.
        insert into temp08
            values(bfilename('test_dir', 'SAMPLE.PNG'));
        select * from temp08;
        
    - �����ڷ� ����
    - ��� �����ڷḦ �����ͺ��̽� ���ο� ����
    - 4gb���� ���� ����
    (��밡��)
    �÷��� blob
    
    (�׸��������)
    1.�׸����� �غ�(SAMPLE.PNG)
    2.���丮��ü ����(test_dir)
    3.�͸��ϻ���
    
    declare
    l_dir varchar2(20):='test_dri';
    l_file varchar2(30):='SAMPLE.PNG';
    l_bfile bfile;
    l_blob blob;
    begin
    insert into temp08(col1) values(empty_blob())
        return col1 into l_blob;
    
    l_bfile := bfilename(l_dir, l_file);
    dbms_lob.fileopen(l_bfile, dbms_lob.file_readonly);
    dbms_lob.loadfromfile(l_blob,l_bfile,dbms_lob.getlength(l_bfile));
    dbms_lob.fileclose(l_bfile);
    
    8-3*2-1+1 = 0
    
    end;
    commit;
        
        