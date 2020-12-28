--------------------------------------------------------
--  DDL for Table ALIAS
--------------------------------------------------------

  CREATE TABLE "ALIAS" 
   (	"ALIAS_CODE" VARCHAR2(50 BYTE), 
	"MEM_ID" VARCHAR2(50 BYTE), 
	"ALIAS_NAME" VARCHAR2(50 BYTE) DEFAULT 'GUEST'
   ) ;

   COMMENT ON COLUMN "ALIAS"."ALIAS_CODE" IS '�����ڵ�';
   COMMENT ON COLUMN "ALIAS"."MEM_ID" IS '���̵�';
   COMMENT ON COLUMN "ALIAS"."ALIAS_NAME" IS '�����̸�';
   COMMENT ON TABLE "ALIAS"  IS '����';
--------------------------------------------------------
--  DDL for Table CARD
--------------------------------------------------------

  CREATE TABLE "CARD" 
   (	"CARD_CODE" VARCHAR2(50 BYTE), 
	"CARD_COM" VARCHAR2(50 BYTE), 
	"CARD_NO" NUMBER(16,0), 
	"MEM_ID" VARCHAR2(50 BYTE), 
	"CARD_CVC" NUMBER(3,0), 
	"CARD_NAME" VARCHAR2(50 BYTE)
   ) ;

   COMMENT ON COLUMN "CARD"."CARD_CODE" IS 'ī���ڵ�';
   COMMENT ON COLUMN "CARD"."CARD_COM" IS 'ī���';
   COMMENT ON COLUMN "CARD"."CARD_NO" IS 'ī���ȣ';
   COMMENT ON COLUMN "CARD"."MEM_ID" IS '���̵�';
   COMMENT ON COLUMN "CARD"."CARD_CVC" IS 'ī��cvc';
   COMMENT ON COLUMN "CARD"."CARD_NAME" IS 'ī�庰��';
   COMMENT ON TABLE "CARD"  IS 'ī��';
--------------------------------------------------------
--  DDL for Table MEMBER
--------------------------------------------------------

  CREATE TABLE "MEMBER" 
   (	"MEM_ID" VARCHAR2(50 BYTE), 
	"MEM_JOINDATE" DATE DEFAULT SYSDATE, 
	"MEM_PASSWORD" VARCHAR2(50 BYTE), 
	"CARD_CODE" VARCHAR2(50 BYTE)
   ) ;

   COMMENT ON COLUMN "MEMBER"."MEM_ID" IS '���̵�';
   COMMENT ON COLUMN "MEMBER"."MEM_JOINDATE" IS '������';
   COMMENT ON COLUMN "MEMBER"."MEM_PASSWORD" IS '��й�ȣ';
   COMMENT ON COLUMN "MEMBER"."CARD_CODE" IS 'ī���ڵ�';
   COMMENT ON TABLE "MEMBER"  IS 'ȸ��';
--------------------------------------------------------
--  DDL for Table MEMBERSHIP
--------------------------------------------------------

  CREATE TABLE "MEMBERSHIP" 
   (	"MEMBERSHIP" VARCHAR2(50 BYTE), 
	"PRICE" NUMBER(8,0), 
	"ALIAS_NO" NUMBER(1,0) DEFAULT 0
   ) ;

   COMMENT ON COLUMN "MEMBERSHIP"."MEMBERSHIP" IS '�ɹ���';
   COMMENT ON COLUMN "MEMBERSHIP"."PRICE" IS '����';
   COMMENT ON COLUMN "MEMBERSHIP"."ALIAS_NO" IS '������';
   COMMENT ON TABLE "MEMBERSHIP"  IS '�ɹ���';
--------------------------------------------------------
--  DDL for Table MOVIE
--------------------------------------------------------

  CREATE TABLE "MOVIE" 
   (	"MOVIE_CODE" VARCHAR2(50 BYTE), 
	"MOVIE_NAME" VARCHAR2(50 BYTE), 
	"TYPE_LGU" VARCHAR2(50 BYTE), 
	"MOVIE_VIEWCNT" NUMBER(5,0), 
	"MOVIE_OPENDATE" DATE, 
	"MOVIE_DETAIL" VARCHAR2(500 BYTE), 
	"MOVIE_SCORE" NUMBER(5,0)
   ) ;

   COMMENT ON COLUMN "MOVIE"."MOVIE_CODE" IS '��ȭ�ڵ�';
   COMMENT ON COLUMN "MOVIE"."MOVIE_NAME" IS '��ȭ�̸�';
   COMMENT ON COLUMN "MOVIE"."TYPE_LGU" IS '��ȭ�з��ڵ�';
   COMMENT ON COLUMN "MOVIE"."MOVIE_VIEWCNT" IS '��ȸ��';
   COMMENT ON COLUMN "MOVIE"."MOVIE_OPENDATE" IS '������';
   COMMENT ON COLUMN "MOVIE"."MOVIE_DETAIL" IS '��ȭ����';
   COMMENT ON COLUMN "MOVIE"."MOVIE_SCORE" IS '����';
   COMMENT ON TABLE "MOVIE"  IS '��ȭ';
--------------------------------------------------------
--  DDL for Table PAY
--------------------------------------------------------

  CREATE TABLE "PAY" 
   (	"PAY_CODE" VARCHAR2(50 BYTE), 
	"MEM_ID" VARCHAR2(50 BYTE), 
	"MEMBERSHIP" VARCHAR2(50 BYTE), 
	"PAY_DATE" DATE
   ) ;

   COMMENT ON COLUMN "PAY"."PAY_CODE" IS '�����ڵ�';
   COMMENT ON COLUMN "PAY"."MEM_ID" IS '���̵�';
   COMMENT ON COLUMN "PAY"."MEMBERSHIP" IS '�ɹ���';
   COMMENT ON COLUMN "PAY"."PAY_DATE" IS '������';
   COMMENT ON TABLE "PAY"  IS '����';
--------------------------------------------------------
--  DDL for Table PICK_CHART
--------------------------------------------------------

  CREATE TABLE "PICK_CHART" 
   (	"MOVIE_CODE" VARCHAR2(50 BYTE), 
	"ALIAS_CODE" VARCHAR2(50 BYTE)
   ) ;

   COMMENT ON COLUMN "PICK_CHART"."MOVIE_CODE" IS '��ȭ�ڵ�';
   COMMENT ON COLUMN "PICK_CHART"."ALIAS_CODE" IS '�����ڵ�';
   COMMENT ON TABLE "PICK_CHART"  IS '����';
--------------------------------------------------------
--  DDL for Table SCORE
--------------------------------------------------------

  CREATE TABLE "SCORE" 
   (	"SCORE_CODE" VARCHAR2(50 BYTE), 
	"MOVIE_CODE" VARCHAR2(50 BYTE), 
	"ALIAS_CODE" VARCHAR2(50 BYTE), 
	"SCORE_GOOD" NUMBER(5,0)
   ) ;

   COMMENT ON COLUMN "SCORE"."SCORE_CODE" IS '�����ڵ�';
   COMMENT ON COLUMN "SCORE"."MOVIE_CODE" IS '��ȭ�ڵ�';
   COMMENT ON COLUMN "SCORE"."ALIAS_CODE" IS '�����ڵ�';
   COMMENT ON COLUMN "SCORE"."SCORE_GOOD" IS '���ƿ�';
   COMMENT ON TABLE "SCORE"  IS '����';
--------------------------------------------------------
--  DDL for Table TYPE
--------------------------------------------------------

  CREATE TABLE "TYPE" 
   (	"TYPE_LGU" VARCHAR2(50 BYTE), 
	"TYPE_INDEX" NUMBER(5,0), 
	"TYPE_NAME" VARCHAR2(50 BYTE)
   ) ;

   COMMENT ON COLUMN "TYPE"."TYPE_LGU" IS '��ȭ�з��ڵ�';
   COMMENT ON COLUMN "TYPE"."TYPE_INDEX" IS '�ε���';
   COMMENT ON COLUMN "TYPE"."TYPE_NAME" IS '��ȭ�帣';
   COMMENT ON TABLE "TYPE"  IS '��ȭ�帣';
--------------------------------------------------------
--  DDL for Table WATCH
--------------------------------------------------------

  CREATE TABLE "WATCH" 
   (	"WATCH_CODE" VARCHAR2(50 BYTE), 
	"MOVIE_CODE" VARCHAR2(50 BYTE), 
	"ALIAS_CODE" VARCHAR2(50 BYTE), 
	"WATCH_DATE" DATE
   ) ;

   COMMENT ON COLUMN "WATCH"."WATCH_CODE" IS '��û�ڵ�(��ȭ�ڵ�00001)';
   COMMENT ON COLUMN "WATCH"."MOVIE_CODE" IS '��ȭ�ڵ�';
   COMMENT ON COLUMN "WATCH"."ALIAS_CODE" IS '�����ڵ�';
   COMMENT ON COLUMN "WATCH"."WATCH_DATE" IS '��û��¥';
   COMMENT ON TABLE "WATCH"  IS '��û';
REM INSERTING into ALIAS
SET DEFINE OFF;
Insert into ALIAS (ALIAS_CODE,MEM_ID,ALIAS_NAME) values ('flex1','flex','sujin');
Insert into ALIAS (ALIAS_CODE,MEM_ID,ALIAS_NAME) values ('flex2','flex','byounggil');
Insert into ALIAS (ALIAS_CODE,MEM_ID,ALIAS_NAME) values ('flex3','flex','seil');
REM INSERTING into CARD
SET DEFINE OFF;
Insert into CARD (CARD_CODE,CARD_COM,CARD_NO,MEM_ID,CARD_CVC,CARD_NAME) values ('sa1234789','SAMSUMG',123456789123,'flex',789,'��ī��');
REM INSERTING into MEMBER
SET DEFINE OFF;
Insert into MEMBER (MEM_ID,MEM_JOINDATE,MEM_PASSWORD,CARD_CODE) values ('flex',to_date('2020/12/24','RRRR/MM/DD'),'1234','sa1234789');
REM INSERTING into MEMBERSHIP
SET DEFINE OFF;
Insert into MEMBERSHIP (MEMBERSHIP,PRICE,ALIAS_NO) values ('NON',0,0);
Insert into MEMBERSHIP (MEMBERSHIP,PRICE,ALIAS_NO) values ('BASIC',9500,1);
Insert into MEMBERSHIP (MEMBERSHIP,PRICE,ALIAS_NO) values ('STANDARD',12000,2);
Insert into MEMBERSHIP (MEMBERSHIP,PRICE,ALIAS_NO) values ('PREMIUM',14500,4);
REM INSERTING into MOVIE
SET DEFINE OFF;
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13001','����','130',52,to_date('2018/06/22','RRRR/MM/DD'),'�ѳ����� ���� ����Ż���..',10);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13002','����','130',22,to_date('2013/09/24','RRRR/MM/DD'),'�ܰ����ü ''�ɺ��Ʈ''�� ������ ���� ������ �����ϸ� �ɷ��� �����ϴ� ''����''....',60);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13003','��Ű���','130',44,to_date('2012/11/24','RRRR/MM/DD'),'����� ���ӡ��� ���� �ݸ����� �Ҽ� �ø��� ����� ���� ����ۡ��� ��ȭȭ�� �Ϸ��� �ø����̴�....',48);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13004','���ͽ��ڶ�','130',26,to_date('2006/05/15','RRRR/MM/DD'),'�츰 ���� ã�� �ž�, �� �׷����̡����� ������ ���ο� ������ ������ �ر��� �̷��� �ٰ��´�....',99);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13005','�������','130',88,to_date('2001/07/14','RRRR/MM/DD'),'������ ��� 1984���� 2020�� ������ �̱��� ��������� ��ȭ��, 2017�� ��ȭ ��������ա�...',87);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13006','�丣','130',46,to_date('2010/08/06','RRRR/MM/DD'),'�丣 ����(Thor Odinson)�� ���� �ڹͽ��� ����������̴�. ������ ��ȭ���� ������ �� �丣�� ���....',56);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13007','�͹̳�����','130',32,to_date('2012/01/01','RRRR/MM/DD'),'������ �η��� �����ϱ� ���� ���ʳⰣ ġ���� �������� ������. �׷��� ������ ������ ���� ����� ������ �̷��� �ƴ� �츮��....',25);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13008','�ظ�����','130',13,to_date('2019/06/08','RRRR/MM/DD'),'�̸�� �� ��� �� ���忡�� ��Ȱ�ϴ� 11�� �ҳ� �ظ� ���Ͱ� ȣ�׿�Ʈ �����б��� ���鼭 �ް� �Ǵ� ��Ÿ��....',46);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13009','ŷ����','130',25,to_date('2021/01/08','RRRR/MM/DD'),'���󿡼� ���� ������ ������ ���۵ȴ�! ���� IQ, �ִϾ� ü����ȸ 2�� ���� ���! �׷��� �б� ����, �غ��� �ߵ� ����.���� �нο� ����.....',13);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('13010','�ΰ�','130',79,to_date('2021/01/23','RRRR/MM/DD'),'����� �̷�, �ɷ��� �Ҿ�� ���ΰ�(�����)���� �߽��� ���� ��ó�� �� ����ó���� ���� �������伭 X���� ������ ��ư���.....',22);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15001','�ݵ�','150',99,to_date('2014/06/05','RRRR/MM/DD'),'�λ����� �������� �̹����� �ѹݵ� ��ü��! .....',18);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15002','�پƿ�','150',13,to_date('2014/09/24','RRRR/MM/DD'),'���� ���ڰ� ���� ����ģ�� ���� �ʴ� �����鼭 �������� �̾߱�....',46);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15003','�ֳ���','150',64,to_date('2011/09/09','RRRR/MM/DD'),'1971�� ���� �κ�, �ε� ���Ϸ��忡 �����ϴ� ��� �������� �Ͼ ���ڿ��� ��� �ذ�...',67);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15004','�λ���','150',42,to_date('2017/07/28','RRRR/MM/DD'),'��ü�Ҹ��� ���̷����� �������� Ȯ��ǰ� ���ѹα� ����糭�溸���� ������ ���,������ ���� ���� ������� �� �ϳ���....',12);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15005','�װ�','150',46,to_date('2006/02/28','RRRR/MM/DD'),'���ΰ� ��������� �̻��ϰ� ���� ����� ������� ����, �� ���� ��� �� ���̹踦 ��� ���� ������ �������.....',80);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15006','������','150',77,to_date('2004/07/02','RRRR/MM/DD'),'1971�� �ε� ���Ϸ���, �ظ�����. ��� ������ �޿� �׸��� �� ������ �̻縦 ����. ���� 1863�⿡ �� ������ �Ͼ ������ ���� ���....',78);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15007','â��','150',64,to_date('2003/07/08','RRRR/MM/DD'),'�㿡�� Ȱ���ϴ� �� �ڵ� ���� �ڵ� �ƴ� ���߱�(�С)���� â���� ����, ������ �������� ���ƿ� ����....',69);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15008','������','150',46,to_date('2017/12/24','RRRR/MM/DD'),'1979�� ȯ�� 42���� ���� �ڻ�� �������� ���� ����,������ �������� �ѷ����� ������ ���ź������ΰ���ü���� ���� 7���� �����....',38);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15009','����ִ�','150',86,to_date('2021/01/02','RRRR/MM/DD'),'������ �ٸ� �������̾߱�. ��ħ 10��. ��Ʃ�� �޳����� �ؿ�(������ ��)��. ��ҿ� ���� ��ʰԱ��� ������ ����.....',16);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('15010','���̶�','150',17,to_date('2021/01/20','RRRR/MM/DD'),'�縷 �� ���, ��� ����Ʈ ���̶��� ������ �߰��� ��(�� ũ����)�� ���̶��� ���� �����ϴ� �� �ǹ��� ����� �߶����� ����Ѵ�....',91);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12001','����Ʈ','120',95,to_date('2019/05/06','RRRR/MM/DD'),'���б� ��� ���Ƹ� ���̽� ��������� ���� �� �� ��° ��� ���з� ��ĩ�丸 �Դ� �볲�� �� ������ ������ ��Ӵ��� ĥ�� ��ġ���� ��ȸ�� �������� ����� ���Ƹ� �Ĺ� ���ָ� ������....',80);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12002','��Ű','120',30,to_date('2017/03/15','RRRR/MM/DD'),'��Ȥ�� ų�� ����(������)�� ��� ó�� �� �쿬�� �鸥 ��������� �񴩸� ��� �Ѿ��� ������ ����� �Ұ� �ȴ�.....',20);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12003','��������','120',60,to_date('2018/08/16','RRRR/MM/DD'),'ġŲ���� ���� �� �� ���� �ٺ��� ����ݿ��� ��� �� ��ȣ�� ��ȸ�� ã�ƿ��µ��� ������ ���� ���ΰ�, ���� ���� ���ΰ�!',54);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12004','����','120',13,to_date('2015/03/07','RRRR/MM/DD'),'�λ��� ���� �β����� ������ �Բ� �� ������ �������� �� ģ���� ��ü�߱� �ڹ̵�!',32);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12005','Ž��','120',5,to_date('2013/02/17','RRRR/MM/DD'),'"�츮�� ���� �� ��������̶� ����" �ְ� Ʈ���� �޺��� ���� �߸��� ���۵ȴ�!',65);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12006','�Ϻ��� Ÿ��','120',71,to_date('2014/04/28','RRRR/MM/DD'),'7���� ģ������ ���� ���� ��Ƽ���� ������ �ϱ�� �����Ѵ�.',77);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12007','�̽�����','120',25,to_date('2018/05/19','RRRR/MM/DD'),'����� VIP�� ã�� ���� �ΰ��� �������� ����� ���÷��̰� ���۵ȴ�!',91);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12008','ȭ��ƮĢ��','120',63,to_date('2008/10/11','RRRR/MM/DD'),'�ݹ߹̳డ �� �׵�, �ƴ� �׳���� �˰��� ø������ �ɰ��ϴ� Ĭ���� ��Ƽ�� �Ѱ������� ����� �мǼ� �� ������� ��û�� ���Ȱ�� ������� �����ϴµ�...?!',13);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12009','�����ѱ׳�','120',99,to_date('2021/01/03','RRRR/MM/DD'),'���ѹα��� ���� �������� �Ȱ��� <������ �׳�>�� �´�!',25);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('12010','��İ��','120',11,to_date('2021/01/20','RRRR/MM/DD'),'��ũ���� �޺��� ����� �յ� ���簡 ��������!',5);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14001','�巡�� ����̱�','140',23,to_date('2009/05/09','RRRR/MM/DD'),'�巡����� ģ���� �� �����š�. �׵���� ���ο� ��Ȱ�� �����ϴ� �����š��� �巡����� ������ ����� �˰� �Ǵµ���',48);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14002','����','140',35,to_date('2010/07/03','RRRR/MM/DD'),'�������� �޲ٴ� �ҳ� �̱����� �������� ���� �����׽����� ��Ÿ�� ���� ��� ������ �ڵ��� ���󡯿� ���� �ȴ�.',66);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14003','�ܿ�ձ�','140',45,to_date('2018/09/01','RRRR/MM/DD'),'���ΰ� �ְ��� ģ������ �ڸ� �����硯�� ���ȳ���. ������ ��� �����硯���Դ� �ϳ����� ������������ �� ���� ����� �ִ�. ',35);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14004','��ũ������','140',68,to_date('2019/11/12','RRRR/MM/DD'),'�������� 15��, �̹� ���� �ʰ��� �㸮������ ƨ�ܹ��� ������ ���������� ���� �ٽ� ������ �������� ������ �� ������... ',79);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14005','�� �����','140',72,to_date('2017/03/02','RRRR/MM/DD'),'õ�� ���е� ���׵𡯰� ������ �����κ� �����̸ƽ���!',98);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14006','�˶��','140',98,to_date('2019/09/30','RRRR/MM/DD'),'Ű��� ������ �ƺο� �Բ� ��ư��� �Ʊ׶���� ������ �˶���� ��� �� �ñ��� Ż���� ��ź�� �� �ڽ��ο��� �Ѵ��� ���Ѵ�',13);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14007','�̴Ͼ���','140',89,to_date('2010/01/02','RRRR/MM/DD'),'�η��� ź���ϱ� �ξ� ���� ��, ���ʿ� �̴Ͼ��� �־���.',21);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14008','�����','140',3,to_date('2005/10/22','RRRR/MM/DD'),'���ø� ���� �ð�� �̻� �� ������Ű���� �����̡��� �쿬�� ���ӿ� ��� �ִ� �ź�ο� ����ü ������Ρ��� ���� �ź��� ������ �Բ� �Ѵ�.',65);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14009','���̽��丮','140',15,to_date('2021/01/04','RRRR/MM/DD'),'ī�캸�̿� ��������� ����� �� ������ ���� ������ ������ �ŷڸ� ���� �ȴ�.',88);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('14010','�λ��̵� �ƿ�','140',50,to_date('2021/01/19','RRRR/MM/DD'),'���� ����� �Ӹ��ӿ��� �������� ���� ��! �Ϸ翡�� ����� ���ϴ� ������ ����� ��������!',93);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16001','�Ƹ����� ����','160',95,to_date('1999/01/01','RRRR/MM/DD'),'�Ƹ����� ���ۼ� ���� �긮�� ��ȭ',88);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16002','�����Ҹ�','160',93,to_date('2011/11/11','RRRR/MM/DD'),'���������Ҹ����� ��ȭ',67);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16003','�츮�� ����','160',1,to_date('2010/01/02','RRRR/MM/DD'),'�츮�� ������ �Ƹ��ٿ�',52);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16004','�� ���� ������','160',10,to_date('2008/01/12','RRRR/MM/DD'),'��Ÿ����� ���� �����Ա�',15);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16005','�� ���� ��','160',15,to_date('1998/05/07','RRRR/MM/DD'),'����!! �� ��������',47);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16006','��漼�� ȨĿ��','160',42,to_date('2004/01/02','RRRR/MM/DD'),'�� Ŀ��!!! �� ���� ȣ�� by �漼����',38);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16007','�λ��̵� �� ������','160',88,to_date('2007/07/06','RRRR/MM/DD'),'�ڹ��� �������ּ��� ������������',27);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16008','ǳ�� ������','160',25,to_date('2008/03/27','RRRR/MM/DD'),'ǳ�̷ο� ������ ����!',19);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16009','13��°','160',12,to_date('2021/01/22','RRRR/MM/DD'),'14��° �õ��Դϴ�.',27);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('16010','�� ų ��','160',5,to_date('2021/01/01','RRRR/MM/DD'),'����ų! �츮 ���̿� ������ �ִ�! ����,,',34);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11001','��ٿ�Ÿ��','110',83,to_date('2001/03/05','RRRR/MM/DD'),'�ð��� ������',18);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11002','���� �¸�','110',78,to_date('2002/04/06','RRRR/MM/DD'),'���� ����',81);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11003','����','110',42,to_date('2003/04/02','RRRR/MM/DD'),'���� ����',64);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11004','��Ʈ��','110',66,to_date('2004/08/02','RRRR/MM/DD'),'�츮 ��� ��Ʈ������ �۾��սô�',50);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11005','�� ���� ��','110',20,to_date('2005/03/07','RRRR/MM/DD'),'�� ���� ��',37);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11006','���� ��ȥ��','110',24,to_date('2006/03/07','RRRR/MM/DD'),'��ź',18);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11007','Ÿ��Ÿ��','110',99,to_date('1995/01/01','RRRR/MM/DD'),'���ʳ� ���� ����',27);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11008','���� �ҳ�ô�','110',12,to_date('2007/06/21','RRRR/MM/DD'),'�������� ��������',38);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11009','������ ����','110',34,to_date('2021/01/18','RRRR/MM/DD'),'���� ����Ŭ�� �����Ѵ�.',15);
Insert into MOVIE (MOVIE_CODE,MOVIE_NAME,TYPE_LGU,MOVIE_VIEWCNT,MOVIE_OPENDATE,MOVIE_DETAIL,MOVIE_SCORE) values ('11010','���� ������ ����','110',62,to_date('2021/01/08','RRRR/MM/DD'),'���� �ڹٿ� �����Ѵ�.',38);
REM INSERTING into PAY
SET DEFINE OFF;
Insert into PAY (PAY_CODE,MEM_ID,MEMBERSHIP,PAY_DATE) values ('flexP01','flex','PREMIUM',to_date('2020/12/24','RRRR/MM/DD'));
REM INSERTING into PICK_CHART
SET DEFINE OFF;
Insert into PICK_CHART (MOVIE_CODE,ALIAS_CODE) values ('13001','flex1');
REM INSERTING into SCORE
SET DEFINE OFF;
Insert into SCORE (SCORE_CODE,MOVIE_CODE,ALIAS_CODE,SCORE_GOOD) values ('GOOD13001flex1','13001','flex1',1);
REM INSERTING into TYPE
SET DEFINE OFF;
Insert into TYPE (TYPE_LGU,TYPE_INDEX,TYPE_NAME) values ('110',1,'�θེ/���');
Insert into TYPE (TYPE_LGU,TYPE_INDEX,TYPE_NAME) values ('120',2,'�ڹ̵�');
Insert into TYPE (TYPE_LGU,TYPE_INDEX,TYPE_NAME) values ('130',3,'SF/��Ÿ��');
Insert into TYPE (TYPE_LGU,TYPE_INDEX,TYPE_NAME) values ('140',4,'�ִϸ��̼�');
Insert into TYPE (TYPE_LGU,TYPE_INDEX,TYPE_NAME) values ('150',5,'����/������');
Insert into TYPE (TYPE_LGU,TYPE_INDEX,TYPE_NAME) values ('160',6,'��ť');
REM INSERTING into WATCH
SET DEFINE OFF;
Insert into WATCH (WATCH_CODE,MOVIE_CODE,ALIAS_CODE,WATCH_DATE) values ('13001flex1','13001','flex1',to_date('2020/12/24','RRRR/MM/DD'));
--------------------------------------------------------
--  DDL for Index PK_ALIAS
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ALIAS" ON "ALIAS" ("ALIAS_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_CARD
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_CARD" ON "CARD" ("CARD_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_MEMBER
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_MEMBER" ON "MEMBER" ("MEM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_MEMBERSHIP
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_MEMBERSHIP" ON "MEMBERSHIP" ("MEMBERSHIP") 
  ;
--------------------------------------------------------
--  DDL for Index PK_MOVIE
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_MOVIE" ON "MOVIE" ("MOVIE_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_PAY
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_PAY" ON "PAY" ("PAY_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_PICK_CHART
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_PICK_CHART" ON "PICK_CHART" ("MOVIE_CODE", "ALIAS_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_SCORE
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_SCORE" ON "SCORE" ("SCORE_CODE") 
  ;
--------------------------------------------------------
--  DDL for Index PK_TYPE
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_TYPE" ON "TYPE" ("TYPE_LGU") 
  ;
--------------------------------------------------------
--  DDL for Index PK_WATCH
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_WATCH" ON "WATCH" ("WATCH_CODE") 
  ;
--------------------------------------------------------
--  Constraints for Table ALIAS
--------------------------------------------------------

  ALTER TABLE "ALIAS" ADD CONSTRAINT "PK_ALIAS" PRIMARY KEY ("ALIAS_CODE") ENABLE;
  ALTER TABLE "ALIAS" MODIFY ("MEM_ID" NOT NULL ENABLE);
  ALTER TABLE "ALIAS" MODIFY ("ALIAS_CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CARD
--------------------------------------------------------

  ALTER TABLE "CARD" ADD CONSTRAINT "PK_CARD" PRIMARY KEY ("CARD_CODE") ENABLE;
  ALTER TABLE "CARD" MODIFY ("MEM_ID" NOT NULL ENABLE);
  ALTER TABLE "CARD" MODIFY ("CARD_CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MEMBER
--------------------------------------------------------

  ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY ("MEM_ID") ENABLE;
  ALTER TABLE "MEMBER" MODIFY ("CARD_CODE" NOT NULL ENABLE);
  ALTER TABLE "MEMBER" MODIFY ("MEM_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MEMBERSHIP
--------------------------------------------------------

  ALTER TABLE "MEMBERSHIP" ADD CONSTRAINT "PK_MEMBERSHIP" PRIMARY KEY ("MEMBERSHIP") ENABLE;
  ALTER TABLE "MEMBERSHIP" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "MEMBERSHIP" MODIFY ("MEMBERSHIP" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MOVIE
--------------------------------------------------------

  ALTER TABLE "MOVIE" ADD CONSTRAINT "PK_MOVIE" PRIMARY KEY ("MOVIE_CODE") ENABLE;
  ALTER TABLE "MOVIE" MODIFY ("TYPE_LGU" NOT NULL ENABLE);
  ALTER TABLE "MOVIE" MODIFY ("MOVIE_CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PAY
--------------------------------------------------------

  ALTER TABLE "PAY" ADD CONSTRAINT "PK_PAY" PRIMARY KEY ("PAY_CODE") ENABLE;
  ALTER TABLE "PAY" MODIFY ("MEMBERSHIP" NOT NULL ENABLE);
  ALTER TABLE "PAY" MODIFY ("MEM_ID" NOT NULL ENABLE);
  ALTER TABLE "PAY" MODIFY ("PAY_CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PICK_CHART
--------------------------------------------------------

  ALTER TABLE "PICK_CHART" ADD CONSTRAINT "PK_PICK_CHART" PRIMARY KEY ("MOVIE_CODE", "ALIAS_CODE") ENABLE;
  ALTER TABLE "PICK_CHART" MODIFY ("ALIAS_CODE" NOT NULL ENABLE);
  ALTER TABLE "PICK_CHART" MODIFY ("MOVIE_CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SCORE
--------------------------------------------------------

  ALTER TABLE "SCORE" ADD CONSTRAINT "PK_SCORE" PRIMARY KEY ("SCORE_CODE") ENABLE;
  ALTER TABLE "SCORE" MODIFY ("ALIAS_CODE" NOT NULL ENABLE);
  ALTER TABLE "SCORE" MODIFY ("MOVIE_CODE" NOT NULL ENABLE);
  ALTER TABLE "SCORE" MODIFY ("SCORE_CODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TYPE
--------------------------------------------------------

  ALTER TABLE "TYPE" ADD CONSTRAINT "PK_TYPE" PRIMARY KEY ("TYPE_LGU") ENABLE;
  ALTER TABLE "TYPE" MODIFY ("TYPE_LGU" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table WATCH
--------------------------------------------------------

  ALTER TABLE "WATCH" ADD CONSTRAINT "PK_WATCH" PRIMARY KEY ("WATCH_CODE") ENABLE;
  ALTER TABLE "WATCH" MODIFY ("ALIAS_CODE" NOT NULL ENABLE);
  ALTER TABLE "WATCH" MODIFY ("MOVIE_CODE" NOT NULL ENABLE);
  ALTER TABLE "WATCH" MODIFY ("WATCH_CODE" NOT NULL ENABLE);
