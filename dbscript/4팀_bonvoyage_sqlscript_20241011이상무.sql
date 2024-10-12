-- 표 생성 전 기존 생성된 표 삭제
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

-- 시퀀스 생성 전 기존 생성된 시퀀스 삭제
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

-- 표 생성
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
	MEM_STATUS	        VARCHAR(255) NOT NULL,   -- 사용자의 상태를 4가지로 구분. '정상 : ACTIVE' , '정지 : BLOCKED' , '휴면 : INACTIVE' , '탈퇴 : LEFT'
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
    READ_COUNT     NUMBER DEFAULT 0,
    CONSTRAINT PK_ROUTE_BOARD_ID PRIMARY KEY (ROUTE_BOARD_ID)
    , CONSTRAINT FK_ROUTE_BOARD_USERID FOREIGN KEY (USER_ID) REFERENCES MEMBER(MEM_ID) ON DELETE SET NULL
);

CREATE TABLE PLACE (
	PLACE_ID	        VARCHAR2(255),
	PLACE_NAME	    VARCHAR2(255) NOT NULL,
	ADDRESS 	    VARCHAR2(255),
	LATITUDE	        NUMBER,
	LONGITUDE	    NUMBER,
    PLACE_CONTENT   CLOB,
    ROUTE_BOARD_ID  VARCHAR2(255),
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

-- comment 삽입
COMMENT ON COLUMN MEMBER.MEM_ID IS '사용자ID';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '사용자이름';
COMMENT ON COLUMN MEMBER.MEM_TYPE IS '사용자타입';
COMMENT ON COLUMN MEMBER.MEM_PW IS '사용자비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NICKNM IS '사용자닉네임';
COMMENT ON COLUMN MEMBER.MEM_JOIN_DATE IS '가입날짜';
COMMENT ON COLUMN MEMBER.MEM_PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.MEM_BIRTH IS '생년월일';
COMMENT ON COLUMN MEMBER.MEM_SOCIAL IS '소셜구분';
COMMENT ON COLUMN MEMBER.MEM_STATUS IS '사용자상태';
COMMENT ON COLUMN MEMBER.MEM_LOGIN_LOG IS '로그인기록';
COMMENT ON COLUMN MEMBER.MEM_LOGOUT_LOG IS '로그아웃기록';
COMMENT ON COLUMN MEMBER.MEM_STATUS_DATE IS '사용자상태적용날짜';
COMMENT ON COLUMN MEMBER.MEM_PW_UPDATE IS '비밀번호수정날짜';

COMMENT ON COLUMN NOTICE.NOTICE_ID IS '공지식별코드';
COMMENT ON COLUMN NOTICE.TITLE IS '공지제목';
COMMENT ON COLUMN NOTICE.CONTENT IS '공지내용';
COMMENT ON COLUMN NOTICE.ADMIN_ID IS '작성한관리자ID';
COMMENT ON COLUMN NOTICE.CREATED_AT IS '공지작성일자';
COMMENT ON COLUMN NOTICE.UPDATED_AT IS '공지수정일자';
COMMENT ON COLUMN NOTICE.UPDATE_CHECK IS '공지수정여부';
COMMENT ON COLUMN NOTICE.DELETED_AT IS '공지삭제일자';
COMMENT ON COLUMN NOTICE.DELETE_CHECK IS '공지삭제여부';
COMMENT ON COLUMN NOTICE.OFILE1 IS '기존첨부파일1';
COMMENT ON COLUMN NOTICE.OFILE2 IS '기존첨부파일2';
COMMENT ON COLUMN NOTICE.OFiLE3 IS '기존첨부파일3';
COMMENT ON COLUMN NOTICE.RFiLE1 IS '수정첨부파일1';
COMMENT ON COLUMN NOTICE.RFiLE2 IS '수정첨부파일2';
COMMENT ON COLUMN NOTICE.RFiLE3 IS '수정첨부파일3';
COMMENT ON COLUMN NOTICE.READ_COUNT IS '조회수';


COMMENT ON COLUMN QNA.QNA_ID IS '질문글식별코드';
COMMENT ON COLUMN QNA.TITLE IS '질문제목';
COMMENT ON COLUMN QNA.USER_CONTENT IS '질문내용';
COMMENT ON COLUMN QNA.USER_ID IS '질문작성자ID';
COMMENT ON COLUMN QNA.Q_CREATED_AT IS '질문작성일자';
COMMENT ON COLUMN QNA.Q_UPDATED_AT IS '질문수정일자';
COMMENT ON COLUMN QNA.ADMIN_ID IS '답변관리자ID';
COMMENT ON COLUMN QNA.IS_ACCEPT IS '답변여부';
COMMENT ON COLUMN QNA.ADMIN_CONTENT IS '답변내용';
COMMENT ON COLUMN QNA.A_CREATED_AT IS '답변작성일자';
COMMENT ON COLUMN QNA.IS_SECRET IS '질문공개여부';
COMMENT ON COLUMN QNA.DELETE_AT IS '삭제일자';
COMMENT ON COLUMN QNA.DELETE_CHECK IS '삭제여부';
COMMENT ON COLUMN QNA.OFILE1 IS '기존첨부파일1';
COMMENT ON COLUMN QNA.OFILE2 IS '기존첨부파일2';
COMMENT ON COLUMN QNA.OFILE3 IS '기존첨부파일3';
COMMENT ON COLUMN QNA.OFILE4 IS '기존첨부파일4';
COMMENT ON COLUMN QNA.OFILE5 IS '기존첨부파일5';
COMMENT ON COLUMN QNA.RFILE1 IS '수정첨부파일1';
COMMENT ON COLUMN QNA.RFILE2 IS '수정첨부파일2';
COMMENT ON COLUMN QNA.RFILE3 IS '수정첨부파일3';
COMMENT ON COLUMN QNA.RFILE4 IS '수정첨부파일4';
COMMENT ON COLUMN QNA.RFILE5 IS '수정첨부파일5';

COMMENT ON COLUMN GUIDE_BOARD.POST_ID IS '게시글식별코드';
COMMENT ON COLUMN GUIDE_BOARD.TITLE IS '가이드글제목';
COMMENT ON COLUMN GUIDE_BOARD.CONTENT IS '가이드글내용';
COMMENT ON COLUMN GUIDE_BOARD.LOCATION IS '지역';
COMMENT ON COLUMN GUIDE_BOARD.CREATED_AT IS '가이드글작성일자';
COMMENT ON COLUMN GUIDE_BOARD.UPDATED_AT IS '가이드글수정일자';
COMMENT ON COLUMN GUIDE_BOARD.USER_ID IS '가이드ID';
COMMENT ON COLUMN GUIDE_BOARD.LIKE_COUNT IS '게시글 추천수';
COMMENT ON COLUMN GUIDE_BOARD.OFILE1 IS '기존첨부파일1';
COMMENT ON COLUMN GUIDE_BOARD.OFILE2 IS '기존첨부파일2';
COMMENT ON COLUMN GUIDE_BOARD.OFILE3 IS '기존첨부파일3';
COMMENT ON COLUMN GUIDE_BOARD.OFILE4 IS '기존첨부파일4';
COMMENT ON COLUMN GUIDE_BOARD.OFILE5 IS '기존첨부파일5';
COMMENT ON COLUMN GUIDE_BOARD.RFILE1 IS '수정첨부파일1';
COMMENT ON COLUMN GUIDE_BOARD.RFILE2 IS '수정첨부파일2';
COMMENT ON COLUMN GUIDE_BOARD.RFILE3 IS '수정첨부파일3';
COMMENT ON COLUMN GUIDE_BOARD.RFILE4 IS '수정첨부파일4';
COMMENT ON COLUMN GUIDE_BOARD.RFILE5 IS '수정첨부파일5';
COMMENT ON COLUMN GUIDE_BOARD.READ_COUNT IS '조회수';

COMMENT ON COLUMN TB_COMMENT.COMMENT_ID IS '댓글식별코드';
COMMENT ON COLUMN TB_COMMENT.USER_ID IS '댓글작성자ID';
COMMENT ON COLUMN TB_COMMENT.POST_ID IS '게시글ID';
COMMENT ON COLUMN TB_COMMENT.CONTENT IS '댓글내용';
COMMENT ON COLUMN TB_COMMENT.CREATED_AT IS '댓글작성일자';
COMMENT ON COLUMN TB_COMMENT.UPDATED_AT IS '댓글수정일자';

COMMENT ON COLUMN ROUTE_BOARD.ROUTE_BOARD_ID IS '경로추천게시글식별코드';
COMMENT ON COLUMN ROUTE_BOARD.USER_ID IS '경로추천글작성자ID';
COMMENT ON COLUMN ROUTE_BOARD.TITLE IS '경로추천글제목';
COMMENT ON COLUMN ROUTE_BOARD.CONTENT IS '경로추천내용';
COMMENT ON COLUMN ROUTE_BOARD.TRANSPORT IS '교통수단';
COMMENT ON COLUMN ROUTE_BOARD.CREATED_AT IS '글작성일자';
COMMENT ON COLUMN ROUTE_BOARD.UPDATED_AT IS '글수정일자';
COMMENT ON COLUMN ROUTE_BOARD.LIKE_COUNT IS '게시글추천수';
COMMENT ON COLUMN ROUTE_BOARD.TOTAL_DURATION IS '추천한경로 총 소요시간';
COMMENT ON COLUMN ROUTE_BOARD.ROUTE_NAME IS '추천경로이름';
COMMENT ON COLUMN ROUTE_BOARD.OFILE1 IS '기존첨부파일1';
COMMENT ON COLUMN ROUTE_BOARD.OFILE2 IS '기존첨부파일2';
COMMENT ON COLUMN ROUTE_BOARD.OFILE3 IS '기존첨부파일3';
COMMENT ON COLUMN ROUTE_BOARD.OFILE4 IS '기존첨부파일4';
COMMENT ON COLUMN ROUTE_BOARD.OFILE5 IS '기존첨부파일5';
COMMENT ON COLUMN ROUTE_BOARD.RFILE1 IS '수정첨부파일1';
COMMENT ON COLUMN ROUTE_BOARD.RFILE2 IS '수정첨부파일2';
COMMENT ON COLUMN ROUTE_BOARD.RFILE3 IS '수정첨부파일3';
COMMENT ON COLUMN ROUTE_BOARD.RFILE4 IS '수정첨부파일4';
COMMENT ON COLUMN ROUTE_BOARD.RFILE5 IS '수정첨부파일5';
COMMENT ON COLUMN ROUTE_BOARD.READ_COUNT IS '조회수';

COMMENT ON COLUMN PLACE.PLACE_ID IS '장소식별코드';
COMMENT ON COLUMN PLACE.PLACE_NAME IS '장소이름';
COMMENT ON COLUMN PLACE.ADDRESS IS '주소';
COMMENT ON COLUMN PLACE.LATITUDE IS '위도';
COMMENT ON COLUMN PLACE.LONGITUDE IS '경도';
COMMENT ON COLUMN PLACE.PLACE_CONTENT IS '장소설명';
COMMENT ON COLUMN PLACE.ROUTE_BOARD_ID IS '게시글식별코드';

COMMENT ON COLUMN ROUTE.ROUTE_ID IS '경로식별코드';
COMMENT ON COLUMN ROUTE.ROUTE_BOARD_ID IS '게시글식별코드';
COMMENT ON COLUMN ROUTE.ROUTE_PLACE_ID IS '경유지식별코드';
COMMENT ON COLUMN ROUTE.ROUTE_PLACE_ORDER_NO IS '경유지순번';

COMMENT ON COLUMN CHATTING_ROOM.CHATTING_NO IS '채팅방식별코드';
COMMENT ON COLUMN CHATTING_ROOM.CH_CREATE_DATE IS '채팅방생성일자';
COMMENT ON COLUMN CHATTING_ROOM.GUIDE_ID IS '채팅방개설자ID';
COMMENT ON COLUMN CHATTING_ROOM.USER_ID IS '채팅방참여자ID';

COMMENT ON COLUMN CHAT_MESSAGE.MESSAGE_NO IS '채팅내역식별코드';
COMMENT ON COLUMN CHAT_MESSAGE.MESSAGE_CONTENT IS '채팅내용';
COMMENT ON COLUMN CHAT_MESSAGE.READ_FL IS '읽음여부';
COMMENT ON COLUMN CHAT_MESSAGE.SEND_TIME IS '채팅보낸시간';
COMMENT ON COLUMN CHAT_MESSAGE.MEM_ID IS '채팅보낸사용자ID';
COMMENT ON COLUMN CHAT_MESSAGE.CHATTING_NO IS '채팅방식별코드';

COMMENT ON COLUMN LIKE_COUNT.USER_ID IS '추천자ID';
COMMENT ON COLUMN LIKE_COUNT.POST_ID IS '게시글 식별코드';

COMMENT ON COLUMN REPORT.REPORT_ID IS '신고게시글 식별코드';
COMMENT ON COLUMN REPORT.POST_ID IS '게시글 식별코드';
COMMENT ON COLUMN REPORT.REPORT_USER_ID IS '신고자';
COMMENT ON COLUMN REPORT.REPORTING_REASON IS '신고사유';
COMMENT ON COLUMN REPORT.DETAIL IS '상세내용';
COMMENT ON COLUMN REPORT.REPORT_DATE IS '신고일자';
COMMENT ON COLUMN REPORT.CHECKED_ADMIN IS '관리자 확인여부';
COMMENT ON COLUMN REPORT.CHECKED_ADMIN_ID IS '확인한 관리자';
COMMENT ON COLUMN REPORT.CHECKED_ASSIGNED IS '처리여부';
COMMENT ON COLUMN REPORT.ASSIGNED_ADMIN_ID IS '처리한 관리자';


-- 식별코드를 위한 시퀀스 생성
-- 공지사항 식별코드 시퀀스
CREATE SEQUENCE SEQ_NOTICE
NOCYCLE
NOCACHE;

-- 신고관리 식별코드 시퀀스
CREATE SEQUENCE SEQ_REPORT
NOCYCLE
NOCACHE;

-- QnA 식별코드 시퀀스
CREATE SEQUENCE SEQ_QNA
NOCYCLE
NOCACHE;

-- 경로추천게시판 식별코드 시퀀스
CREATE SEQUENCE SEQ_ROUTE_BOARD
NOCYCLE
NOCACHE;

-- 경로관리 식별코드 시퀀스
CREATE SEQUENCE SEQ_ROUTE
NOCYCLE
NOCACHE;

-- 장소관리 식별코드 시퀀스
CREATE SEQUENCE SEQ_PLACE
NOCYCLE
NOCACHE;

-- 채팅방 식별코드 시퀀스
CREATE SEQUENCE SEQ_CHATTING_ROOM
NOCYCLE
NOCACHE;

-- 채팅내역 식별코드 시퀀스
CREATE SEQUENCE SEQ_CHAT_MESSAGE
NOCYCLE
NOCACHE;

-- 가이드게시판 식별코드 시퀀스
CREATE SEQUENCE SEQ_GUIDE_BOARD
NOCYCLE
NOCACHE;

-- 댓글 식별코드 시퀀스
CREATE SEQUENCE SEQ_COMMENT
NOCYCLE
NOCACHE;

-- 관리자 아이디 생성
INSERT INTO MEMBER (MEM_ID, MEM_NAME, MEM_TYPE, MEM_PW, MEM_NICKNM, MEM_JOIN_DATE, MEM_STATUS)
VALUES ('ADMIN@synergysoft.co.kr', '관리자', 'ADMIN', '123456', 'ADMIN', SYSDATE, 'ACTIVE');
COMMIT;

-- 공지사항(notice) test data 추가
DELETE FROM NOTICE;
COMMIT;
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'1.공지사항입니다.','공지사항 내용1','admin','2024-03-20',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'2.공지사항입니다.','공지사항 내용2','admin','2024-03-21',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'3.공지사항입니다.','공지사항 내용3','admin','2024-03-22',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'4.공지사항입니다.','공지사항 내용4','admin','2024-03-23',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'5.공지사항입니다.','공지사항 내용5','admin','2024-03-24',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'6.공지사항입니다.','공지사항 내용6','admin','2024-03-25',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'7.공지사항입니다.','공지사항 내용7','admin','2024-03-26',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'8.공지사항입니다.','공지사항 내용8','admin','2024-03-27',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'9.공지사항입니다.','공지사항 내용9','admin','2024-03-28',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'10.공지사항입니다.','공지사항 내용10','admin','2024-03-29',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'11.공지사항입니다.','공지사항 내용11','admin','2024-03-30',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'12.공지사항입니다.','공지사항 내용12','admin','2024-03-31',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'13.공지사항입니다.','공지사항 내용13','admin','2024-04-01',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'14.공지사항입니다.','공지사항 내용14','admin','2024-04-02',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'15.공지사항입니다.','공지사항 내용15','admin','2024-04-03',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'16.공지사항입니다.','공지사항 내용16','admin','2024-04-04',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'17.공지사항입니다.','공지사항 내용17','admin','2024-04-05',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'18.공지사항입니다.','공지사항 내용18','admin','2024-04-06',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'19.공지사항입니다.','공지사항 내용19','admin','2024-04-07',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'20.공지사항입니다.','공지사항 내용20','admin','2024-04-08',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'21.공지사항입니다.','공지사항 내용21','admin','2024-04-09',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'22.공지사항입니다.','공지사항 내용22','admin','2024-04-10',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'23.공지사항입니다.','공지사항 내용23','admin','2024-04-11',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'24.공지사항입니다.','공지사항 내용24','admin','2024-04-12',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'25.공지사항입니다.','공지사항 내용25','admin','2024-04-13',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'26.공지사항입니다.','공지사항 내용26','admin','2024-04-14',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'27.공지사항입니다.','공지사항 내용27','admin','2024-04-15',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'28.공지사항입니다.','공지사항 내용28','admin','2024-04-16',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'29.공지사항입니다.','공지사항 내용29','admin','2024-04-17',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'30.공지사항입니다.','공지사항 내용30','admin','2024-04-18',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'31.공지사항입니다.','공지사항 내용31','admin','2024-04-19',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'32.공지사항입니다.','공지사항 내용32','admin','2024-04-20',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'33.공지사항입니다.','공지사항 내용33','admin','2024-04-21',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'34.공지사항입니다.','공지사항 내용34','admin','2024-04-22',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'35.공지사항입니다.','공지사항 내용35','admin','2024-04-23',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'36.공지사항입니다.','공지사항 내용36','admin','2024-04-24',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'37.공지사항입니다.','공지사항 내용37','admin','2024-04-25',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'38.공지사항입니다.','공지사항 내용38','admin','2024-04-26',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'39.공지사항입니다.','공지사항 내용39','admin','2024-04-27',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'40.공지사항입니다.','공지사항 내용40','admin','2024-04-28',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'41.공지사항입니다.','공지사항 내용41','admin','2024-04-29',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'42.공지사항입니다.','공지사항 내용42','admin','2024-04-30',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'43.공지사항입니다.','공지사항 내용43','admin','2024-05-01',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'44.공지사항입니다.','공지사항 내용44','admin','2024-05-02',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'45.공지사항입니다.','공지사항 내용45','admin','2024-05-03',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'46.공지사항입니다.','공지사항 내용46','admin','2024-05-04',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'47.공지사항입니다.','공지사항 내용47','admin','2024-05-05',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'48.공지사항입니다.','공지사항 내용48','admin','2024-05-06',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'49.공지사항입니다.','공지사항 내용49','admin','2024-05-07',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'50.공지사항입니다.','공지사항 내용50','admin','2024-05-08',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'51.공지사항입니다.','공지사항 내용51','admin','2024-05-09',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'52.공지사항입니다.','공지사항 내용52','admin','2024-05-10',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'53.공지사항입니다.','공지사항 내용53','admin','2024-05-11',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'54.공지사항입니다.','공지사항 내용54','admin','2024-05-12',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'55.공지사항입니다.','공지사항 내용55','admin','2024-05-13',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'56.공지사항입니다.','공지사항 내용56','admin','2024-05-14',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'57.공지사항입니다.','공지사항 내용57','admin','2024-05-15',null,'N',null,'N',null,null,null,null,null,null,0);
INSERT INTO NOTICE VALUES ('notice_'||SEQ_NOTICE.NEXTVAL,'58.공지사항입니다.','공지사항 내용58','admin','2024-05-16',null,'N',null,'N',null,null,null,null,null,null,0);

commit;

--가이드 더미데이터 추가
INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('001', '남산타워여행', '블로그에 들어가는 내용입니다. 확인해주세요1', '서울', TO_DATE('2022-11-22', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'user01', 1,'탐산타워.jpg',null,null,null,null, '20241008180429657_d1a6744b24644b68859fa7b2c87cb199.jpg' ,null,null,null,null);


INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('002', '성심당여행.', '블로그에 들어가는 내용입니다. 확인해주세요7', '대전', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '성심당.jpg',null,null,null,null, '20241011122607800_5bfcc3115e2244758491d25daf0e8167.jpg' ,null,null,null,null);



INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('003', '경주여행', '블로그에 들어가는 내용입니다. 확인해주세요7', '경주', TO_DATE('2022-10-14', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 6, '동궁과 월지.jpg',null,null,null,null, '20241008180429657_d1a6744b24644b68859fa7b2c87cb199.jpg' ,null,null,null,null);


INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('004', '가평여행.', '블로그에 들어가는 내용입니다. 확인해주세요7', '가평', TO_DATE('2022-10-15', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '쁘띠프랑스.jpg',null,null,null,null, '20241007180649075_65ba688ce2094fb09b0a6bbe1597c182.jpg' ,null,null,null,null);


INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('005', '강원도여행', '블로그에 들어가는 내용입니다. 확인해주세요7', '강원도', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 5, '서산 용유지1.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);


INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('006', '태안여행', '블로그에 들어가는 내용입니다. 확인해주세요7', '태안', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 3, '운여해안.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('007', '서울불꽃축제후기.', '블로그에 들어가는 내용입니다. 확인해주세요7', '서울', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '불꽃놀이.jpg',null,null,null,null, '20241007191530822_51767e3eef6b499ead05ac1605dc48c3.jpg' ,null,null,null,null);

INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('008', '비행기', '블로그에 들어가는 내용입니다. 확인해주세요7', '서울', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '불꽃놀이.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);
INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('009', '배고픈여행', '블로그에 들어가는 내용입니다. 확인해주세요7', '서울', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '불꽃놀이.jpg',null,null,null,null, '20241008180429657_8a6881bfd49c47378605ec13f3ae3eb2.jpg' ,null,null,null,null);
INSERT INTO guide_board (POST_ID, TITLE, CONTENT, LOCATION, CREATED_AT, UPDATED_AT, USER_ID, LIKE_COUNT, OFILE1,OFILE2,OFILE3,OFILE4,OFILE5,RFILE1,RFILE2,RFILE3,RFILE4,RFILE5)
VALUES ('010', '재밌는 여행.', '블로그에 들어가는 내용입니다. 확인해주세요7', '서울', TO_DATE('2022-10-13', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 'user01', 1, '불꽃놀이.jpg',null,null,null,null, '20241007191530822_51767e3eef6b499ead05ac1605dc48c3.jpg' ,null,null,null,null);


commit;



-- qna(qna) test data 추가
DELETE FROM QNA;
COMMIT;
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'1테스트 qna','1 내용 qna','user01','2024-03-20',null,'admin','Y','1 관리자내용','2024-03-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'2테스트 qna','2 내용 qna','user01','2024-03-21',null,'admin','Y','2 관리자내용','2024-03-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'3테스트 qna','3 내용 qna','user01','2024-03-22',null,'admin','Y','3 관리자내용','2024-03-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'4테스트 qna','4 내용 qna','user01','2024-03-23',null,'admin','Y','4 관리자내용','2024-03-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'5테스트 qna','5 내용 qna','user01','2024-03-24',null,'admin','Y','5 관리자내용','2024-03-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'6테스트 qna','6 내용 qna','user01','2024-03-25',null,'admin','Y','6 관리자내용','2024-03-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'7테스트 qna','7 내용 qna','user01','2024-03-26',null,'admin','Y','7 관리자내용','2024-03-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'8테스트 qna','8 내용 qna','user01','2024-03-27',null,'admin','Y','8 관리자내용','2024-03-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'9테스트 qna','9 내용 qna','user01','2024-03-28',null,'admin','Y','9 관리자내용','2024-03-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'10테스트 qna','10 내용 qna','user01','2024-03-29',null,'admin','Y','10 관리자내용','2024-03-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'11테스트 qna','11 내용 qna','user01','2024-03-30',null,'admin','Y','11 관리자내용','2024-03-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'12테스트 qna','12 내용 qna','user01','2024-03-31',null,'admin','Y','12 관리자내용','2024-03-31','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'13테스트 qna','13 내용 qna','user01','2024-04-01',null,'admin','Y','13 관리자내용','2024-04-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'14테스트 qna','14 내용 qna','user01','2024-04-02',null,'admin','Y','14 관리자내용','2024-04-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'15테스트 qna','15 내용 qna','user01','2024-04-03',null,'admin','Y','15 관리자내용','2024-04-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'16테스트 qna','16 내용 qna','user01','2024-04-04',null,'admin','Y','16 관리자내용','2024-04-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'17테스트 qna','17 내용 qna','user01','2024-04-05',null,'admin','Y','17 관리자내용','2024-04-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'18테스트 qna','18 내용 qna','user01','2024-04-06',null,'admin','Y','18 관리자내용','2024-04-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'19테스트 qna','19 내용 qna','user01','2024-04-07',null,'admin','Y','19 관리자내용','2024-04-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'20테스트 qna','20 내용 qna','user01','2024-04-08',null,'admin','Y','20 관리자내용','2024-04-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'21테스트 qna','21 내용 qna','user01','2024-04-09',null,'admin','Y','21 관리자내용','2024-04-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'22테스트 qna','22 내용 qna','user01','2024-04-10',null,'admin','Y','22 관리자내용','2024-04-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'23테스트 qna','23 내용 qna','user01','2024-04-11',null,'admin','Y','23 관리자내용','2024-04-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'24테스트 qna','24 내용 qna','user01','2024-04-12',null,'admin','Y','24 관리자내용','2024-04-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'25테스트 qna','25 내용 qna','user01','2024-04-13',null,'admin','Y','25 관리자내용','2024-04-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'26테스트 qna','26 내용 qna','user01','2024-04-14',null,'admin','Y','26 관리자내용','2024-04-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'27테스트 qna','27 내용 qna','user01','2024-04-15',null,'admin','Y','27 관리자내용','2024-04-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'28테스트 qna','28 내용 qna','user01','2024-04-16',null,'admin','Y','28 관리자내용','2024-04-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'29테스트 qna','29 내용 qna','user01','2024-04-17',null,'admin','Y','29 관리자내용','2024-04-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'30테스트 qna','30 내용 qna','user01','2024-04-18',null,'admin','Y','30 관리자내용','2024-04-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'31테스트 qna','31 내용 qna','user01','2024-04-19',null,'admin','Y','31 관리자내용','2024-04-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'32테스트 qna','32 내용 qna','user01','2024-04-20',null,'admin','Y','32 관리자내용','2024-04-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'33테스트 qna','33 내용 qna','user01','2024-04-21',null,'admin','Y','33 관리자내용','2024-04-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'34테스트 qna','34 내용 qna','user01','2024-04-22',null,'admin','Y','34 관리자내용','2024-04-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'35테스트 qna','35 내용 qna','user01','2024-04-23',null,'admin','Y','35 관리자내용','2024-04-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'36테스트 qna','36 내용 qna','user01','2024-04-24',null,'admin','Y','36 관리자내용','2024-04-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'37테스트 qna','37 내용 qna','user01','2024-04-25',null,'admin','Y','37 관리자내용','2024-04-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'38테스트 qna','38 내용 qna','user01','2024-04-26',null,'admin','Y','38 관리자내용','2024-04-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'39테스트 qna','39 내용 qna','user01','2024-04-27',null,'admin','Y','39 관리자내용','2024-04-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'40테스트 qna','40 내용 qna','user01','2024-04-28',null,'admin','Y','40 관리자내용','2024-04-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'41테스트 qna','41 내용 qna','user01','2024-04-29',null,'admin','Y','41 관리자내용','2024-04-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'42테스트 qna','42 내용 qna','user01','2024-04-30',null,'admin','Y','42 관리자내용','2024-04-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'43테스트 qna','43 내용 qna','user01','2024-05-01',null,'admin','Y','43 관리자내용','2024-05-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'44테스트 qna','44 내용 qna','user01','2024-05-02',null,'admin','Y','44 관리자내용','2024-05-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'45테스트 qna','45 내용 qna','user01','2024-05-03',null,'admin','Y','45 관리자내용','2024-05-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'46테스트 qna','46 내용 qna','user01','2024-05-04',null,'admin','Y','46 관리자내용','2024-05-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'47테스트 qna','47 내용 qna','user01','2024-05-05',null,'admin','Y','47 관리자내용','2024-05-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'48테스트 qna','48 내용 qna','user01','2024-05-06',null,'admin','Y','48 관리자내용','2024-05-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'49테스트 qna','49 내용 qna','user01','2024-05-07',null,'admin','Y','49 관리자내용','2024-05-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'50테스트 qna','50 내용 qna','user01','2024-05-08',null,'admin','Y','50 관리자내용','2024-05-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'51테스트 qna','51 내용 qna','user01','2024-05-09',null,'admin','Y','51 관리자내용','2024-05-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'52테스트 qna','52 내용 qna','user01','2024-05-10',null,'admin','Y','52 관리자내용','2024-05-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'53테스트 qna','53 내용 qna','user01','2024-05-11',null,'admin','Y','53 관리자내용','2024-05-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'54테스트 qna','54 내용 qna','user01','2024-05-12',null,'admin','Y','54 관리자내용','2024-05-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'55테스트 qna','55 내용 qna','user01','2024-05-13',null,'admin','Y','55 관리자내용','2024-05-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'56테스트 qna','56 내용 qna','user01','2024-05-14',null,'admin','Y','56 관리자내용','2024-05-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'57테스트 qna','57 내용 qna','user01','2024-05-15',null,'admin','Y','57 관리자내용','2024-05-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'58테스트 qna','58 내용 qna','user01','2024-05-16',null,'admin','Y','58 관리자내용','2024-05-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'59테스트 qna','59 내용 qna','user01','2024-05-17',null,'admin','Y','59 관리자내용','2024-05-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'60테스트 qna','60 내용 qna','user01','2024-05-18',null,'admin','Y','60 관리자내용','2024-05-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'61테스트 qna','61 내용 qna','user01','2024-05-19',null,'admin','Y','61 관리자내용','2024-05-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'62테스트 qna','62 내용 qna','user01','2024-05-20',null,'admin','Y','62 관리자내용','2024-05-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'63테스트 qna','63 내용 qna','user01','2024-05-21',null,'admin','Y','63 관리자내용','2024-05-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'64테스트 qna','64 내용 qna','user01','2024-05-22',null,'admin','Y','64 관리자내용','2024-05-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'65테스트 qna','65 내용 qna','user01','2024-05-23',null,'admin','Y','65 관리자내용','2024-05-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'66테스트 qna','66 내용 qna','user01','2024-05-24',null,'admin','Y','66 관리자내용','2024-05-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'67테스트 qna','67 내용 qna','user01','2024-05-25',null,'admin','Y','67 관리자내용','2024-05-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'68테스트 qna','68 내용 qna','user01','2024-05-26',null,'admin','Y','68 관리자내용','2024-05-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'69테스트 qna','69 내용 qna','user01','2024-05-27',null,'admin','Y','69 관리자내용','2024-05-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'70테스트 qna','70 내용 qna','user01','2024-05-28',null,'admin','Y','70 관리자내용','2024-05-28','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'71테스트 qna','71 내용 qna','user01','2024-05-29',null,'admin','Y','71 관리자내용','2024-05-29','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'72테스트 qna','72 내용 qna','user01','2024-05-30',null,'admin','Y','72 관리자내용','2024-05-30','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'73테스트 qna','73 내용 qna','user01','2024-05-31',null,'admin','Y','73 관리자내용','2024-05-31','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'74테스트 qna','74 내용 qna','user01','2024-06-01',null,'admin','Y','74 관리자내용','2024-06-01','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'75테스트 qna','75 내용 qna','user01','2024-06-02',null,'admin','Y','75 관리자내용','2024-06-02','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'76테스트 qna','76 내용 qna','user01','2024-06-03',null,'admin','Y','76 관리자내용','2024-06-03','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'77테스트 qna','77 내용 qna','user01','2024-06-04',null,'admin','Y','77 관리자내용','2024-06-04','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'78테스트 qna','78 내용 qna','user01','2024-06-05',null,'admin','Y','78 관리자내용','2024-06-05','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'79테스트 qna','79 내용 qna','user01','2024-06-06',null,'admin','Y','79 관리자내용','2024-06-06','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'80테스트 qna','80 내용 qna','user01','2024-06-07',null,'admin','Y','80 관리자내용','2024-06-07','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'81테스트 qna','81 내용 qna','user01','2024-06-08',null,'admin','Y','81 관리자내용','2024-06-08','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'82테스트 qna','82 내용 qna','user01','2024-06-09',null,'admin','Y','82 관리자내용','2024-06-09','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'83테스트 qna','83 내용 qna','user01','2024-06-10',null,'admin','Y','83 관리자내용','2024-06-10','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'84테스트 qna','84 내용 qna','user01','2024-06-11',null,'admin','Y','84 관리자내용','2024-06-11','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'85테스트 qna','85 내용 qna','user01','2024-06-12',null,'admin','Y','85 관리자내용','2024-06-12','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'86테스트 qna','86 내용 qna','user01','2024-06-13',null,'admin','Y','86 관리자내용','2024-06-13','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'87테스트 qna','87 내용 qna','user01','2024-06-14',null,'admin','Y','87 관리자내용','2024-06-14','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'88테스트 qna','88 내용 qna','user01','2024-06-15',null,'admin','Y','88 관리자내용','2024-06-15','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'89테스트 qna','89 내용 qna','user01','2024-06-16',null,'admin','Y','89 관리자내용','2024-06-16','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'90테스트 qna','90 내용 qna','user01','2024-06-17',null,'admin','Y','90 관리자내용','2024-06-17','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'91테스트 qna','91 내용 qna','user01','2024-06-18',null,'admin','Y','91 관리자내용','2024-06-18','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'92테스트 qna','92 내용 qna','user01','2024-06-19',null,'admin','Y','92 관리자내용','2024-06-19','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'93테스트 qna','93 내용 qna','user01','2024-06-20',null,'admin','Y','93 관리자내용','2024-06-20','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'94테스트 qna','94 내용 qna','user01','2024-06-21',null,'admin','Y','94 관리자내용','2024-06-21','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'95테스트 qna','95 내용 qna','user01','2024-06-22',null,'admin','Y','95 관리자내용','2024-06-22','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'96테스트 qna','96 내용 qna','user01','2024-06-23',null,'admin','Y','96 관리자내용','2024-06-23','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'97테스트 qna','97 내용 qna','user01','2024-06-24',null,'admin','Y','97 관리자내용','2024-06-24','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'98테스트 qna','98 내용 qna','user01','2024-06-25',null,'admin','Y','98 관리자내용','2024-06-25','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'99테스트 qna','99 내용 qna','user01','2024-06-26',null,'admin','Y','99 관리자내용','2024-06-26','N',null,'N',null,null,null,null,null,null,null,null,null,null);
INSERT INTO QNA VALUES ('qna_'||SEQ_QNA.NEXTVAL,'100테스트 qna','100 내용 qna','user01','2024-06-27',null,'admin','Y','100 관리자내용','2024-06-27','N',null,'N',null,null,null,null,null,null,null,null,null,null);

commit;

-- report 더미데이터
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_9','guide_3','user01','test1','test용1',TIMESTAMP'2024-10-03 00:00:45','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_10','guide_4','user01','비속어사용, 혐오발언','비속어 사용.',TIMESTAMP'2024-10-03 00:00:50','Y','admin','N','admin');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_1','guide_6','user01','test2','test용2',TIMESTAMP'2024-10-03 00:00:05','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_11','guide_6','user01','test3','test용3',TIMESTAMP'2024-10-03 00:00:55','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_12','P001','user01','test5','test용5',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_13','P001','user01','test4','test용4',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_14','P001','user01','test6','test용4',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_15','P001','user01','비속어 사용','꼴등이라는 이유로 비속어 사용',TIMESTAMP'2024-10-03 00:01:00','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_2','guide_3','user01','test7','test용7',TIMESTAMP'2024-10-03 00:00:10','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_3','guide_4','user01','비속어','비속어 사용',TIMESTAMP'2024-10-03 00:00:15','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_4','guide_3','user01','비속어','비속어 사용 2',TIMESTAMP'2024-10-03 00:00:20','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_5','guide_4','user01','c','영어2',TIMESTAMP'2024-10-03 00:00:25','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_6','guide_5','user01','d','영어1',TIMESTAMP'2024-10-03 00:00:30','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_7','guide_6','user01','e','영어3',TIMESTAMP'2024-10-03 00:00:35','N','ADMIN NOT CHECKED','N','ADMIN NOT ASSIGNED');
INSERT INTO REPORT (REPORT_ID,POST_ID,REPORT_USER_ID,REPORTING_REASON,DETAIL,REPORT_DATE,CHECKED_ADMIN,CHECKED_ADMIN_ID,CHECKED_ASSIGNED,ASSIGNED_ADMIN_ID) VALUES ('report_8','guide_5','user01','f','영어4',TIMESTAMP'2024-10-03 00:00:40','Y','admin','N','admin');
commit;