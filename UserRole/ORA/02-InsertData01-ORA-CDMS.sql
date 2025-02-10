delete from APPS_USER_ROLE_REF;
delete from APPS_ROLE_MODULE_REF;
delete from APPS_MODULE_REF;
delete from APPS_ROLE_REF;

-- Roles  CDMSADMIN
INSERT INTO APPS_ROLE_REF ( ROLE_ID,ROLE_NAME,ROLE_DESCRIPTION,IS_ACTIVE,IS_ADMIN,CREATED_BY) 
        VALUES(99,'COMMON','Common Modules','Y','Y',200429465);

--INSERT INTO APPS_USER_ROLE_REF (UUID,ROLE_ID,IS_ACTIVE,CREATED_BY) 
--        VALUES(:UUID,99,'Y',200429465);

INSERT INTO APPS_ROLE_REF (ROLE_ID,ROLE_NAME,ROLE_DESCRIPTION,IS_ACTIVE,IS_ADMIN,CREATED_BY) 
        VALUES(0,'APPS_ALL','Application Root Administrator','Y','Y',200429465);
INSERT INTO APPS_ROLE_REF ( ROLE_ID,ROLE_NAME,ROLE_DESCRIPTION,IS_ACTIVE,IS_ADMIN,CREATED_BY) 
        VALUES(1,'Admin','Admin','Y','Y',200429465);

INSERT INTO APPS_USER_ROLE_REF (UUID,ROLE_ID,IS_ACTIVE,CREATED_BY) 
        VALUES(200429465,0,'Y',200429465);
INSERT INTO APPS_USER_ROLE_REF (UUID,ROLE_ID,IS_ACTIVE,CREATED_BY) 
        VALUES(200429465,1,'Y',200429465);

insert into apps_module_ref(module_id,module_name,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(1,'Tools',null,1,100,'','','','Y','Y','Y');

insert into apps_module_ref(module_id,module_name,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin)
values(2,'Menu Maintenance',1,2,1,'frmmenu','menu','/www/tools/','Y','Y');

insert into apps_module_ref(module_id,module_name,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin )
values(3,'Role Maintenance',1,2,2,'frmrole','roles','/www/tools/','Y','Y');

insert into apps_module_ref(module_id,module_name,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin)
values(4,'User Maintenance',1,2,3,'frmusermaster','usermanagement','/www/tools/','Y','Y');

insert into apps_module_ref(module_id,module_name,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin)
values(5,'Application Query',1,2,4,'frmquery','query','/www/tools/','Y','Y');

insert into apps_module_ref(module_id,module_name,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin)
values(6,'Application Information',1,2,5,'frmappinfo','appinfo','/www/tools/','Y','Y');


-- Create Default Roles 2...
insert into apps_role_module_ref(role_id,module_id) values (1,2);
insert into apps_role_module_ref(role_id,module_id) values (1,3);
insert into apps_role_module_ref(role_id,module_id) values (1,4);
insert into apps_role_module_ref(role_id,module_id) values (1,5);
insert into apps_role_module_ref(role_id,module_id) values (1,6);


insert into apps_role_ref (role_id,role_name,role_description,is_active,is_admin)
  values(2,'User Admin','User Administrator','Y','Y');

INSERT INTO APPS_ROLE_MODULE_REF(ROLE_ID,MODULE_ID) values (99,6);

commit;

exit;