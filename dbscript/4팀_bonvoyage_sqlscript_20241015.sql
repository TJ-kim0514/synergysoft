-- ǥ ���� �� ���� ������ ǥ ����
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE REPORT CASCADE CONSTRAINTS;
DROP TABLE QNA CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT CASCADE CONSTRAINTS;
DROP TABLE GUIDE_BOARD CASCADE CONSTRAINTS;
DROP TABLE ROUTE_BOARD CASCADE CONSTRAINTS;
DROP TABLE ROUTE CASCADE CONSTRAINTS;
DROP TABLE PLACE CASCADE CONSTRAINTS;
DROP TABLE LIKE_COUNT CASCADE CONSTRAINTS;
DROP TABLE CHATTING CASCADE CONSTRAINTS;

-- ������ ���� �� ���� ������ ������ ����
DROP SEQUENCE SEQ_NOTICE;
DROP SEQUENCE SEQ_REPORT;
DROP SEQUENCE SEQ_QNA;
DROP SEQUENCE SEQ_ROUTE_BOARD;
DROP SEQUENCE SEQ_ROUTE;
DROP SEQUENCE SEQ_PLACE;
DROP SEQUENCE SEQ_GUIDE_BOARD;
DROP SEQUENCE SEQ_COMMENT;

-- ǥ ����
CREATE TABLE MEMBER (
	MEM_ID	            VARCHAR2(255),
	MEM_NAME           VARCHAR2(255) NOT NULL,
	MEM_TYPE           VARCHAR2(255) DEFAULT 'USER' NOT NULL,
	MEM_PW             VARCHAR2(500),
	MEM_NICKNM         VARCHAR2(50) NOT NULL,
	MEM_JOIN_DATE	    DATE DEFAULT SYSDATE,
	MEM_PHONE	        VARCHAR2(30),
	MEM_BIRTH	        DATE,
	MEM_SOCIAL	        VARCHAR2(100),
	MEM_STATUS	        VARCHAR(255) NOT NULL,   -- ������� ���¸� 4������ ����. '���� : ACTIVE' , '���� : BLOCKED' , '�޸� : INACTIVE' , 'Ż�� : LEFT'
	MEM_LOGIN_LOG	    DATE,
	MEM_LOGOUT_LOG	    DATE,
	MEM_STATUS_DATE	DATE,
	MEM_PW_UPDATE	    DATE,
    CONSTRAINT PK_MEM_ID PRIMARY KEY (MEM_ID)
    , CONSTRAINT CHK_MEM_TYPE CHECK (MEM_TYPE IN ('USER', 'ADMIN'))
    , CONSTRAINT UQ_MEM_NICKNM UNIQUE (MEM_NICKNM)
    , CONSTRAINT CHK_MEM_STATUS CHECK (MEM_STATUS IN ('ACTIVE', 'BLOCKED', 'INACTIVE', 'LEFT'))
);

CREATE TABLE NOTICE (
	NOTICE_ID	    VARCHAR2(255),
	TITLE	        VARCHAR2(500) NOT NULL,
	CONTENT	    CLOB NOT NULL,
	ADMIN_ID	    VARCHAR2(255) NOT NULL,
	CREATED_AT	    DATE DEFAULT SYSDATE,
	UPDATED_AT	    DATE,
	UPDATE_CHECK	CHAR(1) DEFAULT 'N',
	DELETED_AT	    DATE,
	DELETE_CHECK	CHAR(1) DEFAULT 'N',
	OFILE1	        VARCHAR2(500),
	OFILE2	        VARCHAR2(500),
	OFILE3	        VARCHAR2(500),
    RFILE1	        VARCHAR2(500),
    RFILE2	        VARCHAR2(500),
    RFILE3	        VARCHAR2(500),
    READ_COUNT     NUMBER DEFAULT 0,
    CONSTRAINT PK_NOTICE_ID PRIMARY KEY (NOTICE_ID)
    , CONSTRAINT FK_NOTICE_ADMINID FOREIGN KEY (ADMIN_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
    , CONSTRAINT CHK_UPDATE_CHECK CHECK (UPDATE_CHECK IN ('Y', 'N'))
    , CONSTRAINT CHK_DELETE_CHECK CHECK (DELETE_CHECK IN ('Y', 'N'))
);

CREATE TABLE QNA (
	QNA_ID	        VARCHAR2(255),
	TITLE	        VARCHAR2(500) NOT NULL,
	USER_CONTENT	CLOB NOT NULL,
	USER_ID	        VARCHAR2(255) NOT NULL,
	Q_CREATED_AT	DATE DEFAULT SYSDATE,
	Q_UPDATED_AT	DATE,
	ADMIN_ID	    VARCHAR2(255),
	IS_ACCEPT	    CHAR(1) DEFAULT 'N',
	ADMIN_CONTENT	CLOB,
	A_CREATED_AT	DATE	DEFAULT SYSDATE,
    IS_SECRET       CHAR(1) DEFAULT 'Y',
    DELETE_AT       DATE DEFAULT SYSDATE,
    DELETE_CHECK    CHAR(1) DEFAULT 'N',
	OFILE1	        VARCHAR2(500),
	OFILE2	        VARCHAR2(500),
	OFILE3	        VARCHAR2(500),
	OFILE4	        VARCHAR2(500),
	OFILE5	        VARCHAR2(500),
    RFILE1	        VARCHAR2(500),
    RFILE2	        VARCHAR2(500),
    RFILE3	        VARCHAR2(500),
    RFILE4	        VARCHAR2(500),
    RFILE5	        VARCHAR2(500),
    CONSTRAINT PK_QNA_ID PRIMARY KEY (QNA_ID)
    , CONSTRAINT FK_QNA_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
    , CONSTRAINT FK_QNA_ADMINID FOREIGN KEY (ADMIN_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
    , CONSTRAINT CHK_IS_ACCEPT CHECK (IS_ACCEPT IN ('Y', 'N'))
);

CREATE TABLE "REPORT" 
   (	"REPORT_ID" VARCHAR2(255), 
	"POST_ID" VARCHAR2(255) NOT NULL ENABLE, 
	"REPORT_USER_ID" VARCHAR2(255) NOT NULL ENABLE, 
	"REPORTING_REASON" VARCHAR2(255) NOT NULL ENABLE, 
	"DETAIL" VARCHAR2(255) NOT NULL ENABLE, 
	"REPORT_DATE" DATE DEFAULT SYSDATE, 
	"CHECKED_ADMIN" CHAR(1), 
	"CHECKED_ADMIN_ID" VARCHAR2(255) NOT NULL ENABLE, 
	"CHECKED_ASSIGNED" CHAR(1), 
	"ASSIGNED_ADMIN_ID" VARCHAR2(255) NOT NULL ENABLE, 
	 CONSTRAINT "CHK_CHECKED_ADMIN" CHECK (CHECKED_ADMIN IN ('Y', 'N')) ENABLE, 
	 CONSTRAINT "CHK_CHECKED_ASSIGNED" CHECK (CHECKED_ASSIGNED IN ('Y', 'N')) ENABLE, 
	 CONSTRAINT "PK_REPORT_ID" PRIMARY KEY ("REPORT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
-- REPORT foreign keys
ALTER TABLE "REPORT" ADD CONSTRAINT "FK_REPORT_USER_ID" FOREIGN KEY ("REPORT_USER_ID") REFERENCES "MEMBER" ("MEM_ID") ON DELETE SET NULL ENABLE;
ALTER TABLE "REPORT" ADD CONSTRAINT "FK_CHECKED_ADMIN_ID" FOREIGN KEY ("CHECKED_ADMIN_ID") REFERENCES "MEMBER" ("MEM_ID") ENABLE;
ALTER TABLE "REPORT" ADD CONSTRAINT "FK_ASSIGNED_ADMIN_ID" FOREIGN KEY ("ASSIGNED_ADMIN_ID") REFERENCES "MEMBER" ("MEM_ID") ENABLE;


CREATE TABLE TB_COMMENT (
	COMMENT_ID	VARCHAR2(255),
	USER_ID	    VARCHAR2(255) NOT NULL,
	POST_ID	    VARCHAR2(255) NOT NULL,
	CONTENT	CLOB NOT NULL,
	CREATED_AT	DATE DEFAULT SYSDATE,
	UPDATED_AT	DATE,
    CONSTRAINT PK_COMMENT_ID PRIMARY KEY (COMMENT_ID)
    , CONSTRAINT FK_COMMENT_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

CREATE TABLE ROUTE_BOARD (
	ROUTE_BOARD_ID VARCHAR2(255),
	USER_ID	        VARCHAR2(255) NOT NULL,
	TITLE	        VARCHAR2(500) NOT NULL,
	CONTENT	    CLOB NOT NULL,
	TRANSPORT	    VARCHAR2(20),
	CREATED_AT	    DATE DEFAULT SYSDATE,
	UPDATED_AT	    DATE,
	LIKE_COUNT	    NUMBER DEFAULT 0,
	TOTAL_DURATION	NUMBER,
	ROUTE_NAME	    VARCHAR2(300),
	OFILE1	        VARCHAR2(500),
	OFILE2	        VARCHAR2(500),
	OFILE3	        VARCHAR2(500),
	OFILE4	        VARCHAR2(500),
	OFILE5	        VARCHAR2(500),
	RFILE1	        VARCHAR2(500),
	RFILE2	        VARCHAR2(500),
	RFILE3	        VARCHAR2(500),
	RFILE4	        VARCHAR2(500),
	RFILE5	        VARCHAR2(500),
    READ_COUNT     NUMBER DEFAULT 0,
    CONSTRAINT PK_ROUTE_BOARD_ID PRIMARY KEY (ROUTE_BOARD_ID)
    , CONSTRAINT FK_ROUTE_BOARD_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
);

CREATE TABLE PLACE (
	PLACE_ID	        VARCHAR2(255),
	PLACE_NAME	    VARCHAR2(255),
	ADDRESS 	    VARCHAR2(255),
	LATITUDE	        NUMBER,
	LONGITUDE	    NUMBER,
    PLACE_CONTENT   CLOB,
    ROUTE_BOARD_ID  VARCHAR2(255),
    CONSTRAINT PK_PLACE_ID PRIMARY KEY (PLACE_ID)
);
ALTER TABLE PLACE MODIFY PLACE_NAME NULL;
CREATE TABLE ROUTE (
	ROUTE_ID	            VARCHAR2(100),
	ROUTE_BOARD_ID	        VARCHAR2(255),
	ROUTE_PLACE_ID	        VARCHAR2(255) NOT NULL,
	ROUTE_PLACE_ORDER_NO	NUMBER DEFAULT 0,
    CONSTRAINT PK_ROUTE_ID PRIMARY KEY (ROUTE_ID)
    , CONSTRAINT FK_ROUTE_BOARD_ID FOREIGN KEY (ROUTE_BOARD_ID) REFERENCES ROUTE_BOARD(ROUTE_BOARD_ID) ON DELETE SET NULL
    , CONSTRAINT FK_ROUTE_PLACE_ID FOREIGN KEY (ROUTE_PLACE_ID) REFERENCES PLACE(PLACE_ID)
);

CREATE TABLE GUIDE_BOARD (
	POST_ID	        VARCHAR2(255),
	TITLE	        VARCHAR2(500) NOT NULL,
	CONTENT        CLOB NOT NULL,
	LOCATION       VARCHAR2(500) NOT NULL,
	CREATED_AT	    DATE DEFAULT SYSDATE,
	UPDATED_AT	    DATE,
	USER_ID	        VARCHAR2(255) NOT NULL,
	LIKE_COUNT	    NUMBER DEFAULT 0,
	OFILE1	        VARCHAR2(500),
	OFILE2	        VARCHAR2(500),
	OFILE3	        VARCHAR2(500),
	OFILE4	        VARCHAR2(500),
	OFILE5	        VARCHAR2(500),
	RFILE1	        VARCHAR2(500),
	RFILE2	        VARCHAR2(500),
	RFILE3	        VARCHAR2(500),
	RFILE4	        VARCHAR2(500),
	RFILE5	        VARCHAR2(500),
    READ_COUNT     NUMBER DEFAULT 0,
    CONSTRAINT PK_GUIDE_BOARD_ID PRIMARY KEY (POST_ID)
    , CONSTRAINT FK_GUIDE_BOARD_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
);


//DROP TABLE CHATTING CASCADE CONSTRAINTS;
CREATE TABLE CHATTING (
    MESSAGE_NO      NUMBER PRIMARY KEY,     -- �޽��� ��ȣ (�ĺ���, �����̸Ӹ� Ű)
    TEXT_MESSAGE    CLOB NOT NULL,          -- �޽��� ����
    SENDER          VARCHAR2(255) NOT NULL, -- �޽����� ���� ȸ�� ID (�ܷ� Ű)
    RECEIVER        VARCHAR2(255) NOT NULL, -- �޽����� ���� ȸ�� ID (�ܷ� Ű)
    CONNECT_YN      CHAR(1) DEFAULT 'N' NOT NULL, -- �޽��� ���� ���� (Y/N)
    SEND_TIME       TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL, -- �޽��� ���� �ð�
    CONSTRAINT FK_SENDER FOREIGN KEY (SENDER) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE, -- �ܷ� Ű ��������
    CONSTRAINT FK_RECEIVER FOREIGN KEY (RECEIVER) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE -- �ܷ� Ű ��������
);

DROP SEQUENCE SEQ_CHATTING;
-- �޽��� ��ȣ�� �ڵ� ������Ű�� ���� ������

CREATE SEQUENCE SEQ_CHATTING
NOCYCLE
NOCACHE;



-- COMMENT �߰�
COMMENT ON COLUMN CHATTING.MESSAGE_NO IS '�޽��� ���� �ĺ� ��ȣ';
COMMENT ON COLUMN CHATTING.TEXT_MESSAGE IS '�޽��� ����';
COMMENT ON COLUMN CHATTING.SENDER IS '�޽����� ���� ȸ�� ID';
COMMENT ON COLUMN CHATTING.RECEIVER IS '�޽����� ���� ȸ�� ID';
COMMENT ON COLUMN CHATTING.CONNECT_YN IS '�޽��� ���� ���� (Y: ����, N: �̼���)';
COMMENT ON COLUMN CHATTING.SEND_TIME IS '�޽��� ���� �ð�';


CREATE TABLE LIKE_COUNT (
    USER_ID     VARCHAR2(255),
    POST_ID     VARCHAR2(255),
    CONSTRAINT PK_LIKE_COUNT PRIMARY KEY (USER_ID, POST_ID)
    , CONSTRAINT FK_LIKE_COUNT_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER (MEM_ID) ON DELETE SET NULL
);

-- comment ����
COMMENT ON COLUMN MEMBER.MEM_ID IS '�����ID';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '������̸�';
COMMENT ON COLUMN MEMBER.MEM_TYPE IS '�����Ÿ��';
COMMENT ON COLUMN MEMBER.MEM_PW IS '����ں�й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NICKNM IS '����ڴг���';
COMMENT ON COLUMN MEMBER.MEM_JOIN_DATE IS '���Գ�¥';
COMMENT ON COLUMN MEMBER.MEM_PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.MEM_BIRTH IS '�������';
COMMENT ON COLUMN MEMBER.MEM_SOCIAL IS '�Ҽȱ���';
COMMENT ON COLUMN MEMBER.MEM_STATUS IS '����ڻ���';
COMMENT ON COLUMN MEMBER.MEM_LOGIN_LOG IS '�α��α��';
COMMENT ON COLUMN MEMBER.MEM_LOGOUT_LOG IS '�α׾ƿ����';
COMMENT ON COLUMN MEMBER.MEM_STATUS_DATE IS '����ڻ������볯¥';
COMMENT ON COLUMN MEMBER.MEM_PW_UPDATE IS '��й�ȣ������¥';

COMMENT ON COLUMN NOTICE.NOTICE_ID IS '�����ĺ��ڵ�';
COMMENT ON COLUMN NOTICE.TITLE IS '��������';
COMMENT ON COLUMN NOTICE.CONTENT IS '��������';
COMMENT ON COLUMN NOTICE.ADMIN_ID IS '�ۼ��Ѱ�����ID';
COMMENT ON COLUMN NOTICE.CREATED_AT IS '�����ۼ�����';
COMMENT ON COLUMN NOTICE.UPDATED_AT IS '������������';
COMMENT ON COLUMN NOTICE.UPDATE_CHECK IS '������������';
COMMENT ON COLUMN NOTICE.DELETED_AT IS '������������';
COMMENT ON COLUMN NOTICE.DELETE_CHECK IS '������������';
COMMENT ON COLUMN NOTICE.OFILE1 IS '����÷������1';
COMMENT ON COLUMN NOTICE.OFILE2 IS '����÷������2';
COMMENT ON COLUMN NOTICE.OFiLE3 IS '����÷������3';
COMMENT ON COLUMN NOTICE.RFiLE1 IS '����÷������1';
COMMENT ON COLUMN NOTICE.RFiLE2 IS '����÷������2';
COMMENT ON COLUMN NOTICE.RFiLE3 IS '����÷������3';
COMMENT ON COLUMN NOTICE.READ_COUNT IS '��ȸ��';


COMMENT ON COLUMN QNA.QNA_ID IS '�����۽ĺ��ڵ�';
COMMENT ON COLUMN QNA.TITLE IS '��������';
COMMENT ON COLUMN QNA.USER_CONTENT IS '��������';
COMMENT ON COLUMN QNA.USER_ID IS '�����ۼ���ID';
COMMENT ON COLUMN QNA.Q_CREATED_AT IS '�����ۼ�����';
COMMENT ON COLUMN QNA.Q_UPDATED_AT IS '������������';
COMMENT ON COLUMN QNA.ADMIN_ID IS '�亯������ID';
COMMENT ON COLUMN QNA.IS_ACCEPT IS '�亯����';
COMMENT ON COLUMN QNA.ADMIN_CONTENT IS '�亯����';
COMMENT ON COLUMN QNA.A_CREATED_AT IS '�亯�ۼ�����';
COMMENT ON COLUMN QNA.IS_SECRET IS '������������';
COMMENT ON COLUMN QNA.DELETE_AT IS '��������';
COMMENT ON COLUMN QNA.DELETE_CHECK IS '��������';
COMMENT ON COLUMN QNA.OFILE1 IS '����÷������1';
COMMENT ON COLUMN QNA.OFILE2 IS '����÷������2';
COMMENT ON COLUMN QNA.OFILE3 IS '����÷������3';
COMMENT ON COLUMN QNA.OFILE4 IS '����÷������4';
COMMENT ON COLUMN QNA.OFILE5 IS '����÷������5';
COMMENT ON COLUMN QNA.RFILE1 IS '����÷������1';
COMMENT ON COLUMN QNA.RFILE2 IS '����÷������2';
COMMENT ON COLUMN QNA.RFILE3 IS '����÷������3';
COMMENT ON COLUMN QNA.RFILE4 IS '����÷������4';
COMMENT ON COLUMN QNA.RFILE5 IS '����÷������5';

COMMENT ON COLUMN GUIDE_BOARD.POST_ID IS '�Խñ۽ĺ��ڵ�';
COMMENT ON COLUMN GUIDE_BOARD.TITLE IS '���̵������';
COMMENT ON COLUMN GUIDE_BOARD.CONTENT IS '���̵�۳���';
COMMENT ON COLUMN GUIDE_BOARD.LOCATION IS '����';
COMMENT ON COLUMN GUIDE_BOARD.CREATED_AT IS '���̵���ۼ�����';
COMMENT ON COLUMN GUIDE_BOARD.UPDATED_AT IS '���̵�ۼ�������';
COMMENT ON COLUMN GUIDE_BOARD.USER_ID IS '���̵�ID';
COMMENT ON COLUMN GUIDE_BOARD.LIKE_COUNT IS '�Խñ� ��õ��';
COMMENT ON COLUMN GUIDE_BOARD.OFILE1 IS '����÷������1';
COMMENT ON COLUMN GUIDE_BOARD.OFILE2 IS '����÷������2';
COMMENT ON COLUMN GUIDE_BOARD.OFILE3 IS '����÷������3';
COMMENT ON COLUMN GUIDE_BOARD.OFILE4 IS '����÷������4';
COMMENT ON COLUMN GUIDE_BOARD.OFILE5 IS '����÷������5';
COMMENT ON COLUMN GUIDE_BOARD.RFILE1 IS '����÷������1';
COMMENT ON COLUMN GUIDE_BOARD.RFILE2 IS '����÷������2';
COMMENT ON COLUMN GUIDE_BOARD.RFILE3 IS '����÷������3';
COMMENT ON COLUMN GUIDE_BOARD.RFILE4 IS '����÷������4';
COMMENT ON COLUMN GUIDE_BOARD.RFILE5 IS '����÷������5';
COMMENT ON COLUMN GUIDE_BOARD.READ_COUNT IS '��ȸ��';

COMMENT ON COLUMN TB_COMMENT.COMMENT_ID IS '��۽ĺ��ڵ�';
COMMENT ON COLUMN TB_COMMENT.USER_ID IS '����ۼ���ID';
COMMENT ON COLUMN TB_COMMENT.POST_ID IS '�Խñ�ID';
COMMENT ON COLUMN TB_COMMENT.CONTENT IS '��۳���';
COMMENT ON COLUMN TB_COMMENT.CREATED_AT IS '����ۼ�����';
COMMENT ON COLUMN TB_COMMENT.UPDATED_AT IS '��ۼ�������';

COMMENT ON COLUMN ROUTE_BOARD.ROUTE_BOARD_ID IS '�����õ�Խñ۽ĺ��ڵ�';
COMMENT ON COLUMN ROUTE_BOARD.USER_ID IS '�����õ���ۼ���ID';
COMMENT ON COLUMN ROUTE_BOARD.TITLE IS '�����õ������';
COMMENT ON COLUMN ROUTE_BOARD.CONTENT IS '�����õ����';
COMMENT ON COLUMN ROUTE_BOARD.TRANSPORT IS '�������';
COMMENT ON COLUMN ROUTE_BOARD.CREATED_AT IS '���ۼ�����';
COMMENT ON COLUMN ROUTE_BOARD.UPDATED_AT IS '�ۼ�������';
COMMENT ON COLUMN ROUTE_BOARD.LIKE_COUNT IS '�Խñ���õ��';
COMMENT ON COLUMN ROUTE_BOARD.TOTAL_DURATION IS '��õ�Ѱ�� �� �ҿ�ð�';
COMMENT ON COLUMN ROUTE_BOARD.ROUTE_NAME IS '��õ����̸�';
COMMENT ON COLUMN ROUTE_BOARD.OFILE1 IS '����÷������1';
COMMENT ON COLUMN ROUTE_BOARD.OFILE2 IS '����÷������2';
COMMENT ON COLUMN ROUTE_BOARD.OFILE3 IS '����÷������3';
COMMENT ON COLUMN ROUTE_BOARD.OFILE4 IS '����÷������4';
COMMENT ON COLUMN ROUTE_BOARD.OFILE5 IS '����÷������5';
COMMENT ON COLUMN ROUTE_BOARD.RFILE1 IS '����÷������1';
COMMENT ON COLUMN ROUTE_BOARD.RFILE2 IS '����÷������2';
COMMENT ON COLUMN ROUTE_BOARD.RFILE3 IS '����÷������3';
COMMENT ON COLUMN ROUTE_BOARD.RFILE4 IS '����÷������4';
COMMENT ON COLUMN ROUTE_BOARD.RFILE5 IS '����÷������5';
COMMENT ON COLUMN ROUTE_BOARD.READ_COUNT IS '��ȸ��';

COMMENT ON COLUMN PLACE.PLACE_ID IS '��ҽĺ��ڵ�';
COMMENT ON COLUMN PLACE.PLACE_NAME IS '����̸�';
COMMENT ON COLUMN PLACE.ADDRESS IS '�ּ�';
COMMENT ON COLUMN PLACE.LATITUDE IS '����';
COMMENT ON COLUMN PLACE.LONGITUDE IS '�浵';
COMMENT ON COLUMN PLACE.PLACE_CONTENT IS '��Ҽ���';
COMMENT ON COLUMN PLACE.ROUTE_BOARD_ID IS '�Խñ۽ĺ��ڵ�';

COMMENT ON COLUMN ROUTE.ROUTE_ID IS '��νĺ��ڵ�';
COMMENT ON COLUMN ROUTE.ROUTE_BOARD_ID IS '�Խñ۽ĺ��ڵ�';
COMMENT ON COLUMN ROUTE.ROUTE_PLACE_ID IS '�������ĺ��ڵ�';
COMMENT ON COLUMN ROUTE.ROUTE_PLACE_ORDER_NO IS '����������';


COMMENT ON COLUMN LIKE_COUNT.USER_ID IS '��õ��ID';
COMMENT ON COLUMN LIKE_COUNT.POST_ID IS '�Խñ� �ĺ��ڵ�';

COMMENT ON COLUMN REPORT.REPORT_ID IS '�Ű�Խñ� �ĺ��ڵ�';
COMMENT ON COLUMN REPORT.POST_ID IS '�Խñ� �ĺ��ڵ�';
COMMENT ON COLUMN REPORT.REPORT_USER_ID IS '�Ű���';
COMMENT ON COLUMN REPORT.REPORTING_REASON IS '�Ű����';
COMMENT ON COLUMN REPORT.DETAIL IS '�󼼳���';
COMMENT ON COLUMN REPORT.REPORT_DATE IS '�Ű�����';
COMMENT ON COLUMN REPORT.CHECKED_ADMIN IS '������ Ȯ�ο���';
COMMENT ON COLUMN REPORT.CHECKED_ADMIN_ID IS 'Ȯ���� ������';
COMMENT ON COLUMN REPORT.CHECKED_ASSIGNED IS 'ó������';
COMMENT ON COLUMN REPORT.ASSIGNED_ADMIN_ID IS 'ó���� ������';


-- �ĺ��ڵ带 ���� ������ ����
-- �������� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_NOTICE
NOCYCLE
NOCACHE;

-- �Ű���� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_REPORT
NOCYCLE
NOCACHE;

-- QnA �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_QNA
NOCYCLE
NOCACHE;

-- �����õ�Խ��� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_ROUTE_BOARD
NOCYCLE
NOCACHE;

-- ��ΰ��� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_ROUTE
NOCYCLE
NOCACHE;

-- ��Ұ��� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_PLACE
NOCYCLE
NOCACHE;

-- ���̵�Խ��� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_GUIDE_BOARD
NOCYCLE
NOCACHE;

-- ��� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_COMMENT
NOCYCLE
NOCACHE;

-- ������ ���̵� ����
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('ejjung02@beeu.co.kr','������','ADMIN','123456','������',TIMESTAMP'2024-10-12 01:20:27',NULL,NULL,'GOOGLE','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('tsoh03@beeu.co.kr','������','ADMIN','$2a$10$LMJdIRLIeFbTl3sT1x43d.Fugpe1oGnRgwtpR7nltaJ2Z621.DEou','�˺�',TIMESTAMP'2024-10-12 01:20:27','010-2695-0533',TIMESTAMP'2003-08-12 00:00:00','GOOGLE','ACTIVE',NULL,NULL,NULL,TIMESTAMP'2024-10-12 01:34:28');
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('ADMIN@synergysoft.co.kr','������','ADMIN','123456','ADMIN',TIMESTAMP'2024-10-12 01:20:28',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('0988soso123@gmail.com','0988','ADMIN','123456','0988',TIMESTAMP'2024-10-12 01:20:29',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('user01','���¼�','ADMIN','123456','�޾�',TIMESTAMP'2024-10-12 01:20:29',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('ADMIN NOT ASSIGNED','������ ó�� �ʿ�','ADMIN','1313','������ ó�� �ʿ�',TIMESTAMP'2024-10-12 01:20:29',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('ADMIN NOT CHECKED','������ Ȯ�� �ʿ�','ADMIN','1313','������ Ȯ�� �ʿ�',TIMESTAMP'2024-10-12 01:20:29',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('cia','cia','ADMIN','1313','cia',TIMESTAMP'2024-10-12 01:20:30',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('admin','admin','ADMIN','1313','admin',TIMESTAMP'2024-10-12 01:21:51',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
INSERT INTO "MEMBER" (MEM_ID,MEM_NAME,MEM_TYPE,MEM_PW,MEM_NICKNM,MEM_JOIN_DATE,MEM_PHONE,MEM_BIRTH,MEM_SOCIAL,MEM_STATUS,MEM_LOGIN_LOG,MEM_LOGOUT_LOG,MEM_STATUS_DATE,MEM_PW_UPDATE) VALUES('kkk','kkk','ADMIN','1313','kkk',TIMESTAMP'2024-10-12 01:23:58',NULL,NULL,'COMMON','ACTIVE',NULL,NULL,NULL,NULL);
COMMIT;

-- ��������(notice) test data �߰�
DELETE FROM NOTICE;
COMMIT;
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'1.���������Դϴ�.','�������� ����1','admin','2024-03-20',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'2.���������Դϴ�.','�������� ����2','admin','2024-03-21',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'3.���������Դϴ�.','�������� ����3','admin','2024-03-22',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'4.���������Դϴ�.','�������� ����4','admin','2024-03-23',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'5.���������Դϴ�.','�������� ����5','admin','2024-03-24',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'6.���������Դϴ�.','�������� ����6','admin','2024-03-25',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'7.���������Դϴ�.','�������� ����7','admin','2024-03-26',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'8.���������Դϴ�.','�������� ����8','admin','2024-03-27',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'9.���������Դϴ�.','�������� ����9','admin','2024-03-28',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'10.���������Դϴ�.','�������� ����10','admin','2024-03-29',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'11.���������Դϴ�.','�������� ����11','admin','2024-03-30',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'12.���������Դϴ�.','�������� ����12','admin','2024-03-31',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'13.���������Դϴ�.','�������� ����13','admin','2024-04-01',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'14.���������Դϴ�.','�������� ����14','admin','2024-04-02',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'15.���������Դϴ�.','�������� ����15','admin','2024-04-03',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'16.���������Դϴ�.','�������� ����16','admin','2024-04-04',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'17.���������Դϴ�.','�������� ����17','admin','2024-04-05',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'18.���������Դϴ�.','�������� ����18','admin','2024-04-06',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'19.���������Դϴ�.','�������� ����19','admin','2024-04-07',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'20.���������Դϴ�.','�������� ����20','admin','2024-04-08',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'21.���������Դϴ�.','�������� ����21','admin','2024-04-09',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'22.���������Դϴ�.','�������� ����22','admin','2024-04-10',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'23.���������Դϴ�.','�������� ����23','admin','2024-04-11',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'24.���������Դϴ�.','�������� ����24','admin','2024-04-12',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'25.���������Դϴ�.','�������� ����25','admin','2024-04-13',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'26.���������Դϴ�.','�������� ����26','admin','2024-04-14',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'27.���������Դϴ�.','�������� ����27','admin','2024-04-15',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'28.���������Դϴ�.','�������� ����28','admin','2024-04-16',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'29.���������Դϴ�.','�������� ����29','admin','2024-04-17',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'30.���������Դϴ�.','�������� ����30','admin','2024-04-18',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'31.���������Դϴ�.','�������� ����31','admin','2024-04-19',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'32.���������Դϴ�.','�������� ����32','admin','2024-04-20',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'33.���������Դϴ�.','�������� ����33','admin','2024-04-21',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'34.���������Դϴ�.','�������� ����34','admin','2024-04-22',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'35.���������Դϴ�.','�������� ����35','admin','2024-04-23',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'36.���������Դϴ�.','�������� ����36','admin','2024-04-24',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'37.���������Դϴ�.','�������� ����37','admin','2024-04-25',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'38.���������Դϴ�.','�������� ����38','admin','2024-04-26',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'39.���������Դϴ�.','�������� ����39','admin','2024-04-27',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'40.���������Դϴ�.','�������� ����40','admin','2024-04-28',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'41.���������Դϴ�.','�������� ����41','admin','2024-04-29',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'42.���������Դϴ�.','�������� ����42','admin','2024-04-30',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'43.���������Դϴ�.','�������� ����43','admin','2024-05-01',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'44.���������Դϴ�.','�������� ����44','admin','2024-05-02',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'45.���������Դϴ�.','�������� ����45','admin','2024-05-03',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'46.���������Դϴ�.','�������� ����46','admin','2024-05-04',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'47.���������Դϴ�.','�������� ����47','admin','2024-05-05',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'48.���������Դϴ�.','�������� ����48','admin','2024-05-06',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'49.���������Դϴ�.','�������� ����49','admin','2024-05-07',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'50.���������Դϴ�.','�������� ����50','admin','2024-05-08',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'51.���������Դϴ�.','�������� ����51','admin','2024-05-09',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'52.���������Դϴ�.','�������� ����52','admin','2024-05-10',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'53.���������Դϴ�.','�������� ����53','admin','2024-05-11',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'54.���������Դϴ�.','�������� ����54','admin','2024-05-12',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'55.���������Դϴ�.','�������� ����55','admin','2024-05-13',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'56.���������Դϴ�.','�������� ����56','admin','2024-05-14',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'57.���������Դϴ�.','�������� ����57','admin','2024-05-15',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'58.���������Դϴ�.','�������� ����58','admin','2024-05-16',null,'N',null,'N',null,null,null,null,null,null,0);

commit;

--���̵� ���̵����� �߰�
INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '����Ÿ������', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���1', '����', TO_DATE('2022-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'user01', 1,'Ž��Ÿ��.jpg',null,null,null,null, '20241008180429657_d1a6744b24644b68859fa7b2c87cb199.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '���ɴ翩��.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '���ɴ�.jpg',null,null,null,null, '20241011122607800_5bfcc3115e2244758491d25daf0e8167.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '���ֿ���', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-14', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 6, '���ð� ����.jpg',null,null,null,null, '20241008180429657_d1a6744b24644b68859fa7b2c87cb199.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '������.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-15', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '�ڶ�������.jpg',null,null,null,null, '20241007180649075_65ba688ce2094fb09b0a6bbe1597c182.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '����������', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '������', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 5, '���� ������1.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '�¾ȿ���', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '�¾�', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 3, '��ؾ�.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '����Ҳ������ı�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '�Ҳɳ���.jpg',null,null,null,null, '20241007191530822_51767e3eef6b499ead05ac1605dc48c3.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '�����', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '�Ҳɳ���.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '����¿���', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '�Ҳɳ���.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('guide_'||SEQ_GUIDE_BOARD.NEXTVAL, '��մ� ����.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���7', '����', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '�Ҳɳ���.jpg',null,null,null,null, '20241007191530822_51767e3eef6b499ead05ac1605dc48c3.jpg' ,null,null,null,null);

commit;


-- qna(qna) test data �߰�
DELETE FROM QNA;
COMMIT;
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'1�׽�Ʈ qna','1 ���� qna','user01','2024-03-20',null,'admin','Y','1 �����ڳ���','2024-03-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'2�׽�Ʈ qna','2 ���� qna','user01','2024-03-21',null,'admin','Y','2 �����ڳ���','2024-03-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'3�׽�Ʈ qna','3 ���� qna','user01','2024-03-22',null,'admin','Y','3 �����ڳ���','2024-03-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'4�׽�Ʈ qna','4 ���� qna','user01','2024-03-23',null,'admin','Y','4 �����ڳ���','2024-03-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'5�׽�Ʈ qna','5 ���� qna','user01','2024-03-24',null,'admin','Y','5 �����ڳ���','2024-03-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'6�׽�Ʈ qna','6 ���� qna','user01','2024-03-25',null,'admin','Y','6 �����ڳ���','2024-03-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'7�׽�Ʈ qna','7 ���� qna','user01','2024-03-26',null,'admin','Y','7 �����ڳ���','2024-03-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'8�׽�Ʈ qna','8 ���� qna','user01','2024-03-27',null,'admin','Y','8 �����ڳ���','2024-03-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'9�׽�Ʈ qna','9 ���� qna','user01','2024-03-28',null,'admin','Y','9 �����ڳ���','2024-03-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'10�׽�Ʈ qna','10 ���� qna','user01','2024-03-29',null,'admin','Y','10 �����ڳ���','2024-03-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'11�׽�Ʈ qna','11 ���� qna','user01','2024-03-30',null,'admin','Y','11 �����ڳ���','2024-03-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'12�׽�Ʈ qna','12 ���� qna','user01','2024-03-31',null,'admin','Y','12 �����ڳ���','2024-03-31','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'13�׽�Ʈ qna','13 ���� qna','user01','2024-04-01',null,'admin','Y','13 �����ڳ���','2024-04-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'14�׽�Ʈ qna','14 ���� qna','user01','2024-04-02',null,'admin','Y','14 �����ڳ���','2024-04-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'15�׽�Ʈ qna','15 ���� qna','user01','2024-04-03',null,'admin','Y','15 �����ڳ���','2024-04-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'16�׽�Ʈ qna','16 ���� qna','user01','2024-04-04',null,'admin','Y','16 �����ڳ���','2024-04-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'17�׽�Ʈ qna','17 ���� qna','user01','2024-04-05',null,'admin','Y','17 �����ڳ���','2024-04-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'18�׽�Ʈ qna','18 ���� qna','user01','2024-04-06',null,'admin','Y','18 �����ڳ���','2024-04-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'19�׽�Ʈ qna','19 ���� qna','user01','2024-04-07',null,'admin','Y','19 �����ڳ���','2024-04-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'20�׽�Ʈ qna','20 ���� qna','user01','2024-04-08',null,'admin','Y','20 �����ڳ���','2024-04-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'21�׽�Ʈ qna','21 ���� qna','user01','2024-04-09',null,'admin','Y','21 �����ڳ���','2024-04-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'22�׽�Ʈ qna','22 ���� qna','user01','2024-04-10',null,'admin','Y','22 �����ڳ���','2024-04-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'23�׽�Ʈ qna','23 ���� qna','user01','2024-04-11',null,'admin','Y','23 �����ڳ���','2024-04-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'24�׽�Ʈ qna','24 ���� qna','user01','2024-04-12',null,'admin','Y','24 �����ڳ���','2024-04-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'25�׽�Ʈ qna','25 ���� qna','user01','2024-04-13',null,'admin','Y','25 �����ڳ���','2024-04-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'26�׽�Ʈ qna','26 ���� qna','user01','2024-04-14',null,'admin','Y','26 �����ڳ���','2024-04-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'27�׽�Ʈ qna','27 ���� qna','user01','2024-04-15',null,'admin','Y','27 �����ڳ���','2024-04-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'28�׽�Ʈ qna','28 ���� qna','user01','2024-04-16',null,'admin','Y','28 �����ڳ���','2024-04-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'29�׽�Ʈ qna','29 ���� qna','user01','2024-04-17',null,'admin','Y','29 �����ڳ���','2024-04-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'30�׽�Ʈ qna','30 ���� qna','user01','2024-04-18',null,'admin','Y','30 �����ڳ���','2024-04-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'31�׽�Ʈ qna','31 ���� qna','user01','2024-04-19',null,'admin','Y','31 �����ڳ���','2024-04-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'32�׽�Ʈ qna','32 ���� qna','user01','2024-04-20',null,'admin','Y','32 �����ڳ���','2024-04-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'33�׽�Ʈ qna','33 ���� qna','user01','2024-04-21',null,'admin','Y','33 �����ڳ���','2024-04-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'34�׽�Ʈ qna','34 ���� qna','user01','2024-04-22',null,'admin','Y','34 �����ڳ���','2024-04-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'35�׽�Ʈ qna','35 ���� qna','user01','2024-04-23',null,'admin','Y','35 �����ڳ���','2024-04-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'36�׽�Ʈ qna','36 ���� qna','user01','2024-04-24',null,'admin','Y','36 �����ڳ���','2024-04-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'37�׽�Ʈ qna','37 ���� qna','user01','2024-04-25',null,'admin','Y','37 �����ڳ���','2024-04-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'38�׽�Ʈ qna','38 ���� qna','user01','2024-04-26',null,'admin','Y','38 �����ڳ���','2024-04-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'39�׽�Ʈ qna','39 ���� qna','user01','2024-04-27',null,'admin','Y','39 �����ڳ���','2024-04-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'40�׽�Ʈ qna','40 ���� qna','user01','2024-04-28',null,'admin','Y','40 �����ڳ���','2024-04-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'41�׽�Ʈ qna','41 ���� qna','user01','2024-04-29',null,'admin','Y','41 �����ڳ���','2024-04-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'42�׽�Ʈ qna','42 ���� qna','user01','2024-04-30',null,'admin','Y','42 �����ڳ���','2024-04-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'43�׽�Ʈ qna','43 ���� qna','user01','2024-05-01',null,'admin','Y','43 �����ڳ���','2024-05-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'44�׽�Ʈ qna','44 ���� qna','user01','2024-05-02',null,'admin','Y','44 �����ڳ���','2024-05-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'45�׽�Ʈ qna','45 ���� qna','user01','2024-05-03',null,'admin','Y','45 �����ڳ���','2024-05-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'46�׽�Ʈ qna','46 ���� qna','user01','2024-05-04',null,'admin','Y','46 �����ڳ���','2024-05-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'47�׽�Ʈ qna','47 ���� qna','user01','2024-05-05',null,'admin','Y','47 �����ڳ���','2024-05-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'48�׽�Ʈ qna','48 ���� qna','user01','2024-05-06',null,'admin','Y','48 �����ڳ���','2024-05-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'49�׽�Ʈ qna','49 ���� qna','user01','2024-05-07',null,'admin','Y','49 �����ڳ���','2024-05-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'50�׽�Ʈ qna','50 ���� qna','user01','2024-05-08',null,'admin','Y','50 �����ڳ���','2024-05-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'51�׽�Ʈ qna','51 ���� qna','user01','2024-05-09',null,'admin','Y','51 �����ڳ���','2024-05-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'52�׽�Ʈ qna','52 ���� qna','user01','2024-05-10',null,'admin','Y','52 �����ڳ���','2024-05-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'53�׽�Ʈ qna','53 ���� qna','user01','2024-05-11',null,'admin','Y','53 �����ڳ���','2024-05-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'54�׽�Ʈ qna','54 ���� qna','user01','2024-05-12',null,'admin','Y','54 �����ڳ���','2024-05-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'55�׽�Ʈ qna','55 ���� qna','user01','2024-05-13',null,'admin','Y','55 �����ڳ���','2024-05-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'56�׽�Ʈ qna','56 ���� qna','user01','2024-05-14',null,'admin','Y','56 �����ڳ���','2024-05-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'57�׽�Ʈ qna','57 ���� qna','user01','2024-05-15',null,'admin','Y','57 �����ڳ���','2024-05-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'58�׽�Ʈ qna','58 ���� qna','user01','2024-05-16',null,'admin','Y','58 �����ڳ���','2024-05-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'59�׽�Ʈ qna','59 ���� qna','user01','2024-05-17',null,'admin','Y','59 �����ڳ���','2024-05-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'60�׽�Ʈ qna','60 ���� qna','user01','2024-05-18',null,'admin','Y','60 �����ڳ���','2024-05-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'61�׽�Ʈ qna','61 ���� qna','user01','2024-05-19',null,'admin','Y','61 �����ڳ���','2024-05-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'62�׽�Ʈ qna','62 ���� qna','user01','2024-05-20',null,'admin','Y','62 �����ڳ���','2024-05-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'63�׽�Ʈ qna','63 ���� qna','user01','2024-05-21',null,'admin','Y','63 �����ڳ���','2024-05-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'64�׽�Ʈ qna','64 ���� qna','user01','2024-05-22',null,'admin','Y','64 �����ڳ���','2024-05-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'65�׽�Ʈ qna','65 ���� qna','user01','2024-05-23',null,'admin','Y','65 �����ڳ���','2024-05-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'66�׽�Ʈ qna','66 ���� qna','user01','2024-05-24',null,'admin','Y','66 �����ڳ���','2024-05-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'67�׽�Ʈ qna','67 ���� qna','user01','2024-05-25',null,'admin','Y','67 �����ڳ���','2024-05-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'68�׽�Ʈ qna','68 ���� qna','user01','2024-05-26',null,'admin','Y','68 �����ڳ���','2024-05-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'69�׽�Ʈ qna','69 ���� qna','user01','2024-05-27',null,'admin','Y','69 �����ڳ���','2024-05-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'70�׽�Ʈ qna','70 ���� qna','user01','2024-05-28',null,'admin','Y','70 �����ڳ���','2024-05-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'71�׽�Ʈ qna','71 ���� qna','user01','2024-05-29',null,'admin','Y','71 �����ڳ���','2024-05-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'72�׽�Ʈ qna','72 ���� qna','user01','2024-05-30',null,'admin','Y','72 �����ڳ���','2024-05-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'73�׽�Ʈ qna','73 ���� qna','user01','2024-05-31',null,'admin','Y','73 �����ڳ���','2024-05-31','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'74�׽�Ʈ qna','74 ���� qna','user01','2024-06-01',null,'admin','Y','74 �����ڳ���','2024-06-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'75�׽�Ʈ qna','75 ���� qna','user01','2024-06-02',null,'admin','Y','75 �����ڳ���','2024-06-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'76�׽�Ʈ qna','76 ���� qna','user01','2024-06-03',null,'admin','Y','76 �����ڳ���','2024-06-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'77�׽�Ʈ qna','77 ���� qna','user01','2024-06-04',null,'admin','Y','77 �����ڳ���','2024-06-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'78�׽�Ʈ qna','78 ���� qna','user01','2024-06-05',null,'admin','Y','78 �����ڳ���','2024-06-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'79�׽�Ʈ qna','79 ���� qna','user01','2024-06-06',null,'admin','Y','79 �����ڳ���','2024-06-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'80�׽�Ʈ qna','80 ���� qna','user01','2024-06-07',null,'admin','Y','80 �����ڳ���','2024-06-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'81�׽�Ʈ qna','81 ���� qna','user01','2024-06-08',null,'admin','Y','81 �����ڳ���','2024-06-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'82�׽�Ʈ qna','82 ���� qna','user01','2024-06-09',null,'admin','Y','82 �����ڳ���','2024-06-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'83�׽�Ʈ qna','83 ���� qna','user01','2024-06-10',null,'admin','Y','83 �����ڳ���','2024-06-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'84�׽�Ʈ qna','84 ���� qna','user01','2024-06-11',null,'admin','Y','84 �����ڳ���','2024-06-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'85�׽�Ʈ qna','85 ���� qna','user01','2024-06-12',null,'admin','Y','85 �����ڳ���','2024-06-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'86�׽�Ʈ qna','86 ���� qna','user01','2024-06-13',null,'admin','Y','86 �����ڳ���','2024-06-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'87�׽�Ʈ qna','87 ���� qna','user01','2024-06-14',null,'admin','Y','87 �����ڳ���','2024-06-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'88�׽�Ʈ qna','88 ���� qna','user01','2024-06-15',null,'admin','Y','88 �����ڳ���','2024-06-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'89�׽�Ʈ qna','89 ���� qna','user01','2024-06-16',null,'admin','Y','89 �����ڳ���','2024-06-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'90�׽�Ʈ qna','90 ���� qna','user01','2024-06-17',null,'admin','Y','90 �����ڳ���','2024-06-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'91�׽�Ʈ qna','91 ���� qna','user01','2024-06-18',null,'admin','Y','91 �����ڳ���','2024-06-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'92�׽�Ʈ qna','92 ���� qna','user01','2024-06-19',null,'admin','Y','92 �����ڳ���','2024-06-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'93�׽�Ʈ qna','93 ���� qna','user01','2024-06-20',null,'admin','Y','93 �����ڳ���','2024-06-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'94�׽�Ʈ qna','94 ���� qna','user01','2024-06-21',null,'admin','Y','94 �����ڳ���','2024-06-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'95�׽�Ʈ qna','95 ���� qna','user01','2024-06-22',null,'admin','Y','95 �����ڳ���','2024-06-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'96�׽�Ʈ qna','96 ���� qna','user01','2024-06-23',null,'admin','Y','96 �����ڳ���','2024-06-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'97�׽�Ʈ qna','97 ���� qna','user01','2024-06-24',null,'admin','Y','97 �����ڳ���','2024-06-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'98�׽�Ʈ qna','98 ���� qna','user01','2024-06-25',null,'admin','Y','98 �����ڳ���','2024-06-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'99�׽�Ʈ qna','99 ���� qna','user01','2024-06-26',null,'admin','Y','99 �����ڳ���','2024-06-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'100�׽�Ʈ qna','100 ���� qna','user01','2024-06-27',null,'admin','Y','100 �����ڳ���','2024-06-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);

commit;

-- report ���̵�����
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_3','user01','test1','test��1',TIMESTAMP'2024-10-03 00:00:45','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_4','kkk','��Ӿ���, �����߾�','��Ӿ� ���.',TIMESTAMP'2024-10-03 00:00:50','Y','ejjung02@beeu.co.kr','N','ejjung02@beeu.co.kr');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_6','0988soso123@gmail.com','test2','test��2',TIMESTAMP'2024-10-03 00:00:05','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_6','user01','test3','test��3',TIMESTAMP'2024-10-03 00:00:55','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'P001','cia','test5','test��5',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'P001','ejjung02@beeu.co.kr','test4','test��4',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'P001','kkk','test6','test��4',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'P001','user01','��Ӿ� ���','�õ��̶�� ������ ��Ӿ� ���',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_3','user01','test7','test��7',TIMESTAMP'2024-10-03 00:00:10','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_4','ejjung02@beeu.co.kr','��Ӿ�','��Ӿ� ���',TIMESTAMP'2024-10-03 00:00:15','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_3','cia','��Ӿ�','��Ӿ� ��� 2',TIMESTAMP'2024-10-03 00:00:20','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_4','ejjung02@beeu.co.kr','c','����2',TIMESTAMP'2024-10-03 00:00:25','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_5','0988soso123@gmail.com','d','����1',TIMESTAMP'2024-10-03 00:00:30','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_6','user01','e','����3',TIMESTAMP'2024-10-03 00:00:35','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_'||SEQ_REPORT.NEXTVAL,'guide_5','ejjung02@beeu.co.kr','f','����4',TIMESTAMP'2024-10-03 00:00:40','Y','ejjung02@beeu.co.kr','N','ejjung02@beeu.co.kr');
commit;

-- �����õ�Խ��� ���̵�����
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 1', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 1', '���߱���', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 2', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 2', '�ڵ���', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 3', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 3', '����', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 4', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 4', '������', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 5', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 5', '����', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 6', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 6', '�ڵ���', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 7', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 7', '���߱���', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 8', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 8', '����', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 9', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 9', '������', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO ROUTE_BOARD VALUES ('route_'||SEQ_ROUTE_BOARD.NEXTVAL, 'user01', '�����õ�Խ��� �׽�Ʈ 10', '�����õ�Խ��� ��ɱ��� Ȯ�ο� �׽�Ʈ ���̵������Դϴ�. 10', '����', SYSDATE, NULL, DEFAULT, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT);
COMMIT;

-- ��� �Խ��� ���̵�����
-- ���߱���
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�츮��', '��⵵ ȭ���� ���� 29', NULL, NULL, '�츮���Դϴ�.', 'route_1');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�� �� ����������', '��� ȭ���� ȿ��� 287', NULL, NULL, '�� �� �����������Դϴ�.', 'route_1');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '��翪', '���� ���۱� ���μ�ȯ�� 2089', NULL, NULL, '��翪 2ȣ���Դϴ�.', 'route_1');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '������', '���� ������ ������� 396', NULL, NULL, '������ 2ȣ���Դϴ�.', 'route_1');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�ѱ�ICT���簳�߿� ��������', '���� ���ʱ� ���ʴ��77�� 41 4��', NULL, NULL, '�п��Դϴ�.', 'route_1');
-- �ڵ���
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�츮��', '��⵵ ȭ���� ���� 29', NULL, NULL, '�츮���Դϴ�.', 'route_2');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '��ȯ����Ʈ', '��⵵ ������ �Ǽ��� ������ 47', NULL, NULL, 'ģ����.', 'route_2');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�ǿ������Ʈ', '��� �ǿս� �հ', NULL, NULL, '�ǿ������Ʈ.', 'route_2');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�ϳ������Ʈ', '��� �ϳ��� õ����', NULL, NULL, '�ϳ������Ʈ.', 'route_2');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�빮�� �ؿʹ�', '��� ���� ��õ�� ��õ�� 156-128', NULL, NULL, 'ķ�����Դϴ�.', 'route_2');
-- ����
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '���￪', '���� ��걸 �Ѱ���� 405', NULL, NULL, '���￪�Դϴ�.', 'route_3');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '����', '��� ����� ������ 21', NULL, NULL, '�����Դϴ�.', 'route_3');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '������', '������ ���� �߾ӷ� 215', NULL, NULL, '�������Դϴ�.', 'route_3');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '���ֿ�', '��� ���ֽ� ��õ�� ���ֿ��� 80', NULL, NULL, '���ֿ��Դϴ�.', 'route_3');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�λ꿪', '�λ�� ���� �߾Ӵ�� 206', NULL, NULL, '�λ꿪�Դϴ�.', 'route_3');
-- ������
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�Ѱ������ŵ��� ���', '����Ư���� ��걸 ������ 287-4', NULL, NULL, '�����ŵ��� ����Դϴ�.', 'route_4');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '1�� ������', '����Ư���� ��걸 ������ 288', NULL, NULL, 'ù��° �������Դϴ�.', 'route_4');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '2�� ������', '����Ư���� ��걸 ������ 291-2', NULL, NULL, '�ι�° �������Դϴ�.', 'route_4');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '3�� ������', '����Ư���� ��걸 ��굿6�� 450-1', NULL, NULL, '����° �������Դϴ�.', 'route_4');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�Ѱ������ŵ��� ����', '����Ư���� ��걸 ��굿6�� 452-1', NULL, NULL, '�����ŵ��� �����Դϴ�.', 'route_4');
-- ����
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�츮��', '��⵵ ȭ���� ���� 29', NULL, NULL, '�츮���Դϴ�.', 'route_5');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '1�� ������', '��⵵ ȭ���� ������ �Ϳ�ȱ� 88', NULL, NULL, 'ù��° �������Դϴ�.', 'route_5');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '2�� ������', '��⵵ ȭ���� ������ �Ϳ츮 213-153', NULL, NULL, '�ι�° �������Դϴ�.', 'route_5');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '3�� ������', '��⵵ ȭ���� ������ ��ȭ�� 640', NULL, NULL, '����° �������Դϴ�.', 'route_5');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, 'CGV ȭ��������', '��⵵ ȭ���� ������ ��ȭ�� 51, 2�� 221ȣ', NULL, NULL, '��ȭ���Դϴ�.', 'route_5');
-- �ڵ���
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�츮��', '��⵵ ȭ���� ���� 29', NULL, NULL, '�츮���Դϴ�.', 'route_6');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�� �� ����������', '��� ȭ���� ȿ��� 287', NULL, NULL, '�� �� �����������Դϴ�.', 'route_6');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '��翪', '���� ���۱� ���μ�ȯ�� 2089', NULL, NULL, '��翪 2ȣ���Դϴ�..', 'route_6');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '������', '���� ������ ������� 396', NULL, NULL, '������ 2ȣ���Դϴ�..', 'route_6');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�ѱ�ICT���簳�߿� ��������', '���� ���ʱ� ���ʴ��77�� 41 4��', NULL, NULL, '�п��Դϴ�.', 'route_6');
-- ���߱���
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�츮��', '��⵵ ȭ���� ���� 29', NULL, NULL, '�츮���Դϴ�.', 'route_7');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�����������Ʈ', '��� ȭ���� ������ ��õ��', NULL, NULL, '�����Ʈ�Դϴ�.', 'route_7');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, 'û��(��)�����Ʈ', '��� ȭ���� ����� û�丮', NULL, NULL, '�����Ʈ.', 'route_7');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '���������Ʈ', '��� ȭ���� ������ �ּ۸�', NULL, NULL, '�����Ʈ.', 'route_7');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '������', '��� ȭ���� ���Ÿ� �����׷� 1049-24', NULL, NULL, '�������Դϴ�.', 'route_7');
-- ����
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '���׼� ��� - õ�ȿ�', '�泲 õ�Ƚ� ������ ����� 239', NULL, NULL, 'õ�ȿ��Դϴ�.', 'route_8');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�¾��õ��', '�泲 �ƻ�� ��õ��� 1496', NULL, NULL, '�¾��õ���Դϴ�.', 'route_8');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, 'ȫ����', '�泲 ȫ���� ȫ���� ����� 272', NULL, NULL, 'ȫ�����Դϴ�.', 'route_8');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '��õ��', '�泲 ��õ�� ��õ�� ��õ���� 57', NULL, NULL, '��õ���Դϴ�.', 'route_8');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '���׼� ���� - �ͻ꿪', '���� �ͻ�� �ͻ��� 153', NULL, NULL, '�ͻ꿪�Դϴ�.', 'route_8');
-- ������
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '����õ���������ű� ���', '���������� ����� ��ȭ�� 568-1', NULL, NULL, '�����ű� ���.', 'route_9');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '��õ�����ŵ���', '���������� ���� �л굿 1558', NULL, NULL, '�����ű� 1.', 'route_9');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '����õ�����ű� 1', '���������� ���� �빮�� 598', NULL, NULL, '�����ű� 2.', 'route_9');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '����õ�����ű� 2', '���������� �߱� ���� 508-1', NULL, NULL, '�����ű� 3.', 'route_9');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '����õ���������ű� ����', '���������� �߱� ������ 609-16', NULL, NULL, '�����ű� ����.', 'route_9');
-- ����
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�ѱ�ICT���簳�߿� ��������', '���� ���ʱ� ���ʴ��77�� 41 4��', NULL, NULL, '����Դϴ�.', 'route_10');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�����ٳ� ������', '���� ���ʱ� �������65�� 1 ȿ������', NULL, NULL, 'ù��° �������Դϴ�.', 'route_10');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�Ƶ����� ���ʹ����', '���� ���ʱ� ������� 305 �������뷺�ÿ�', NULL, NULL, '�ι�° �������Դϴ�.', 'route_10');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, 'Ŀ���÷�Ʈ', '���� ������ �������44�� 24 1��', NULL, NULL, '����° �������Դϴ�.', 'route_10');
INSERT INTO PLACE VALUES ('place_'||SEQ_PLACE.NEXTVAL, '�Ե��ó׸� ������', '���� ������ ���μ�ȯ�� 2753', NULL, NULL, '�����Դϴ�.', 'route_10');
COMMIT;

-- ��ΰ������̺� ���̵�����
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_1', 'place_1', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_1', 'place_2', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_1', 'place_3', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_1', 'place_4', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_1', 'place_5', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_2', 'place_6', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_2', 'place_7', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_2', 'place_8', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_2', 'place_9', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_2', 'place_10', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_3', 'place_11', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_3', 'place_12', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_3', 'place_13', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_3', 'place_14', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_3', 'place_15', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_4', 'place_16', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_4', 'place_17', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_4', 'place_18', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_4', 'place_19', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_4', 'place_20', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_5', 'place_21', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_5', 'place_22', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_5', 'place_23', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_5', 'place_24', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_5', 'place_25', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_6', 'place_26', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_6', 'place_27', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_6', 'place_28', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_6', 'place_29', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_6', 'place_30', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_7', 'place_31', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_7', 'place_32', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_7', 'place_33', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_7', 'place_34', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_7', 'place_35', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_8', 'place_36', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_8', 'place_37', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_8', 'place_38', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_8', 'place_39', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_8', 'place_40', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_9', 'place_41', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_9', 'place_42', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_9', 'place_43', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_9', 'place_44', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_9', 'place_45', 5);

INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_10', 'place_46', 1);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_10', 'place_47', 2);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_10', 'place_48', 3);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_10', 'place_49', 4);
INSERT INTO ROUTE VALUES ('routedata_'||SEQ_ROUTE.NEXTVAL, 'route_10', 'place_50', 5);

COMMIT;