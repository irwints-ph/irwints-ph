/* MS SQL version 1.1 */
--------------------------------------------------------
--  DDL for Table APPS_USER_REF
--------------------------------------------------------
  CREATE TABLE APPS_USER_REF
   (	
      UUID          Numeric(10,0) IDENTITY(100,1) NOT NULL
     ,FULLNAME      VARCHAR(200)
     ,DEFMOD        Numeric DEFAULT 0 NOT NULL 
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric(10,0) DEFAULT 0
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric(10,0)
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_REF_USERS_PK00 PRIMARY KEY (UUID)
   );

CREATE TABLE APPS_USER_MAPPER(
      UUID          Numeric(10,0) NOT NULL
     ,USERNAME      VARCHAR(50) NOT NULL
     ,PASSWORD      NVARCHAR(100) NOT NULL
     ,SALTKEY       NVARCHAR(50) NOT NULL
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric(10,0) DEFAULT 0
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric(10,0)
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_USER_MAPPER PRIMARY KEY (UUID)
     ,CONSTRAINT FK_APPS_USER_MAPPER FOREIGN KEY (UUID)       REFERENCES APPS_USER_REF (UUID)
); 
CREATE TABLE APPS_PERSONNEL_MSTR(
      UUID          Numeric(10,0) not null
     ,EMAIL         VARCHAR(50)
     ,LASTNAME      VARCHAR(50)
     ,FIRSTNAME     VARCHAR(50)
     ,CONTACTNO     VARCHAR(50)
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric(10,0) DEFAULT 0
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric(10,0)
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_PERSONNEL_MSTR PRIMARY KEY (UUID)
     ,CONSTRAINT FK_APPS_PERSONNEL_MSTR FOREIGN KEY (UUID)       REFERENCES APPS_USER_REF (UUID)
);
GO
--------------------------------------------------------
--  DDL for Table APPS_ROLE_REF
--------------------------------------------------------
  CREATE TABLE APPS_ROLE_REF
   (	ROLE_ID          Numeric(10,0) IDENTITY(100,1) not null
	   ,ROLE_NAME        VARCHAR(50)
	   ,ROLE_DESCRIPTION VARCHAR(100)
	   ,PARENT_ID        Numeric(10,0)
	   ,IS_ACTIVE        CHAR(1) DEFAULT 'Y'
	   ,IS_ADMIN         CHAR(1) DEFAULT 'N'
     ,CREATED_BY       Numeric(10,0) DEFAULT 0
	   ,CREATED_DATE     DATE DEFAULT GetDate()
	   ,LAST_UPD_BY      Numeric(10,0)
	   ,LAST_UPD_DATE    DATE
     ,constraint PK_APPS_REF_ROLE00 PRIMARY KEY (ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_ROLE01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

--------------------------------------------------------
--  DDL for Table APPS_USER_ROLE_REF
--------------------------------------------------------
  CREATE TABLE APPS_USER_ROLE_REF 
   (	UUID          Numeric(10,0) NOT NULL
     ,ROLE_ID       Numeric(10,0) NOT NULL
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric(10,0) DEFAULT 0
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric(10,0)
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_REF_USER_ROLE00 PRIMARY KEY (UUID,ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_USER_ROLE01 FOREIGN KEY (UUID)       REFERENCES APPS_USER_REF (UUID)
     ,CONSTRAINT FK_APPS_REF_USER_ROLE02 FOREIGN KEY (ROLE_ID)    REFERENCES APPS_ROLE_REF (ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_USER_ROLE03 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

/*--------------------------------------------------------
--  ddl for table apps_top_menu
--------------------------------------------------------*/
  create table apps_top_menu
   (	m_prnt_id     int auto_increment not null
	   ,menu_name     varchar(50)
     ,icode_name    varchar(100) default ''
	   ,is_active     char(1)     default 'Y'
     ,is_admin      char(1)     default 'N'
     ,created_by    int         default 0
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int default null
     ,last_upd_date timestamp default current_timestamp
     ,constraint pk_apps_top_menu00 primary key (m_prnt_id)
   );

--------------------------------------------------------
--  DDL for Table APPS_MODULE_REF
--------------------------------------------------------
  CREATE TABLE APPS_MODULE_REF
   (	MODULE_ID     Numeric(10,0) IDENTITY(100,1) NOT NULL
	   ,MODULE_NAME   VARCHAR(50)
     ,m_prnt_id     Numeric(10,0)            /* 2025 for categorized menu*/
     ,tran_code     varchar(100) default ''  /* 2025 for short cut code */

	   ,PARENT_ID     Numeric(10,0)
	   ,MENU_LEVEL    Numeric(1,0) NOT NULL
	   ,SORT_ORDER    Numeric(3,0) 
	   ,form_name     varchar(50)
	   ,PAGE_NAME     VARCHAR(50)
	   ,FOLDER_PATH   VARCHAR(50) 
	   ,TYPE          VARCHAR(05)
     ,IS_PARENT     CHAR(1)     DEFAULT 'N'
	   ,CODE          VARCHAR(10) 
	   ,IS_ACTIVE     CHAR(1)     DEFAULT 'Y'
     ,IS_ADMIN      CHAR(1)     DEFAULT 'N'
	   ,CREATED_BY    Numeric(10,0)  DEFAULT 0
	   ,CREATED_DATE  DATE DEFAULT GetDate()
	   ,LAST_UPD_BY   Numeric(10,0)
	   ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_REF_MODULE00 PRIMARY KEY (MODULE_ID)
     ,CONSTRAINT FK_APPS_REF_MODULE01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
     ,constraint fk_apps_top_menu01   foreign key (m_prnt_id)  references apps_top_menu (m_prnt_id)
   );


--------------------------------------------------------
--  DDL for Table APPS_ROLE_MODULE_REF
--------------------------------------------------------
  CREATE TABLE APPS_ROLE_MODULE_REF
   (	ROLE_ID       Numeric(10,0) NOT NULL
	   ,MODULE_ID     Numeric(10,0) NOT NULL
	   ,AUTOHRZTN     CHAR(5) DEFAULT 'YYYYY'
	   ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
	   ,CREATED_BY    Numeric(10,0) DEFAULT 0
	   ,CREATED_DATE  DATE DEFAULT GetDate()
	   ,LAST_UPD_BY   Numeric(10,0)
	   ,LAST_UPD_DATE DATE
     ,constraint PK_APPS_REF_ROLE_MODULE00 PRIMARY KEY (ROLE_ID,MODULE_ID)
     ,CONSTRAINT FK_APPS_REF_ROLE_MODULE01 FOREIGN KEY (ROLE_ID) REFERENCES APPS_ROLE_REF (ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_ROLE_MODULE02 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
     ,CONSTRAINT FK_APPS_REF_ROLE_MODULE03 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

--------------------------------------------------------
--  Table APPS_AUDIT_HDR_REF
--------------------------------------------------------
  CREATE TABLE APPS_AUDIT_HDR_REF
   (	
      AUDIT_ID      Numeric(10,0) IDENTITY(1,1) NOT NULL
     ,ActionType    Char(01)  NOT NULL CHECK (ActionType IN ('I','U','D'))                  -- I for Insert, U for Update, D for Delete
     ,USER_NAME     varChar(50)
     ,COMP_NAME     varChar(50)
     ,MODULE_ID     Numeric(10,0)
     ,TableName     varChar(50)
     ,table_key     varChar(30)
     ,ActionRmrk    varChar(100)
	   ,CREATED_BY	  Numeric(10,0)
	   ,CREATED_DATE  DATE DEFAULT GetDate()
     ,constraint PK_APPS_AUDIT_HDR_REF01 primary key (AUDIT_ID)
     ,CONSTRAINT FK_APPS_AUDIT_HDR_REF01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

--------------------------------------------------------
--  Table APPS_AUDIT_DTL_REF
--------------------------------------------------------
  CREATE TABLE APPS_AUDIT_DTL_REF
   (	
      AUDIT_ID    Numeric(10,0) NOT NULL
     ,LINENUBR    Numeric(10,0)  
     ,FIELDNAM    varChar(50)
     ,OLDVALUE    varChar(150)
     ,NEWVALUE    varChar(150)
     ,constraint PK_APPS_AUDIT_DTL_REF01 primary key (AUDIT_ID,LINENUBR,FIELDNAM)
     ,CONSTRAINT FK_APPS_AUDIT_DTL_REF01 FOREIGN KEY (AUDIT_ID) REFERENCES APPS_AUDIT_HDR_REF (AUDIT_ID)
   );

--------------------------------------------------------
--  Table APPS_USER_SESSION
--------------------------------------------------------
-- DROP Table APPS_USER_SESSION
  CREATE TABLE APPS_USER_SESSION
   (	
      SESSONID   varChar(100) not null
     ,USERNAME   varChar(100) not null
     ,logindate  date default GetDate() not null
     ,logintime  char(6) not null 
     ,CMPRNAME   varChar(100)
     ,UUID       Numeric(10,0)
     ,SRVRNAME   VARCHAR(100)
	   ,IS_ACTIVE  CHAR(1) DEFAULT 'Y'
     ,deactdate  date
     ,deacttime  char(6)
     ,constraint PK_APPS_USER_SESSION primary key (SESSONID,USERNAME,logindate,logintime)
   );

--------------------------------------------------------
--  Table APPS_USER_MODULE_LOGS
--------------------------------------------------------
  CREATE TABLE APPS_USER_MODULE_LOGS
   (	
       MODULE_ID  Numeric(10,0)    NOT NULL
      ,UUID	      Numeric(10,0)    NOT NULL
      ,LOG_DATE	  DATE	           NOT NULL	DEFAULT GetDate()
      ,TIME	      CHAR(6)	       NOT NULL	--((replace(str(datepart(hour,getdate()),(2)),' ','0')+replace(str(datepart(minute,getdate()),(2)),' ','0'))+replace(str(datepart(second,getdate()),(2)),' ','0'))
      ,USERNAME	  VARCHAR(100)	   NOT NULL
      ,CMPRNAME	  VARCHAR(100)
      ,SRVRNAME	  VARCHAR(100)
     ,CONSTRAINT FK_APPS_USER_ML01 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
     ,CONSTRAINT FK_APPS_USER_ML02 FOREIGN KEY (UUID)      REFERENCES APPS_USER_REF (UUID)
   );
ALTER TABLE [dbo].[APPS_USER_MODULE_LOGS] ADD  DEFAULT ((replace(str(datepart(hour,getdate()),(2)),' ','0')+replace(str(datepart(minute,getdate()),(2)),' ','0'))+replace(str(datepart(second,getdate()),(2)),' ','0')) FOR [TIME]
GO

--------------------------------------------------------
--  DDL for Table APPS_MODULE_FLDS_REF
--------------------------------------------------------
  CREATE TABLE APPS_MODULE_FLDS_REF 
   (	
        MODULE_ID    Numeric(10,0) NOT NULL
       ,FIELD_NAME   VARCHAR(50) NOT NULL
       ,IS_ACTIVE    CHAR(1) DEFAULT 'Y'
       ,CREATED_BY   Numeric(10,0) DEFAULT 0
       ,CREATED_DATE DATE DEFAULT GetDate()
       ,LAST_UPD_BY  Numeric(10,0)
       ,LAST_UPD_DATE DATE
       ,CONSTRAINT PK_APPS_MODULE_FLDS_REF_REF00 PRIMARY KEY (MODULE_ID, FIELD_NAME)
       ,CONSTRAINT FK_APPS_MODULE_FLDS_REF00 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
       ,CONSTRAINT FK_APPS_MODULE_FLDS_REF01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   ) ;
	  
--------------------------------------------------------
--  DDL for Table APPS_MODULE_AUTH_REF
--------------------------------------------------------

  CREATE TABLE APPS_MODULE_AUTH_REF 
   (	
        MODULE_ID     Numeric(10,0) NOT NULL
       ,AUTH_NAME     VARCHAR(50) NOT NULL 
       ,OBJTYPE       CHAR(2) NOT NULL 
       ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
       ,CREATED_BY    Numeric(10,0) DEFAULT 0
       ,CREATED_DATE  DATE DEFAULT GetDate()
       ,LAST_UPD_BY   Numeric(10,0)
       ,LAST_UPD_DATE DATE
       ,CONSTRAINT PK_APPS_MODULE_AUTH_REF_00 PRIMARY KEY (MODULE_ID, AUTH_NAME)
       ,CONSTRAINT FK_APPS_MODULE_AUTH_REF_00 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
       ,CONSTRAINT FK_APPS_MODULE_AUTH_REF_01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   ) 
;

--------------------------------------------------------
--  DDL for Table APPS_ROLE_MODULE_FLDS_REF
--------------------------------------------------------

  CREATE TABLE APPS_ROLE_MODULE_FLDS_REF 
   (	
        ROLE_ID       Numeric(10,0) NOT NULL
       ,MODULE_ID     Numeric(10,0) NOT NULL
       ,FIELD_NAME    VARCHAR(50) NOT NULL
       ,VALUE         CHAR(2) NOT NULL
       ,CREATED_BY    Numeric(10,0) DEFAULT 0
       ,CREATED_DATE  DATE DEFAULT GetDate()
       ,LAST_UPD_BY	  Numeric(10,0)
       ,LAST_UPD_DATE DATE
       ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
       ,CONSTRAINT PK_APPS_ROLE_MODULE_FLDS00 PRIMARY KEY (ROLE_ID, MODULE_ID, FIELD_NAME)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_FLDS00 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_FLDS01 FOREIGN KEY (ROLE_ID) REFERENCES APPS_ROLE_REF (ROLE_ID)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_FLDS02 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   )   ;

--------------------------------------------------------
--  DDL for Table APPS_ROLE_MODULE_AUTH_REF
--------------------------------------------------------
--  DROP TABLE APPS_ROLE_MODULE_AUTH_REF 
  CREATE TABLE APPS_ROLE_MODULE_AUTH_REF 
   (	
        ROLE_ID       Numeric(10,0) NOT NULL
       ,MODULE_ID     Numeric(10,0) NOT NULL
       ,AUTH_NAME     VARCHAR(50) NOT NULL
       ,VALUE         VARCHAR(20) NOT NULL
       ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
       ,CREATED_BY    Numeric(10,0) DEFAULT 0
       ,CREATED_DATE  DATE DEFAULT GetDate()
       ,LAST_UPD_BY   Numeric(10,0)
       ,LAST_UPD_DATE DATE
--       ,CONSTRAINT PK_APPS_ROLE_MODULE_AUTH_REF00 PRIMARY KEY (ROLE_ID,MODULE_ID, AUTH_NAME)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_AUTH_REF00 FOREIGN KEY (ROLE_ID) REFERENCES APPS_ROLE_REF (ROLE_ID)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_AUTH_REF01 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_AUTH_REF02 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   ) 
  ;

GO