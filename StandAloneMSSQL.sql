create database SportMulti;
use SportMulti;
--------------------------------------------------------
--  DDL for Table APPS_USER_REF
--------------------------------------------------------
  CREATE TABLE APPS_USER_REF
   (	
      UUID          Numeric IDENTITY(100,1) NOT NULL
     ,FULLNAME      VARCHAR(200)
     ,DEFMOD        Numeric DEFAULT 0 NOT NULL 
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric DEFAULT NULL
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_REF_USERS_PK00 PRIMARY KEY (UUID)
   );

CREATE TABLE APPS_USER_MAPPER(
      UUID          Numeric NOT NULL
     ,USERNAME      VARCHAR(50) NOT NULL
     ,PASSWORD      NVARCHAR(100) NOT NULL
     ,SALTKEY       NVARCHAR(50) NOT NULL
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric DEFAULT NULL
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_USER_MAPPER PRIMARY KEY (UUID)
     ,CONSTRAINT FK_APPS_USER_MAPPER FOREIGN KEY (UUID)       REFERENCES APPS_USER_REF (UUID)
); 
CREATE TABLE APPS_PERSONNEL_MSTR(
      UUID          Numeric not null
     ,EMAIL         VARCHAR(50)
     ,LASTNAME      VARCHAR(50)
     ,FIRSTNAME     VARCHAR(50)
     ,CONTACTNO     VARCHAR(50)
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric DEFAULT NULL
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_PERSONNEL_MSTR PRIMARY KEY (UUID)
     ,CONSTRAINT FK_APPS_PERSONNEL_MSTR FOREIGN KEY (UUID)       REFERENCES APPS_USER_REF (UUID)
);

--------------------------------------------------------
--  DDL for Table APPS_ROLE_REF
--------------------------------------------------------
  CREATE TABLE APPS_ROLE_REF
   (	ROLE_ID          Numeric IDENTITY(100,1) not null
	   ,ROLE_NAME        VARCHAR(50)
	   ,ROLE_DESCRIPTION VARCHAR(100)
	   ,PARENT_ID        Numeric
	   ,IS_ACTIVE        CHAR(1) DEFAULT 'Y'
	   ,IS_ADMIN         CHAR(1) DEFAULT 'N'
	   ,CREATED_BY       Numeric
	   ,CREATED_DATE     DATE DEFAULT GetDate()
	   ,LAST_UPD_BY      Numeric
	   ,LAST_UPD_DATE    DATE
     ,constraint PK_APPS_REF_ROLE00 PRIMARY KEY (ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_ROLE01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

--------------------------------------------------------
--  DDL for Table APPS_USER_ROLE_REF
--------------------------------------------------------
  CREATE TABLE APPS_USER_ROLE_REF 
   (	UUID          Numeric NOT NULL
     ,ROLE_ID       Numeric NOT NULL
     ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
     ,CREATED_BY    Numeric 
     ,CREATED_DATE  DATE DEFAULT GetDate()
     ,LAST_UPD_BY   Numeric
     ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_REF_USER_ROLE00 PRIMARY KEY (UUID,ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_USER_ROLE01 FOREIGN KEY (UUID)       REFERENCES APPS_USER_REF (UUID)
     ,CONSTRAINT FK_APPS_REF_USER_ROLE02 FOREIGN KEY (ROLE_ID)    REFERENCES APPS_ROLE_REF (ROLE_ID)
     ,CONSTRAINT FK_APPS_REF_USER_ROLE03 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

--------------------------------------------------------
--  DDL for Table APPS_MODULE_REF
--------------------------------------------------------
  CREATE TABLE APPS_MODULE_REF
   (	MODULE_ID     Numeric IDENTITY(100,1) NOT NULL
	   ,MODULE_NAME   VARCHAR(50)
	   ,PARENT_ID     Numeric(10,0)
	   ,MENU_LEVEL    Numeric(1,0) NOT NULL
	   ,SORT_ORDER    Numeric(3,0) 
	   ,PAGE_NAME     VARCHAR(50)
	   ,FOLDER_PATH   VARCHAR(50) 
	   ,TYPE          VARCHAR(5 )
	   ,CODE          VARCHAR(10) 
	   ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
       ,IS_ADMIN      CHAR(1) DEFAULT 'N'
	   ,CREATED_BY    Numeric
	   ,CREATED_DATE  DATE DEFAULT GetDate()
	   ,LAST_UPD_BY   Numeric
	   ,LAST_UPD_DATE DATE 
     ,constraint PK_APPS_REF_MODULE00 PRIMARY KEY (MODULE_ID)
     ,CONSTRAINT FK_APPS_REF_MODULE01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );


--------------------------------------------------------
--  DDL for Table APPS_ROLE_MODULE_REF
--------------------------------------------------------
  CREATE TABLE APPS_ROLE_MODULE_REF
   (	ROLE_ID       Numeric NOT NULL
	   ,MODULE_ID     Numeric NOT NULL
	   ,AUTOHRZTN     CHAR(5) DEFAULT 'YYYYY'
	   ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
	   ,CREATED_BY    Numeric
	   ,CREATED_DATE  DATE DEFAULT GetDate()
	   ,LAST_UPD_BY   Numeric
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
      AUDIT_ID      Numeric IDENTITY(1,1) NOT NULL
     ,ActionType    Char(01)  NOT NULL CHECK (ActionType IN ('I','U','D'))                  -- I for Insert, U for Update, D for Delete
     ,USER_NAME     varChar(50)
     ,COMP_NAME     varChar(50)
     ,MODULE_ID     Numeric
     ,TableName     varChar(50)
     ,table_key     varChar(30)
     ,ActionRmrk    varChar(100)
	 ,CREATED_BY	Numeric
	 ,CREATED_DATE  DATE DEFAULT GetDate()
     ,constraint PK_APPS_AUDIT_HDR_REF01 primary key (AUDIT_ID)
     ,CONSTRAINT FK_APPS_AUDIT_HDR_REF01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   );

--------------------------------------------------------
--  Table APPS_AUDIT_DTL_REF
--------------------------------------------------------
  CREATE TABLE APPS_AUDIT_DTL_REF
   (	
      AUDIT_ID    Numeric NOT NULL
     ,LINENUBR    Numeric  
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
     ,UUID       Numeric
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
       MODULE_ID  Numeric	       NOT NULL
      ,UUID	      Numeric	       NOT NULL
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
        MODULE_ID    Numeric NOT NULL
       ,FIELD_NAME   VARCHAR(50) NOT NULL
       ,IS_ACTIVE    CHAR(1) DEFAULT 'Y'
       ,CREATED_BY   Numeric
       ,CREATED_DATE DATE DEFAULT GetDate()
       ,LAST_UPD_BY  Numeric
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
        MODULE_ID     Numeric NOT NULL
       ,AUTH_NAME     VARCHAR(50) NOT NULL 
       ,OBJTYPE       CHAR(2) NOT NULL 
       ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
       ,CREATED_BY    Numeric
       ,CREATED_DATE  DATE DEFAULT GetDate()
       ,LAST_UPD_BY   Numeric
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
        ROLE_ID       Numeric NOT NULL
       ,MODULE_ID     Numeric NOT NULL
       ,FIELD_NAME    VARCHAR(50) NOT NULL
       ,VALUE         CHAR(2) NOT NULL
       ,CREATED_BY    Numeric
       ,CREATED_DATE  DATE DEFAULT GetDate()
       ,LAST_UPD_BY	  Numeric
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
        ROLE_ID       Numeric NOT NULL
       ,MODULE_ID     Numeric NOT NULL
       ,AUTH_NAME     VARCHAR(50) NOT NULL
       ,VALUE         VARCHAR(20) NOT NULL
       ,IS_ACTIVE     CHAR(1) DEFAULT 'Y'
       ,CREATED_BY    Numeric
       ,CREATED_DATE  DATE DEFAULT GetDate()
       ,LAST_UPD_BY   Numeric
       ,LAST_UPD_DATE DATE
--       ,CONSTRAINT PK_APPS_ROLE_MODULE_AUTH_REF00 PRIMARY KEY (ROLE_ID,MODULE_ID, AUTH_NAME)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_AUTH_REF00 FOREIGN KEY (ROLE_ID) REFERENCES APPS_ROLE_REF (ROLE_ID)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_AUTH_REF01 FOREIGN KEY (MODULE_ID) REFERENCES APPS_MODULE_REF (MODULE_ID)
       ,CONSTRAINT FK_APPS_ROLE_MODULE_AUTH_REF02 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
   ) 
  ;

--commit;


--Initial Data For Standard Menu/Modules
--SET IDENTITY_INSERT APPS_USER_REF ON;
SET IDENTITY_INSERT APPS_USER_REF ON;
INSERT INTO APPS_USER_REF (UUID,FULLNAME,CREATED_BY) VALUES(0,'Root',0);
SET IDENTITY_INSERT APPS_USER_REF OFF;
--Password = !qazxsw2
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(0,'Root','104112171116126212151361401901922015912971432425514510','',0);

INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(0,'admin@thissite.com','Super','Root',0);

--SET IDENTITY_INSERT APPS_USER_REF OFF;


SET IDENTITY_INSERT APPS_ROLE_REF ON;
INSERT INTO APPS_ROLE_REF (
                            ROLE_ID
                           ,ROLE_NAME
                           ,ROLE_DESCRIPTION
                           ,IS_ACTIVE
                           ,IS_ADMIN
                           ,CREATED_BY
                          ) 
        VALUES(0,'APPS_ALL','Application Root Administrator','Y','Y',0);
INSERT INTO APPS_ROLE_REF (
                            ROLE_ID
                           ,ROLE_NAME
                           ,ROLE_DESCRIPTION
                           ,IS_ACTIVE
                           ,IS_ADMIN
                           ,CREATED_BY
                          ) 
        VALUES(1,'Admin','Admin','Y','Y',0);
INSERT INTO APPS_USER_ROLE_REF (
                                  UUID
                                 ,ROLE_ID
                                 ,IS_ACTIVE
                                 ,CREATED_BY
                                ) 
        VALUES(0,0,'Y',0);
SET IDENTITY_INSERT APPS_ROLE_REF OFF;


SET IDENTITY_INSERT APPS_MODULE_REF ON;
INSERT INTO APPS_MODULE_REF
  (	    
    MODULE_ID
   ,MODULE_NAME
	 ,PARENT_ID
	 ,MENU_LEVEL
	 ,SORT_ORDER
	 ,PAGE_NAME
	 ,FOLDER_PATH
   ,TYPE
	 ,CODE
	 ,IS_ACTIVE
   ,IS_ADMIN
	 ,CREATED_BY
  )
values
  (
    1,'Tools',null,1,100,null,null,null,null,'Y','Y',0
  );


INSERT INTO APPS_MODULE_REF
  (	    
    MODULE_ID
   ,MODULE_NAME
	 ,PARENT_ID
	 ,MENU_LEVEL
	 ,SORT_ORDER
	 ,PAGE_NAME
	 ,FOLDER_PATH
   ,TYPE
	 ,CODE
	 ,IS_ACTIVE
   ,IS_ADMIN
	 ,CREATED_BY
  )
values
  (
    2,'Menu Maintenance',1,2,1,'Menu.aspx','~/Tools/',null,null,'Y','Y',0
  );


INSERT INTO APPS_MODULE_REF
  (	    
    MODULE_ID
   ,MODULE_NAME
	 ,PARENT_ID
	 ,MENU_LEVEL
	 ,SORT_ORDER
	 ,PAGE_NAME
	 ,FOLDER_PATH
   ,TYPE
	 ,CODE
	 ,IS_ACTIVE
   ,IS_ADMIN
	 ,CREATED_BY
  )
values
  (
    3,'Role Maintenance',1,2,2,'Roles.aspx','~/Tools/',null,null,'Y','Y',0
  );
INSERT INTO APPS_MODULE_REF
  (	    
    MODULE_ID
   ,MODULE_NAME
	 ,PARENT_ID
	 ,MENU_LEVEL
	 ,SORT_ORDER
	 ,PAGE_NAME
	 ,FOLDER_PATH
   ,TYPE
	 ,CODE
	 ,IS_ACTIVE
   ,IS_ADMIN
	 ,CREATED_BY
  )
values
  (
    4,'User Maintenance',1,2,3,'UserManagement.aspx','~/Tools/',null,null,'Y','Y',0
  );

INSERT INTO APPS_MODULE_REF
  (	    
    MODULE_ID
   ,MODULE_NAME
	 ,PARENT_ID
	 ,MENU_LEVEL
	 ,SORT_ORDER
	 ,PAGE_NAME
	 ,FOLDER_PATH
   ,TYPE
	 ,CODE
	 ,IS_ACTIVE
   ,IS_ADMIN
	 ,CREATED_BY
	 ,CREATED_DATE
  )
values
  (
    5,'Application Query',1,2,4,'Query.aspx','~/Tools/',null,null,'Y','Y',0,GetDate()
  );
INSERT INTO APPS_MODULE_REF
  (	    
    MODULE_ID
   ,MODULE_NAME
	 ,PARENT_ID
	 ,MENU_LEVEL
	 ,SORT_ORDER
	 ,PAGE_NAME
	 ,FOLDER_PATH
   ,TYPE
	 ,CODE
	 ,IS_ACTIVE
   ,IS_ADMIN
	 ,CREATED_BY
	 ,CREATED_DATE
  )
values
  (
    6,'Application Information',1,2,5,'AppInfo.aspx','~/Tools/',null,null,'Y','Y',0,GetDate()
  );

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY
  )
values (1,2,'Y',0);

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY
  )
values (1,3,'Y',0);

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY
  )
values (1,4,'Y',0);

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY
	 ,CREATED_DATE
  )
values (1,5,'Y',0,GetDate());

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY
	 ,CREATED_DATE
  )
values (1,6,'Y',0,GetDate());

SET IDENTITY_INSERT APPS_MODULE_REF OFF;
--commit;

--Functions
--------------------------------------------------------
--  Function Split
--------------------------------------------------------
CREATE FUNCTION Split (
      @InputString                  VARCHAR(8000),
      @Delimiter                    VARCHAR(50)
)

RETURNS @Items TABLE (
      Item                          VARCHAR(8000)
)

AS
BEGIN
      IF @Delimiter = ' '
      BEGIN
            SET @Delimiter = ','
            SET @InputString = REPLACE(@InputString, ' ', @Delimiter)
      END

      IF (@Delimiter IS NULL OR @Delimiter = '')
            SET @Delimiter = ','

--INSERT INTO @Items VALUES (@Delimiter) -- Diagnostic
--INSERT INTO @Items VALUES (@InputString) -- Diagnostic

      DECLARE @Item                 VARCHAR(8000)
      DECLARE @ItemList       VARCHAR(8000)
      DECLARE @DelimIndex     INT

      SET @ItemList = @InputString
      SET @DelimIndex = CHARINDEX(@Delimiter, @ItemList, 0)
      WHILE (@DelimIndex != 0)
      BEGIN
            SET @Item = SUBSTRING(@ItemList, 0, @DelimIndex)
            INSERT INTO @Items VALUES (@Item)

            -- Set @ItemList = @ItemList minus one less item
            SET @ItemList = SUBSTRING(@ItemList, @DelimIndex+1, LEN(@ItemList)-@DelimIndex)
            SET @DelimIndex = CHARINDEX(@Delimiter, @ItemList, 0)
      END -- End WHILE

      IF @Item IS NOT NULL -- At least one delimiter was encountered in @InputString
      BEGIN
            SET @Item = @ItemList
            INSERT INTO @Items VALUES (@Item)
      END

      -- No delimiters were encountered in @InputString, so just return @InputString
      ELSE INSERT INTO @Items VALUES (@InputString)

      RETURN

END; -- End Function Split

--------------------------------------------------------
--  Function FN_GETAPPMODAUTH_BYNAME
--------------------------------------------------------
CREATE Function FN_GETAPPMODAUTH_BYNAME
--ALTER Function [dbo].[FN_GETAPPMODAUTH_BYNAME]
   ( 
	 @PI_UUID numeric
	,@PI_MODULE_ID numeric
	,@PI_AUTH_NAME VARCHAR(100)
	,@PI_OVERRIDE CHAR
   )
   RETURNS varchar(1000)
WITH EXECUTE AS CALLER
AS
Begin
  DECLARE @po_authval varchar(1000);
  DECLARE @po_itemval varchar(1000);
  DECLARE @lv_lineval varchar(100);
  DECLARE @lv_valtype varchar(100);
  DECLARE @lv_delimer varchar(1);
  DECLARE @lv_MIOK Numeric;
  DECLARE @astcnt Numeric;

  SELECT @lv_MIOK = MODULE_ID
  FROM APPS_MODULE_AUTH_REF
  WHERE IS_ACTIVE = 'Y'
    AND MODULE_ID = @PI_MODULE_ID
    AND AUTH_NAME = @PI_AUTH_NAME;
  IF @lv_MIOK > 0
	BEGIN 
		DECLARE @it varchar(100);
		SET @po_itemval = '';
		SET @astcnt = 0;
		DECLARE Value_Cursor CURSOR FOR
			SELECT A.VALUE
					,B.OBJTYPE
			FROM APPS_ROLE_MODULE_AUTH_REF A
			INNER JOIN APPS_MODULE_AUTH_REF B ON A.MODULE_ID = B.MODULE_ID
				AND A.AUTH_NAME = B.AUTH_NAME
			INNER JOIN APPS_USER_ROLE_REF C ON A.ROLE_ID = C.ROLE_ID
				AND C.UUID = @PI_UUID AND C.IS_ACTIVE = 'Y'
			WHERE A.IS_ACTIVE = 'Y'
				AND A.MODULE_ID = @PI_MODULE_ID
				AND A.AUTH_NAME = @PI_AUTH_NAME;
		OPEN Value_Cursor;
		FETCH NEXT FROM Value_Cursor INTO @lv_lineval,@lv_valtype;
		if @lv_valtype = 'IT'
			SET @lv_delimer = '';
		else
		    SET @lv_delimer = '''';

		SET @po_itemval = @lv_lineval;		
		WHILE ( @@FETCH_STATUS = 0 )
		   BEGIN
			FETCH NEXT FROM Value_Cursor INTO @lv_lineval,@lv_valtype;
			if(@@FETCH_STATUS = 0)
				BEGIN
					SET @po_itemval = @po_itemval + '|' + @lv_lineval;
					IF @lv_lineval = '*'
						SET @astcnt = 1;
			   END; --Fetch = 0
		   END;
		CLOSE Value_Cursor;
		DEALLOCATE Value_Cursor;
		--SELECT @astcnt = CHARINDEX('*',@po_authval);
		IF ((@PI_OVERRIDE='Y') AND (@astcnt > 0))
			SET @po_authval = '*';
		ELSE
		  BEGIN
			DECLARE item_Cursor CURSOR FOR
			SELECT Item from dbo.Split(@po_itemval, '|') x
			GROUP BY Item;
			OPEN item_Cursor;
			FETCH NEXT FROM item_Cursor INTO @lv_lineval;
			SET @po_authval = @lv_delimer + @lv_lineval + @lv_delimer;		
			WHILE ( @@FETCH_STATUS = 0 )
			   BEGIN
				FETCH NEXT FROM item_Cursor INTO @lv_lineval;
				if(@@FETCH_STATUS = 0)
					BEGIN
						SET @po_authval = @po_authval + ',' + @lv_delimer + @lv_lineval + @lv_delimer;
					END;
			   END;
			CLOSE item_Cursor;
			DEALLOCATE item_Cursor;
		 END; --No *
		--SET @po_authval = @astcnt;
		--SET @po_authval = @po_itemval;
	END; -- if with value
	
  ELSE -- NO Value/Parameter not set
	SET @po_authval = '*';


  return @po_authval;
END; --Function FN_GETAPPMODAUTH_BYNAME

--------------------------------------------------------
--  Function FN_GetPageTitle
--------------------------------------------------------
CREATE Function FN_GetPageTitle
--ALTER Function [dbo].[FN_GetPageTitle]
   ( 
     @pi_pname varchar(100)
   )
   RETURNS varchar(200)
WITH EXECUTE AS CALLER
AS
Begin
  DECLARE @po_retvl varchar(100);
  DECLARE @lv_mnulv Numeric;
  DECLARE @lv_pntId Numeric;
  DECLARE @lv_mdlnm varchar(100);

  SELECT @lv_mdlnm = MODULE_NAME
		,@lv_mnulv = MENU_LEVEL
		,@lv_pntId = PARENT_ID 
  FROM APPS_MODULE_REF
  WHERE upper(page_name) = upper(@pi_pname);

  IF @lv_mnulv > 1
	SET @po_retvl = '> ' + @lv_mdlnm;
  ELSE
	SET @po_retvl = @lv_mdlnm;

  WHILE @lv_mnulv > 1
  BEGIN
	  SELECT @lv_mdlnm = MODULE_NAME
			,@lv_mnulv = MENU_LEVEL
			,@lv_pntId = PARENT_ID 
	  FROM APPS_MODULE_REF
    WHERE module_id = @lv_pntId;
    IF @lv_mnulv = 1 
      SET @po_retvl = @lv_mdlnm + @po_retvl;
    ELSE
      SET @po_retvl = '> ' + @lv_mdlnm + @po_retvl;        
  END; --While
   RETURN (@po_retvl);
END; --Function FN_GetPageTitle

--Package equivalent
--------------------------------------------------------
--  Function get_userrole
--------------------------------------------------------
CREATE FUNCTION get_userrole(@pi_uuid numeric)
RETURNS TABLE
AS
RETURN
(
    SELECT ur.role_id
    FROM APPS_USER_ROLE_REF ur
    WHERE ur.UUID = @pi_uuid
    AND IS_ACTIVE = 'Y'
    GROUP BY role_id
);

--------------------------------------------------------
--  Function get_userrolewithparent
--------------------------------------------------------
CREATE FUNCTION get_userrolewithparent(@pi_uuid numeric)
RETURNS TABLE
AS
RETURN
(
          SELECT role_id
          FROM APPS_ROLE_REF
          WHERE ROLE_ID IN (
            SELECT role_id FROM dbo.get_userrole(@pi_uuid)
          )
          OR PARENT_ID IN (
            SELECT role_id FROM dbo.get_userrole(@pi_uuid)
          )
);

--------------------------------------------------------
--  Function get_uabmod00
--------------------------------------------------------
CREATE FUNCTION get_uabmod00(@pi_uuid numeric)
--ALTER FUNCTION get_uabmod00(@pi_uuid numeric)
RETURNS TABLE
AS
RETURN
(
        select role_auth.autohrztn + '|' + ISNULL(wa.ISAUTH,'N') + '|' + ISNULL(fa.ISAUTH,'N') AS autohrztn
              ,role_auth.role_id
              ,role_auth.module_id
              ,role_auth.is_active
        from APPS_ROLE_MODULE_REF role_auth
        left join (
             SELECT module_id
                  ,'Y' as ISAUTH
                  ,count(module_id) as cnt
            FROM APPS_MODULE_AUTH_REF
            WHERE IS_ACTIVE = 'Y'
            GROUP BY module_id         
        ) wa on wa.module_id = role_auth.module_id
        left join (
             SELECT module_id
                  ,'Y' as ISAUTH
                  ,count(module_id) as cnt
            FROM APPS_MODULE_FLDS_REF
            WHERE IS_ACTIVE = 'Y'
            GROUP BY module_id         
        ) fa on fa.module_id = role_auth.module_id
        WHERE role_auth.is_active = 'Y'
          AND role_auth.ROLE_ID IN (
            SELECT role_id FROM dbo.get_userrolewithparent(@pi_uuid)
        )
--        order by role_auth.role_id,role_auth.module_id
); 

--------------------------------------------------------
--  Function get_userauthbase
--------------------------------------------------------
CREATE FUNCTION get_userauthbase(@pi_uuid numeric)
RETURNS TABLE
AS
RETURN
(
        SELECT mra.AUTOHRZTN
              ,mra.ROLE_ID
              ,m.MODULE_ID
              ,m.PARENT_ID
              ,mra.IS_ACTIVE
        FROM APPS_MODULE_REF m
        inner join (
          select module_id
                ,role_id
                ,autohrztn
                ,is_active
          from dbo.get_uabmod00(@pi_uuid)
        ) mra on mra.module_id = m.module_id
);
/* -- Get User Authorization Main Function called in page master-- */    
--------------------------------------------------------
--  Function get_userauth_all
--------------------------------------------------------
CREATE FUNCTION get_userauth_all(@pi_uuid numeric)
--ALTER FUNCTION [dbo].[get_userauth_all](@pi_uuid numeric)
RETURNS TABLE
AS
RETURN
(
        SELECT * FROM (
          -- BEG: Base Modules --
          SELECT CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 'YYYY'
                  ELSE mbase.AUTOHRZTN
                 END AS AUTOHRZTN
                ,CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 0
                  ELSE mbase.ROLE_ID
                END AS ROLE_ID
                ,ma.MODULE_ID
                ,ma.MODULE_NAME
                ,ma.PARENT_ID
                ,ma.MENU_LEVEL
                ,ma.PAGE_NAME
                ,ma.FOLDER_PATH
                ,ma.SORT_ORDER
		,ma.is_active
          FROM APPS_MODULE_REF ma
          INNER JOIN (    
              SELECT AUTOHRZTN,ROLE_ID,module_id
              FROM DBO.get_userauthbase(@pi_uuid)
              GROUP BY AUTOHRZTN,ROLE_ID,module_id
          ) mbase ON mbase.module_id = ma.module_id
          -- END: Base Modules --

          -- BEG: Modules of Role that was given top/parent Module--
          union          
          SELECT CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 'YYYY'
                  ELSE mbase.AUTOHRZTN
                 END AS AUTOHRZTN
                ,CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 0
                  ELSE mbase.ROLE_ID
                END AS ROLE_ID
                ,ma.MODULE_ID
                ,ma.MODULE_NAME
                ,ma.PARENT_ID
                ,ma.MENU_LEVEL
                ,ma.PAGE_NAME
                ,ma.FOLDER_PATH
                ,ma.SORT_ORDER
				,ma.is_active
          FROM APPS_MODULE_REF ma
          INNER JOIN (    
              SELECT *
              FROM DBO.get_userauthbase(@pi_uuid)
          ) mbase ON mbase.module_id = ma.parent_id
          -- END: Modules of Role that was given top/parent Module--

          union
          -- BEG: Level 3 --
          SELECT CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 'YYYY'
                  ELSE aa.AUTOHRZTN
                 END AS AUTOHRZTN
                ,CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 0
                  ELSE aa.ROLE_ID
                END AS ROLE_ID
                ,ma.MODULE_ID
                ,ma.MODULE_NAME
                ,ma.PARENT_ID
                ,ma.MENU_LEVEL
                ,ma.PAGE_NAME
                ,ma.FOLDER_PATH
                ,ma.SORT_ORDER
				,ma.is_active
          FROM APPS_MODULE_REF ma
          INNER JOIN (
              SELECT mbase.AUTOHRZTN
                    ,mbase.ROLE_ID
                    ,jj.MODULE_ID
              FROM APPS_MODULE_REF jj
              INNER JOIN (    
                  SELECT *
                  FROM DBO.get_userauthbase(@pi_uuid)
              ) mbase ON mbase.module_id = jj.parent_id
          ) aa ON aa.module_id = ma.parent_id
          -- End: Level 3 --
          -- BEG: Parent --
          union
          SELECT CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 'YYYY'
                  ELSE aa.AUTOHRZTN
                 END AS AUTOHRZTN
                ,CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 0
                  ELSE aa.ROLE_ID
                END AS ROLE_ID
                ,ma.MODULE_ID
                ,ma.MODULE_NAME
                ,ma.PARENT_ID
                ,ma.MENU_LEVEL
                ,ma.PAGE_NAME
                ,ma.FOLDER_PATH
                ,ma.SORT_ORDER
				,ma.is_active
          FROM APPS_MODULE_REF ma
          INNER JOIN (
              SELECT mbase.AUTOHRZTN
                    ,mbase.ROLE_ID
                    ,jj.MODULE_ID
              FROM APPS_MODULE_REF jj
              INNER JOIN (    
                  SELECT *
                  FROM DBO.get_userauthbase(@pi_uuid)
              ) mbase ON mbase.parent_id = jj.module_id
          ) aa on ma.module_id = aa.module_id
          -- End: Parent --
          -- BEG: Parent of parent --
          union
          SELECT CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 'YYYY'
                  ELSE aa.AUTOHRZTN
                 END AS AUTOHRZTN
                ,CASE ISNULL(ma.PAGE_NAME,'WALA')
                  WHEN 'WALA' THEN 0
                  ELSE aa.ROLE_ID
                END AS ROLE_ID
                ,ma.MODULE_ID
                ,ma.MODULE_NAME
                ,ma.PARENT_ID
                ,ma.MENU_LEVEL
                ,ma.PAGE_NAME
                ,ma.FOLDER_PATH
                ,ma.SORT_ORDER
				,ma.is_active
          FROM APPS_MODULE_REF ma
          INNER JOIN (
              SELECT yy.AUTOHRZTN
                    ,yy.ROLE_ID
                    ,cc.MODULE_ID
              FROM APPS_MODULE_REF cc
              INNER JOIN (    
                SELECT zz.AUTOHRZTN
                      ,zz.ROLE_ID
                      ,bb.MODULE_ID
                      ,bb.parent_id
                FROM APPS_MODULE_REF bb
                INNER JOIN (    
                    SELECT *
                  FROM DBO.get_userauthbase(@pi_uuid)
                ) zz ON zz.parent_id = bb.module_id
              ) yy on yy.parent_id = cc.module_id
              where cc.menu_level = 1
          ) aa ON aa.module_id = ma.module_id
          -- End: Parent of parent --
          -- Group all unioned select
          group by aa.AUTOHRZTN
                ,aa.ROLE_ID
                ,ma.MODULE_ID
                ,ma.MODULE_NAME
                ,ma.PARENT_ID
                ,ma.MENU_LEVEL
                ,ma.PAGE_NAME
                ,ma.FOLDER_PATH
                ,ma.SORT_ORDER
				,ma.is_active
          
        ) xxx -- END: FROM
		where is_active = 'Y'

        --ORDER BY xxx.MENU_LEVEL, xxx.PARENT_ID,xxx.SORT_ORDER -- END: SELECT *        
); -- END Function


--VMS New Tables for iWantTV use --
/****** Object:  Table [dbo].[VMS_Screen_Event_Hdr]    Script Date: 9/22/2015 10:29:30 AM ******/
CREATE TABLE [dbo].[VMS_Screen_Event_Hdr](
	[screen_event_hdr_id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[screen_event_desc] [nvarchar](500) NULL,
	[screen_event_type] [nvarchar](10) NOT NULL,
	[version] [numeric](18, 2) NOT NULL,
	[is_active] [bit] DEFAULT ((1)) NOT NULL,
	[creatdt] [datetime] DEFAULT (getdate()) NULL,
	[createby] [varchar](50) NULL,
	[updatedt] [datetime] NULL,
	[updateby] [varchar](50) NULL
);

INSERT INTO [dbo].[VMS_Screen_Event_Hdr]
           ([screen_event_desc], [screen_event_type], [version])           
     VALUES
           ('Splash Screen Images','SPLASH',1.00);
INSERT INTO [dbo].[VMS_Screen_Event_Hdr]
            ([screen_event_desc], [screen_event_type], [version])           
     VALUES
           ('Tour Screen Images','TOUR',1.00);
INSERT INTO [dbo].[VMS_Screen_Event_Hdr]
            ([screen_event_desc], [screen_event_type], [version])           
     VALUES
           ('Welcome Background Images','WELCOME',1.00);

/****** Object:  Table [dbo].[VMS_Screen_Event_Images]    Script Date: 9/22/2015 10:41:26 AM ******/
CREATE TABLE [dbo].[VMS_Screen_Event_Images](
	[event_image_id] [numeric](18, 0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[screen_event_hdr_id] [numeric](18, 0) NOT NULL,
	[image_desc] [nvarchar](1000) NULL,
	[image_ldpi] [nvarchar](1000) NOT NULL,
	[image_mdpi] [nvarchar](1000) NOT NULL,
	[image_hdpi] [nvarchar](1000) NOT NULL,
	[image_xhdpi] [nvarchar](1000) NOT NULL,
	[image_xxhdpi] [nvarchar](1000) NOT NULL,
	[sort_order] int default 1 NOT NULL,
	[creatdt] [datetime] DEFAULT (getdate()) NULL,
	[createby] [nvarchar](50) NULL,
	[updatedt] [datetime] NULL,
	[updateby] [nvarchar](50) NULL
 );

 CREATE TABLE [dbo].[VMS_User_Artist_Program_Chain](
	[ssoid] [nvarchar](50) NOT NULL,
	[artist_program_id] [numeric](18, 0) NOT NULL,
	[asset_type] [int] DEFAULT ((1)) NOT NULL,
	[is_active] [bit] DEFAULT ((1)) NOT NULL,
	[createdt] [datetime] DEFAULT (getdate()) NULL,
	[createby] [nvarchar](50) NULL,
	[updatedt] [datetime] NULL,
	[updateby] [nvarchar](50) NULL
);

CREATE TABLE [dbo].[VMS_World_Theme](
	[world_id] [int] NOT NULL,
	[theme_color] [nvarchar](50) NULL,
	[is_active] [bit] DEFAULT ((1)) NOT NULL,
	[createdt] [datetime] DEFAULT (getdate()) NOT NULL,
	[createby] [nvarchar](50) NULL,
	[updatedt] [datetime] NULL,
	[updateby] [nvarchar](50) NULL
);




CREATE TABLE [dbo].[VMS_BUNDLE_SECTION](
	[ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[TITLE] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](50) NOT NULL,
	[IS_ACTIVE] [char](1) NOT NULL,
	[createdt] [datetime] NOT NULL,
	[createby] [nvarchar](50) NOT NULL,
	[updatedt] [datetime] NULL,
	[updateby] [nvarchar](50) NULL
);



