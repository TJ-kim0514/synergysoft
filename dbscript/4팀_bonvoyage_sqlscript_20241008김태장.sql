-- ǥ ���� �� ���� ������ ǥ ����
DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE REPORT CASCADE CONSTRAINTS;
DROP TABLE QNA CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT CASCADE CONSTRAINTS;
DROP TABLE GUIDE_BOARD CASCADE CONSTRAINTS;
DROP TABLE CHAT_MESSAGE CASCADE CONSTRAINTS;
DROP TABLE CHATTING_ROOM CASCADE CONSTRAINTS;
DROP TABLE ROUTE_BOARD CASCADE CONSTRAINTS;
DROP TABLE ROUTE CASCADE CONSTRAINTS;
DROP TABLE PLACE CASCADE CONSTRAINTS;
DROP TABLE LIKE_COUNT CASCADE CONSTRAINTS;

-- ������ ���� �� ���� ������ ������ ����
DROP SEQUENCE SEQ_NOTICE;
DROP SEQUENCE SEQ_REPORT;
DROP SEQUENCE SEQ_QNA;
DROP SEQUENCE SEQ_ROUTE_BOARD;
DROP SEQUENCE SEQ_ROUTE;
DROP SEQUENCE SEQ_PLACE;
DROP SEQUENCE SEQ_CHATTING_ROOM;
DROP SEQUENCE SEQ_CHAT_MESSAGE;
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
    CONSTRAINT PK_NOTICE_ID PRIMARY KEY (NOTICE_ID)
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
    , CONSTRAINT FK_QNA_ADMINID FOREIGN KEY (ADMIN_ID) REFERENCES MEMBER(MEM_ID)
    , CONSTRAINT CHK_IS_ACCEPT CHECK (IS_ACCEPT IN ('Y', 'N'))
);

CREATE TABLE REPORT (
	REPORT_ID	        VARCHAR2(255),
	POST_ID	            VARCHAR2(255) NOT NULL,
	REPORT_USER_ID	    VARCHAR2(255) NOT NULL,
	REPORTING_REASON	VARCHAR2(255),
	DETAIL	            VARCHAR2(255),
	REPORT_DATE	        DATE DEFAULT SYSDATE,
	CHECKED_ADMIN	    CHAR(1),
	CHECKED_ADMIN_ID	VARCHAR2(255) NOT NULL,
	CHECKED_ASSIGNED	CHAR(1),
	ASSIGNED_ADMIN_ID	VARCHAR2(255) NOT NULL,
    CONSTRAINT PK_REPORT_ID PRIMARY KEY (REPORT_ID)
    , CONSTRAINT FK_REPORT_USER_ID FOREIGN KEY (REPORT_USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
    , CONSTRAINT CHK_CHECKED_ADMIN CHECK (CHECKED_ADMIN IN ('Y', 'N'))
    , CONSTRAINT FK_CHECKED_ADMIN_ID FOREIGN KEY (CHECKED_ADMIN_ID) REFERENCES MEMBER(MEM_ID)
    , CONSTRAINT CHK_CHECKED_ASSIGNED CHECK (CHECKED_ASSIGNED IN ('Y', 'N'))
    , CONSTRAINT FK_ASSIGNED_ADMIN_ID FOREIGN KEY (ASSIGNED_ADMIN_ID) REFERENCES MEMBER(MEM_ID)
);

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
	TOTAL_DURATION	NUMBER	,
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
    CONSTRAINT PK_ROUTE_BOARD_ID PRIMARY KEY (ROUTE_BOARD_ID)
    , CONSTRAINT FK_ROUTE_BOARD_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
);

CREATE TABLE PLACE (
	PLACE_ID	        VARCHAR2(255),
	PLACE_NAME	    VARCHAR2(255) NOT NULL,
	ADDRESS 	    VARCHAR2(255),
	LATITUDE	        NUMBER,
	LONGITUDE	    NUMBER,
    CONSTRAINT PK_PLACE_ID PRIMARY KEY (PLACE_ID)
);

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
	POST_ID	VARCHAR2(255),
	TITLE	VARCHAR2(500) NOT NULL,
	CONTENT CLOB NOT NULL,
	LOCATION VARCHAR2(500) NOT NULL,
	CREATED_AT	DATE DEFAULT SYSDATE,
	UPDATED_AT	DATE,
	USER_ID	VARCHAR2(255) NOT NULL,
	LIKE_COUNT	NUMBER DEFAULT 0,
	OFILE1	VARCHAR2(500),
	OFILE2	VARCHAR2(500),
	OFILE3	VARCHAR2(500),
	OFILE4	VARCHAR2(500),
	OFILE5	VARCHAR2(500),
	RFILE1	VARCHAR2(500),
	RFILE2	VARCHAR2(500),
	RFILE3	VARCHAR2(500),
	RFILE4	VARCHAR2(500),
	RFILE5	VARCHAR2(500),
    CONSTRAINT PK_GUIDE_BOARD_ID PRIMARY KEY (POST_ID)
    , CONSTRAINT FK_GUIDE_BOARD_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
);

CREATE TABLE CHATTING_ROOM (
	CHATTING_NO	    VARCHAR2(255),
	CH_CREATE_DATE	DATE DEFAULT SYSDATE,
	GUIDE_ID	        VARCHAR2(255)		NOT NULL,
	USER_ID	        VARCHAR2(255)		NOT NULL,
    CONSTRAINT PK_CHATTING_NO PRIMARY KEY (CHATTING_NO)
    , CONSTRAINT FK_CHAT_GUIDEID FOREIGN KEY (GUIDE_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
    , CONSTRAINT FK_CHAT_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

CREATE TABLE CHAT_MESSAGE (
	MESSAGE_NO	        VARCHAR2(255),
	MESSAGE_CONTENT	CLOB NOT NULL,
	READ_FL	            CHAR(1) NOT NULL,
	SEND_TIME	        TIMESTAMP NOT NULL,
	MEM_ID	            VARCHAR2(255) NOT NULL,
	CHATTING_NO	        VARCHAR2(255) NOT NULL,
    CONSTRAINT PK_MESSAGE_NO PRIMARY KEY (MESSAGE_NO)
    , CONSTRAINT FK_CHAT_MEM_ID FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
    , CONSTRAINT FK_CHATTING_NO FOREIGN KEY (CHATTING_NO) REFERENCES CHATTING_ROOM(CHATTING_NO)
    , CONSTRAINT CHK_READ_FL CHECK (READ_FL IN ('Y', 'N'))
);

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

COMMENT ON COLUMN PLACE.PLACE_ID IS '��ҽĺ��ڵ�';
COMMENT ON COLUMN PLACE.PLACE_NAME IS '����̸�';
COMMENT ON COLUMN PLACE.ADDRESS IS '�ּ�';
COMMENT ON COLUMN PLACE.LATITUDE IS '����';
COMMENT ON COLUMN PLACE.LONGITUDE IS '�浵';

COMMENT ON COLUMN ROUTE.ROUTE_ID IS '��νĺ��ڵ�';
COMMENT ON COLUMN ROUTE.ROUTE_BOARD_ID IS '�Խñ۽ĺ��ڵ�';
COMMENT ON COLUMN ROUTE.ROUTE_PLACE_ID IS '�������ĺ��ڵ�';
COMMENT ON COLUMN ROUTE.ROUTE_PLACE_ORDER_NO IS '����������';

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

COMMENT ON COLUMN CHATTING_ROOM.CHATTING_NO IS 'ä�ù�ĺ��ڵ�';
COMMENT ON COLUMN CHATTING_ROOM.CH_CREATE_DATE IS 'ä�ù��������';
COMMENT ON COLUMN CHATTING_ROOM.GUIDE_ID IS 'ä�ù氳����ID';
COMMENT ON COLUMN CHATTING_ROOM.USER_ID IS 'ä�ù�������ID';

COMMENT ON COLUMN CHAT_MESSAGE.MESSAGE_NO IS 'ä�ó����ĺ��ڵ�';
COMMENT ON COLUMN CHAT_MESSAGE.MESSAGE_CONTENT IS 'ä�ó���';
COMMENT ON COLUMN CHAT_MESSAGE.READ_FL IS '��������';
COMMENT ON COLUMN CHAT_MESSAGE.SEND_TIME IS 'ä�ú����ð�';
COMMENT ON COLUMN CHAT_MESSAGE.MEM_ID IS 'ä�ú��������ID';
COMMENT ON COLUMN CHAT_MESSAGE.CHATTING_NO IS 'ä�ù�ĺ��ڵ�';

COMMENT ON COLUMN LIKE_COUNT.USER_ID IS '��õ��ID';
COMMENT ON COLUMN LIKE_COUNT.POST_ID IS '�Խñ� �ĺ��ڵ�';

-- �ĺ��ڵ带 ���� ������ ����
-- �������� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_NOTICE
START WITH 100
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

-- ä�ù� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_CHATTING_ROOM
NOCYCLE
NOCACHE;

-- ä�ó��� �ĺ��ڵ� ������
CREATE SEQUENCE SEQ_CHAT_MESSAGE
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
INSERT INTO MEMBER (MEM_ID, MEM_NAME, MEM_TYPE, MEM_PW, MEM_NICKNM, MEM_JOIN_DATE, MEM_STATUS)
VALUES ('ADMIN@synergysoft.co.kr', '������', 'ADMIN', '123456', 'ADMIN', SYSDATE, 'ACTIVE');
COMMIT;

-- ��������(notice) test data �߰�
DELETE FROM NOTICE;
COMMIT;
INSERT INTO NOTICE VALUES ('notice_1','1.���������Դϴ�.','�������� ����1','admin','2024-03-20',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_2','2.���������Դϴ�.','�������� ����2','admin','2024-03-21',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_3','3.���������Դϴ�.','�������� ����3','admin','2024-03-22',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_4','4.���������Դϴ�.','�������� ����4','admin','2024-03-23',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_5','5.���������Դϴ�.','�������� ����5','admin','2024-03-24',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_6','6.���������Դϴ�.','�������� ����6','admin','2024-03-25',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_7','7.���������Դϴ�.','�������� ����7','admin','2024-03-26',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_8','8.���������Դϴ�.','�������� ����8','admin','2024-03-27',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_9','9.���������Դϴ�.','�������� ����9','admin','2024-03-28',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_10','10.���������Դϴ�.','�������� ����10','admin','2024-03-29',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_11','11.���������Դϴ�.','�������� ����11','admin','2024-03-30',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_12','12.���������Դϴ�.','�������� ����12','admin','2024-03-31',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_13','13.���������Դϴ�.','�������� ����13','admin','2024-04-01',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_14','14.���������Դϴ�.','�������� ����14','admin','2024-04-02',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_15','15.���������Դϴ�.','�������� ����15','admin','2024-04-03',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_16','16.���������Դϴ�.','�������� ����16','admin','2024-04-04',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_17','17.���������Դϴ�.','�������� ����17','admin','2024-04-05',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_18','18.���������Դϴ�.','�������� ����18','admin','2024-04-06',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_19','19.���������Դϴ�.','�������� ����19','admin','2024-04-07',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_20','20.���������Դϴ�.','�������� ����20','admin','2024-04-08',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_21','21.���������Դϴ�.','�������� ����21','admin','2024-04-09',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_22','22.���������Դϴ�.','�������� ����22','admin','2024-04-10',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_23','23.���������Դϴ�.','�������� ����23','admin','2024-04-11',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_24','24.���������Դϴ�.','�������� ����24','admin','2024-04-12',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_25','25.���������Դϴ�.','�������� ����25','admin','2024-04-13',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_26','26.���������Դϴ�.','�������� ����26','admin','2024-04-14',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_27','27.���������Դϴ�.','�������� ����27','admin','2024-04-15',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_28','28.���������Դϴ�.','�������� ����28','admin','2024-04-16',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_29','29.���������Դϴ�.','�������� ����29','admin','2024-04-17',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_30','30.���������Դϴ�.','�������� ����30','admin','2024-04-18',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_31','31.���������Դϴ�.','�������� ����31','admin','2024-04-19',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_32','32.���������Դϴ�.','�������� ����32','admin','2024-04-20',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_33','33.���������Դϴ�.','�������� ����33','admin','2024-04-21',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_34','34.���������Դϴ�.','�������� ����34','admin','2024-04-22',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_35','35.���������Դϴ�.','�������� ����35','admin','2024-04-23',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_36','36.���������Դϴ�.','�������� ����36','admin','2024-04-24',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_37','37.���������Դϴ�.','�������� ����37','admin','2024-04-25',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_38','38.���������Դϴ�.','�������� ����38','admin','2024-04-26',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_39','39.���������Դϴ�.','�������� ����39','admin','2024-04-27',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_40','40.���������Դϴ�.','�������� ����40','admin','2024-04-28',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_41','41.���������Դϴ�.','�������� ����41','admin','2024-04-29',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_42','42.���������Դϴ�.','�������� ����42','admin','2024-04-30',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_43','43.���������Դϴ�.','�������� ����43','admin','2024-05-01',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_44','44.���������Դϴ�.','�������� ����44','admin','2024-05-02',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_45','45.���������Դϴ�.','�������� ����45','admin','2024-05-03',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_46','46.���������Դϴ�.','�������� ����46','admin','2024-05-04',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_47','47.���������Դϴ�.','�������� ����47','admin','2024-05-05',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_48','48.���������Դϴ�.','�������� ����48','admin','2024-05-06',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_49','49.���������Դϴ�.','�������� ����49','admin','2024-05-07',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_50','50.���������Դϴ�.','�������� ����50','admin','2024-05-08',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_51','51.���������Դϴ�.','�������� ����51','admin','2024-05-09',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_52','52.���������Դϴ�.','�������� ����52','admin','2024-05-10',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_53','53.���������Դϴ�.','�������� ����53','admin','2024-05-11',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_54','54.���������Դϴ�.','�������� ����54','admin','2024-05-12',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_55','55.���������Դϴ�.','�������� ����55','admin','2024-05-13',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_56','56.���������Դϴ�.','�������� ����56','admin','2024-05-14',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_57','57.���������Դϴ�.','�������� ����57','admin','2024-05-15',null,'N',null,'N',null,null,null,null,null,null);
INSERT INTO NOTICE VALUES ('notice_58','58.���������Դϴ�.','�������� ����58','admin','2024-05-16',null,'N',null,'N',null,null,null,null,null,null);
commit;

-- ��������(notice) test data �߰�
INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, MEM_ID, LIKE_COUNT)
VALUES ('001', '��α� ����Ʈ1�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���1', '����', TO_DATE('2022-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'user01', 71);
    
INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT)
VALUES ('001', '��α� ����Ʈ1�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���1', '����', TO_DATE('2022-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'user01', 71);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT)
VALUES ('002', '��α� ����Ʈ2�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���2', '�λ�', TO_DATE('2022-12-30', 'YYYY-MM-DD'), TO_DATE('2023-12-02', 'YYYY-MM-DD'), 'user01', 72);


INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT)
VALUES ('003', '��α� ����Ʈ3�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���3', '����', TO_DATE('2022-10-03', 'YYYY-MM-DD'), TO_DATE('2023-12-03', 'YYYY-MM-DD'), 'user01', 73);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT)
VALUES ('004', '��α� ����Ʈ4�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���4', '����', TO_DATE('2022-09-23', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'user01', 5);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT)
VALUES ('005', '��α� ����Ʈ5�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���5', '����', TO_DATE('2022-12-31', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 'user01', 79);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT)
VALUES ('006', '��α� ����Ʈ6�Դϴ�.', '��α׿� ���� �����Դϴ�. Ȯ�����ּ���6', '����', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 77);

commit;




-- qna(qna) test data �߰�
DELETE FROM QNA;
COMMIT;
INSERT INTO QNA VALUES ('qna_1','1�׽�Ʈ qna','1 ���� qna','user01','2024-03-20',null,'admin01','Y','1 �����ڳ���','2024-03-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_2','2�׽�Ʈ qna','2 ���� qna','user01','2024-03-21',null,'admin01','Y','2 �����ڳ���','2024-03-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_3','3�׽�Ʈ qna','3 ���� qna','user01','2024-03-22',null,'admin01','Y','3 �����ڳ���','2024-03-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_4','4�׽�Ʈ qna','4 ���� qna','user01','2024-03-23',null,'admin01','Y','4 �����ڳ���','2024-03-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_5','5�׽�Ʈ qna','5 ���� qna','user01','2024-03-24',null,'admin01','Y','5 �����ڳ���','2024-03-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_6','6�׽�Ʈ qna','6 ���� qna','user01','2024-03-25',null,'admin01','Y','6 �����ڳ���','2024-03-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_7','7�׽�Ʈ qna','7 ���� qna','user01','2024-03-26',null,'admin01','Y','7 �����ڳ���','2024-03-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_8','8�׽�Ʈ qna','8 ���� qna','user01','2024-03-27',null,'admin01','Y','8 �����ڳ���','2024-03-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_9','9�׽�Ʈ qna','9 ���� qna','user01','2024-03-28',null,'admin01','Y','9 �����ڳ���','2024-03-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_10','10�׽�Ʈ qna','10 ���� qna','user01','2024-03-29',null,'admin01','Y','10 �����ڳ���','2024-03-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_11','11�׽�Ʈ qna','11 ���� qna','user01','2024-03-30',null,'admin01','Y','11 �����ڳ���','2024-03-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_12','12�׽�Ʈ qna','12 ���� qna','user01','2024-03-31',null,'admin01','Y','12 �����ڳ���','2024-03-31','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_13','13�׽�Ʈ qna','13 ���� qna','user01','2024-04-01',null,'admin01','Y','13 �����ڳ���','2024-04-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_14','14�׽�Ʈ qna','14 ���� qna','user01','2024-04-02',null,'admin01','Y','14 �����ڳ���','2024-04-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_15','15�׽�Ʈ qna','15 ���� qna','user01','2024-04-03',null,'admin01','Y','15 �����ڳ���','2024-04-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_16','16�׽�Ʈ qna','16 ���� qna','user01','2024-04-04',null,'admin01','Y','16 �����ڳ���','2024-04-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_17','17�׽�Ʈ qna','17 ���� qna','user01','2024-04-05',null,'admin01','Y','17 �����ڳ���','2024-04-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_18','18�׽�Ʈ qna','18 ���� qna','user01','2024-04-06',null,'admin01','Y','18 �����ڳ���','2024-04-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_19','19�׽�Ʈ qna','19 ���� qna','user01','2024-04-07',null,'admin01','Y','19 �����ڳ���','2024-04-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_20','20�׽�Ʈ qna','20 ���� qna','user01','2024-04-08',null,'admin01','Y','20 �����ڳ���','2024-04-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_21','21�׽�Ʈ qna','21 ���� qna','user01','2024-04-09',null,'admin01','Y','21 �����ڳ���','2024-04-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_22','22�׽�Ʈ qna','22 ���� qna','user01','2024-04-10',null,'admin01','Y','22 �����ڳ���','2024-04-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_23','23�׽�Ʈ qna','23 ���� qna','user01','2024-04-11',null,'admin01','Y','23 �����ڳ���','2024-04-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_24','24�׽�Ʈ qna','24 ���� qna','user01','2024-04-12',null,'admin01','Y','24 �����ڳ���','2024-04-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_25','25�׽�Ʈ qna','25 ���� qna','user01','2024-04-13',null,'admin01','Y','25 �����ڳ���','2024-04-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_26','26�׽�Ʈ qna','26 ���� qna','user01','2024-04-14',null,'admin01','Y','26 �����ڳ���','2024-04-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_27','27�׽�Ʈ qna','27 ���� qna','user01','2024-04-15',null,'admin01','Y','27 �����ڳ���','2024-04-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_28','28�׽�Ʈ qna','28 ���� qna','user01','2024-04-16',null,'admin01','Y','28 �����ڳ���','2024-04-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_29','29�׽�Ʈ qna','29 ���� qna','user01','2024-04-17',null,'admin01','Y','29 �����ڳ���','2024-04-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_30','30�׽�Ʈ qna','30 ���� qna','user01','2024-04-18',null,'admin01','Y','30 �����ڳ���','2024-04-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_31','31�׽�Ʈ qna','31 ���� qna','user01','2024-04-19',null,'admin01','Y','31 �����ڳ���','2024-04-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_32','32�׽�Ʈ qna','32 ���� qna','user01','2024-04-20',null,'admin01','Y','32 �����ڳ���','2024-04-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_33','33�׽�Ʈ qna','33 ���� qna','user01','2024-04-21',null,'admin01','Y','33 �����ڳ���','2024-04-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_34','34�׽�Ʈ qna','34 ���� qna','user01','2024-04-22',null,'admin01','Y','34 �����ڳ���','2024-04-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_35','35�׽�Ʈ qna','35 ���� qna','user01','2024-04-23',null,'admin01','Y','35 �����ڳ���','2024-04-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_36','36�׽�Ʈ qna','36 ���� qna','user01','2024-04-24',null,'admin01','Y','36 �����ڳ���','2024-04-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_37','37�׽�Ʈ qna','37 ���� qna','user01','2024-04-25',null,'admin01','Y','37 �����ڳ���','2024-04-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_38','38�׽�Ʈ qna','38 ���� qna','user01','2024-04-26',null,'admin01','Y','38 �����ڳ���','2024-04-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_39','39�׽�Ʈ qna','39 ���� qna','user01','2024-04-27',null,'admin01','Y','39 �����ڳ���','2024-04-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_40','40�׽�Ʈ qna','40 ���� qna','user01','2024-04-28',null,'admin01','Y','40 �����ڳ���','2024-04-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_41','41�׽�Ʈ qna','41 ���� qna','user01','2024-04-29',null,'admin01','Y','41 �����ڳ���','2024-04-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_42','42�׽�Ʈ qna','42 ���� qna','user01','2024-04-30',null,'admin01','Y','42 �����ڳ���','2024-04-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_43','43�׽�Ʈ qna','43 ���� qna','user01','2024-05-01',null,'admin01','Y','43 �����ڳ���','2024-05-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_44','44�׽�Ʈ qna','44 ���� qna','user01','2024-05-02',null,'admin01','Y','44 �����ڳ���','2024-05-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_45','45�׽�Ʈ qna','45 ���� qna','user01','2024-05-03',null,'admin01','Y','45 �����ڳ���','2024-05-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_46','46�׽�Ʈ qna','46 ���� qna','user01','2024-05-04',null,'admin01','Y','46 �����ڳ���','2024-05-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_47','47�׽�Ʈ qna','47 ���� qna','user01','2024-05-05',null,'admin01','Y','47 �����ڳ���','2024-05-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_48','48�׽�Ʈ qna','48 ���� qna','user01','2024-05-06',null,'admin01','Y','48 �����ڳ���','2024-05-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_49','49�׽�Ʈ qna','49 ���� qna','user01','2024-05-07',null,'admin01','Y','49 �����ڳ���','2024-05-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_50','50�׽�Ʈ qna','50 ���� qna','user01','2024-05-08',null,'admin01','Y','50 �����ڳ���','2024-05-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_51','51�׽�Ʈ qna','51 ���� qna','user01','2024-05-09',null,'admin01','Y','51 �����ڳ���','2024-05-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_52','52�׽�Ʈ qna','52 ���� qna','user01','2024-05-10',null,'admin01','Y','52 �����ڳ���','2024-05-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_53','53�׽�Ʈ qna','53 ���� qna','user01','2024-05-11',null,'admin01','Y','53 �����ڳ���','2024-05-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_54','54�׽�Ʈ qna','54 ���� qna','user01','2024-05-12',null,'admin01','Y','54 �����ڳ���','2024-05-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_55','55�׽�Ʈ qna','55 ���� qna','user01','2024-05-13',null,'admin01','Y','55 �����ڳ���','2024-05-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_56','56�׽�Ʈ qna','56 ���� qna','user01','2024-05-14',null,'admin01','Y','56 �����ڳ���','2024-05-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_57','57�׽�Ʈ qna','57 ���� qna','user01','2024-05-15',null,'admin01','Y','57 �����ڳ���','2024-05-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_58','58�׽�Ʈ qna','58 ���� qna','user01','2024-05-16',null,'admin01','Y','58 �����ڳ���','2024-05-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_59','59�׽�Ʈ qna','59 ���� qna','user01','2024-05-17',null,'admin01','Y','59 �����ڳ���','2024-05-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_60','60�׽�Ʈ qna','60 ���� qna','user01','2024-05-18',null,'admin01','Y','60 �����ڳ���','2024-05-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_61','61�׽�Ʈ qna','61 ���� qna','user01','2024-05-19',null,'admin01','Y','61 �����ڳ���','2024-05-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_62','62�׽�Ʈ qna','62 ���� qna','user01','2024-05-20',null,'admin01','Y','62 �����ڳ���','2024-05-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_63','63�׽�Ʈ qna','63 ���� qna','user01','2024-05-21',null,'admin01','Y','63 �����ڳ���','2024-05-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_64','64�׽�Ʈ qna','64 ���� qna','user01','2024-05-22',null,'admin01','Y','64 �����ڳ���','2024-05-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_65','65�׽�Ʈ qna','65 ���� qna','user01','2024-05-23',null,'admin01','Y','65 �����ڳ���','2024-05-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_66','66�׽�Ʈ qna','66 ���� qna','user01','2024-05-24',null,'admin01','Y','66 �����ڳ���','2024-05-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_67','67�׽�Ʈ qna','67 ���� qna','user01','2024-05-25',null,'admin01','Y','67 �����ڳ���','2024-05-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_68','68�׽�Ʈ qna','68 ���� qna','user01','2024-05-26',null,'admin01','Y','68 �����ڳ���','2024-05-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_69','69�׽�Ʈ qna','69 ���� qna','user01','2024-05-27',null,'admin01','Y','69 �����ڳ���','2024-05-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_70','70�׽�Ʈ qna','70 ���� qna','user01','2024-05-28',null,'admin01','Y','70 �����ڳ���','2024-05-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_71','71�׽�Ʈ qna','71 ���� qna','user01','2024-05-29',null,'admin01','Y','71 �����ڳ���','2024-05-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_72','72�׽�Ʈ qna','72 ���� qna','user01','2024-05-30',null,'admin01','Y','72 �����ڳ���','2024-05-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_73','73�׽�Ʈ qna','73 ���� qna','user01','2024-05-31',null,'admin01','Y','73 �����ڳ���','2024-05-31','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_74','74�׽�Ʈ qna','74 ���� qna','user01','2024-06-01',null,'admin01','Y','74 �����ڳ���','2024-06-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_75','75�׽�Ʈ qna','75 ���� qna','user01','2024-06-02',null,'admin01','Y','75 �����ڳ���','2024-06-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_76','76�׽�Ʈ qna','76 ���� qna','user01','2024-06-03',null,'admin01','Y','76 �����ڳ���','2024-06-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_77','77�׽�Ʈ qna','77 ���� qna','user01','2024-06-04',null,'admin01','Y','77 �����ڳ���','2024-06-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_78','78�׽�Ʈ qna','78 ���� qna','user01','2024-06-05',null,'admin01','Y','78 �����ڳ���','2024-06-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_79','79�׽�Ʈ qna','79 ���� qna','user01','2024-06-06',null,'admin01','Y','79 �����ڳ���','2024-06-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_80','80�׽�Ʈ qna','80 ���� qna','user01','2024-06-07',null,'admin01','Y','80 �����ڳ���','2024-06-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_81','81�׽�Ʈ qna','81 ���� qna','user01','2024-06-08',null,'admin01','Y','81 �����ڳ���','2024-06-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_82','82�׽�Ʈ qna','82 ���� qna','user01','2024-06-09',null,'admin01','Y','82 �����ڳ���','2024-06-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_83','83�׽�Ʈ qna','83 ���� qna','user01','2024-06-10',null,'admin01','Y','83 �����ڳ���','2024-06-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_84','84�׽�Ʈ qna','84 ���� qna','user01','2024-06-11',null,'admin01','Y','84 �����ڳ���','2024-06-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_85','85�׽�Ʈ qna','85 ���� qna','user01','2024-06-12',null,'admin01','Y','85 �����ڳ���','2024-06-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_86','86�׽�Ʈ qna','86 ���� qna','user01','2024-06-13',null,'admin01','Y','86 �����ڳ���','2024-06-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_87','87�׽�Ʈ qna','87 ���� qna','user01','2024-06-14',null,'admin01','Y','87 �����ڳ���','2024-06-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_88','88�׽�Ʈ qna','88 ���� qna','user01','2024-06-15',null,'admin01','Y','88 �����ڳ���','2024-06-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_89','89�׽�Ʈ qna','89 ���� qna','user01','2024-06-16',null,'admin01','Y','89 �����ڳ���','2024-06-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_90','90�׽�Ʈ qna','90 ���� qna','user01','2024-06-17',null,'admin01','Y','90 �����ڳ���','2024-06-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_91','91�׽�Ʈ qna','91 ���� qna','user01','2024-06-18',null,'admin01','Y','91 �����ڳ���','2024-06-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_92','92�׽�Ʈ qna','92 ���� qna','user01','2024-06-19',null,'admin01','Y','92 �����ڳ���','2024-06-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_93','93�׽�Ʈ qna','93 ���� qna','user01','2024-06-20',null,'admin01','Y','93 �����ڳ���','2024-06-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_94','94�׽�Ʈ qna','94 ���� qna','user01','2024-06-21',null,'admin01','Y','94 �����ڳ���','2024-06-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_95','95�׽�Ʈ qna','95 ���� qna','user01','2024-06-22',null,'admin01','Y','95 �����ڳ���','2024-06-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_96','96�׽�Ʈ qna','96 ���� qna','user01','2024-06-23',null,'admin01','Y','96 �����ڳ���','2024-06-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_97','97�׽�Ʈ qna','97 ���� qna','user01','2024-06-24',null,'admin01','Y','97 �����ڳ���','2024-06-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_98','98�׽�Ʈ qna','98 ���� qna','user01','2024-06-25',null,'admin01','Y','98 �����ڳ���','2024-06-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_99','99�׽�Ʈ qna','99 ���� qna','user01','2024-06-26',null,'admin01','Y','99 �����ڳ���','2024-06-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_100','100�׽�Ʈ qna','100 ���� qna','user01','2024-06-27',null,'admin01','Y','100 �����ڳ���','2024-06-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);

commit;

-- ����������̺� ����
DROP TABLE NOTICE_20240928;
-- ������̺� ����
CREATE TABLE NOTICE_20240928 AS SELECT * FROM NOTICE;

-- ����������̺� ����
DROP TABLE QNA_20241007;
-- ������̺� ����
CREATE TABLE QNA_20241007 AS SELECT * FROM QNA;

