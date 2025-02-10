delete from APPS_USER_ROLE_REF;
delete from APPS_ROLE_MODULE_REF;
delete from APPS_MODULE_REF;
delete from APPS_ROLE_REF;

delete from APPS_PERSONNEL_MSTR;
delete from APPS_USER_MAPPER;
delete from APPS_USER_REF;

--Initial Data For Standard Menu/Modules
INSERT INTO APPS_USER_REF (UUID,FULLNAME,CREATED_BY) VALUES(0,'Super Root',0);

--Password = 1
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(0,'Root','1','',0);

INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(0,'admin@thissite.com','Super','Root',0);

--SET IDENTITY_INSERT APPS_USER_REF OFF;
var UUID NUMBER;
EXEC :UUID := 100;
INSERT INTO APPS_USER_REF (UUID,FULLNAME,CREATED_BY) VALUES(:UUID,'Reg User',0);
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(:UUID,'User','1','',0);
INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(:UUID,'user@thissite.com','Reg','User',0);
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
        VALUES(:UUID,99,'Y',0);

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
  )
values (1,5,'Y',0);

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY	 
  )
values (1,6,'Y',0);

INSERT INTO APPS_ROLE_MODULE_REF
  (
    ROLE_ID
   ,MODULE_ID
	 ,IS_ACTIVE
	 ,CREATED_BY	 
  )
values (99,6,'Y',0);

--commit;

var MODULE_ID NUMBER;
EXEC :MODULE_ID := 100;

insert into apps_module_ref (MODULE_ID 	,module_name	,parent_id	,menu_level	,sort_order	,folder_path	,page_name ,created_by )
values
  ( :MODULE_ID, 'Transaction',null,1,90,null,null,null,null,0 );

insert into apps_module_ref (MODULE_ID 	,module_name	,parent_id	,menu_level	,sort_order	,folder_path	,page_name ,created_by )
values
  ( 101,'Transaction Queue',:MODULE_ID,2,1,'/www/','transation', 0 );
insert into apps_module_ref (MODULE_ID 	,module_name	,parent_id	,menu_level	,sort_order	,folder_path	,page_name ,created_by )
values
  ( 102,'Bill Projection',:MODULE_ID,2,2,'/www/billing/','projection', 0  );


ALTER TABLE apps_role_ref  MODIFY role_id NUMBER GENERATED BY DEFAULT AS IDENTITY
(
  START WITH 100 
  INCREMENT BY 1 
);
exit;