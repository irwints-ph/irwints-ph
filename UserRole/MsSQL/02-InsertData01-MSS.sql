delete from APPS_USER_ROLE_REF;
delete from APPS_ROLE_MODULE_REF;
delete from APPS_MODULE_REF;
delete from APPS_ROLE_REF;

delete from APPS_PERSONNEL_MSTR;
delete from APPS_USER_MAPPER;
delete from APPS_USER_REF;

--Initial Data For Standard Menu/Modules
--SET IDENTITY_INSERT APPS_USER_REF ON;
SET IDENTITY_INSERT APPS_USER_REF ON;
INSERT INTO APPS_USER_REF (UUID,FULLNAME,CREATED_BY) VALUES(0,'Super Root',0);
SET IDENTITY_INSERT APPS_USER_REF OFF;
--Password = !qazxsw2
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(0,'Root','1','',0);

INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(0,'admin@thissite.com','Super','Root',0);

--SET IDENTITY_INSERT APPS_USER_REF OFF;

INSERT INTO APPS_USER_REF (FULLNAME,CREATED_BY) VALUES('Reg User',0);
GO
SET IDENTITY_INSERT APPS_ROLE_REF ON;

DECLARE @ID as NUMERIC;
SELECT @ID = IDENT_CURRENT('APPS_USER_REF');
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(@ID,'User','1','',0);
INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(@ID,'user@thissite.com','Reg','User',0);
INSERT INTO APPS_ROLE_REF (
                            ROLE_ID
                           ,ROLE_NAME
                           ,ROLE_DESCRIPTION
                           ,IS_ACTIVE
                           ,IS_ADMIN
                           ,CREATED_BY
                          ) 
        VALUES(99,'COMMON','Common Modules','Y','Y',0);

INSERT INTO APPS_USER_ROLE_REF (
                                  UUID
                                 ,ROLE_ID
                                 ,IS_ACTIVE
                                 ,CREATED_BY
                                ) 
        VALUES(@ID,99,'Y',0);

GO

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
INSERT INTO APPS_USER_ROLE_REF (
                                  UUID
                                 ,ROLE_ID
                                 ,IS_ACTIVE
                                 ,CREATED_BY
                                ) 
        VALUES(0,1,'Y',0);

SET IDENTITY_INSERT APPS_ROLE_REF OFF;


SET IDENTITY_INSERT APPS_MODULE_REF ON;

insert into apps_module_ref
  (
     module_id
	,module_name
	,parent_id
	,menu_level
	,sort_order
	,page_name
	,folder_path
	,type
	,code
	,is_active
	,is_admin
	,created_by
  )
values
  (
    1,'Tools',null,1,100,null,null,null,null,'Y','Y',0
  );


insert into apps_module_ref
  (
     module_id
	,module_name
	,parent_id
	,menu_level
	,sort_order
	,form_name
	,page_name
	,folder_path
	,is_active
	,is_admin
	,created_by
  )
values
  (
    2,'Menu Maintenance',1,2,1,'frmmenu','menu','/www/tools/','Y','Y',0
  );


insert into apps_module_ref
  (
     module_id
	,module_name
	,parent_id
	,menu_level
	,sort_order
	,form_name
	,page_name
	,folder_path
	,is_active
	,is_admin
	,created_by
  )
values
  (
    3,'Role Maintenance',1,2,2,'frmrole','roles','/www/tools/','Y','Y',0
  );

insert into apps_module_ref
  (
     module_id
	,module_name
	,parent_id
	,menu_level
	,sort_order
	,form_name
	,page_name
	,folder_path
	,is_active
	,is_admin
	,created_by
  )
values
  (
    4,'User Maintenance',1,2,3,'frmusermaster','usermanagement','/www/tools/','Y','Y',0
  );

insert into apps_module_ref
  (
     module_id
	,module_name
	,parent_id
	,menu_level
	,sort_order
	,form_name
	,page_name
	,folder_path
	,is_active
	,is_admin
	,created_by
  )
values
  (
    5,'Application Query',1,2,4,'frmquery','query','/www/tools/','Y','Y',0
  );

insert into apps_module_ref
  (
     module_id
	,module_name
	,parent_id
	,menu_level
	,sort_order
	,form_name
	,page_name
	,folder_path
	,is_active
	,is_admin
	,created_by
  )
values
  (
    6,'Application Information',1,2,5,'frmappinfo','appinfo','/www/tools/','Y','Y',0
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

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY
	 ,CREATED_DATE
  )
values (99,6,'Y',0,GetDate());

SET IDENTITY_INSERT APPS_MODULE_REF OFF;
--commit;

insert into apps_module_ref
  (
 	 module_name
	,parent_id
	,menu_level
	,sort_order
	,page_name
	,folder_path
	,type
	,code
	,is_active
	,created_by
  )
values
  (
    'Transaction',null,1,90,null,null,null,null,'Y',0
  );

DECLARE @ID as NUMERIC;
SELECT @ID = IDENT_CURRENT('APPS_MODULE_REF');
insert into apps_module_ref
  (
 	 module_name
	,parent_id
	,menu_level
	,sort_order
	,folder_path
	,page_name
	,is_active
	,created_by
  )
values
  (
    'Transaction Queue',@ID,2,1,'/www/','transation','Y',0
  );

insert into apps_module_ref
  (
 	 module_name
	,parent_id
	,menu_level
	,sort_order
	,folder_path
	,page_name
	,is_active
	,created_by
  )
values
  (
    'Bill Projection',@ID,2,1,'/www/billing/','projection','Y',0
  );


