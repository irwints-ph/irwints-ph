/* mysql version 1.1 */
\! echo Delete Previous Data...
delete from APPS_USER_ROLE_REF;
delete from APPS_ROLE_MODULE_REF;
delete from APPS_MODULE_REF;
delete from APPS_MENU_TOP;
delete from APPS_ROLE_REF;

delete from APPS_PERSONNEL_MSTR;
delete from APPS_USER_MAPPER;
delete from APPS_USER_REF;
delete from users;

\! echo Initial Data...
INSERT INTO APPS_USER_REF (UUID,FULLNAME,CREATED_BY) VALUES(0,'Super Root',0);
update APPS_USER_REF set UUID = 0 where FULLNAME='Super Root';
/* Password = 1 */
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(0,'Root',md5('1'),'',0);
INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(0,'admin@thissite.com','Super','Root',0);


\! echo Create Regular User...
alter table APPS_USER_REF auto_increment=100;
INSERT INTO APPS_USER_REF (FULLNAME,CREATED_BY) VALUES('Reg User',0);
SELECT @ID := LAST_INSERT_ID();
INSERT INTO APPS_USER_MAPPER (UUID,USERNAME,PASSWORD,SALTKEY,CREATED_BY) VALUES(@ID,'User',md5('1'),'',0);
INSERT INTO APPS_PERSONNEL_MSTR (UUID,EMAIL,LASTNAME,FIRSTNAME,CREATED_BY) VALUES(@ID,'user@thissite.com','Reg','User',0);
INSERT INTO APPS_ROLE_REF (ROLE_ID,ROLE_NAME,ROLE_DESCRIPTION,IS_ACTIVE,IS_ADMIN,CREATED_BY) 
  VALUES(99,'COMMON','Common Modules','Y','N',0);

INSERT INTO APPS_USER_ROLE_REF (UUID,ROLE_ID,IS_ACTIVE,CREATED_BY) 
  VALUES(@ID,99,'Y',0);

\! echo Create Default Roles...
insert into apps_role_ref (role_id,role_name,role_description,is_active,is_admin,created_by)
  values(0,'APPS_ALL','Application Root Administrator','Y','Y',0);

/* make sure role_id is 0*/
update apps_role_ref set role_id = 0 where role_name='APPS_ALL';
alter table apps_role_ref auto_increment=0;

insert into apps_role_ref (role_id,role_name,role_description,is_active,is_admin)
  values(1,'admin','Admin','Y','Y');
INSERT INTO APPS_USER_ROLE_REF (uuid,role_id) values(0,0);
INSERT INTO APPS_USER_ROLE_REF (UUID,ROLE_ID) VALUES(0,1);


\! echo Create Default Modules...
insert into apps_menu_top(m_prnt_id,menu_name)
values(0,'Admin');

insert into apps_module_ref(module_id,module_name,m_prnt_id,tran_code,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(1,'Tools',0,'',null,1,100,'','','','Y','Y','Y');

insert into apps_module_ref(module_id,module_name,m_prnt_id,tran_code,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(2,'Menu Maintenance',0,'AM01',1,2,1,'frmmenu','menu','/www/tools/','Y','Y',0);

insert into apps_module_ref(module_id,module_name,m_prnt_id,tran_code,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(3,'Role Maintenance',0,'AR01',1,2,2,'frmrole','roles','/www/tools/','Y','Y',0);

insert into apps_module_ref(module_id,module_name,m_prnt_id,tran_code,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(4,'User Maintenance',0,'AU01',1,2,3,'frmusermaster','usermanagement','/www/tools/','Y','Y',0);

insert into apps_module_ref(module_id,module_name,m_prnt_id,tran_code,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(5,'Application Query',0,'AQ01',1,2,4,'frmquery','query','/www/tools/','Y','Y',0);

insert into apps_module_ref(module_id,module_name,m_prnt_id,tran_code,parent_id,menu_level,sort_order,form_name,page_name,folder_path,is_active,is_admin,is_parent  )
values(6,'Application Information',0,'AI01',1,2,5,'frmappinfo','appinfo','/www/tools/','Y','Y',0);

\! echo Create Default Roles 2...
insert into apps_role_module_ref(role_id,module_id,is_active,created_by)
values (1,2,'Y',0);

insert into apps_role_module_ref(role_id,module_id,is_active,created_by)
values (1,3,'Y',0);

insert into apps_role_module_ref(role_id,module_id,is_active,created_by)
values (1,4,'Y',0);

insert into apps_role_module_ref(role_id,module_id,is_active,created_by)
values (1,5,'Y',0);

insert into apps_role_module_ref(role_id,module_id,is_active,created_by)
values (1,6,'Y',1);

insert into apps_role_ref (role_id,role_name,role_description,is_active,is_admin,created_by)
  values(2,'User Admin','User Administrator','Y','Y',0);

\! echo Create Default Roles 3...
INSERT INTO APPS_ROLE_MODULE_REF(ROLE_ID,MODULE_ID,IS_ACTIVE,CREATED_BY)
  values (99,6,'Y',0);

\! echo Additional Constraint...
/*
alter table apps_module_ref modify column module_id int not null auto_increment;
*/
alter table apps_module_ref auto_increment=100;
/* 
alter table apps_user_role_ref add constraint fk_apps_ref_user_role02 foreign key (role_id)    references apps_role_ref (role_id);
alter table apps_role_module_ref add constraint fk_apps_ref_role_module01 foreign key (role_id) references apps_role_ref (role_id);
alter table apps_role_module_ref add constraint fk_apps_ref_role_module02 foreign key (module_id) references apps_module_ref (module_id);
alter table apps_audit_dtl_ref add constraint fk_apps_audit_dtl_ref01 foreign key (audit_id) references apps_audit_hdr_ref (audit_id);
alter table apps_user_module_logs add constraint fk_apps_user_ml01 foreign key (module_id) references apps_module_ref (module_id);
alter table apps_role_module_flds_ref add constraint fk_apps_role_module_flds00 foreign key (module_id) references apps_module_ref (module_id);
alter table apps_role_module_flds_ref add constraint fk_apps_role_module_flds01 foreign key (role_id) references apps_role_ref (role_id);
alter table apps_role_module_auth_ref add constraint fk_apps_role_module_auth_ref01 foreign key (module_id) references apps_module_ref (module_id);
alter table apps_module_flds_ref add constraint fk_apps_module_flds_ref00 foreign key (module_id) references apps_module_ref (module_id);
alter table apps_module_auth_ref add constraint fk_apps_module_auth_ref_00 foreign key (module_id) references apps_module_ref (module_id);
 */
/* menu data */
\! echo Create Application Modules...
insert into apps_module_ref( module_name	,parent_id	,menu_level	,sort_order	,page_name	,folder_path	,is_parent,code)
values( 'Transaction',null,1,90,'','','Y','' );
SELECT @ID := LAST_INSERT_ID();
insert into apps_module_ref( module_name	,parent_id	,menu_level	,sort_order	,page_name	,folder_path	,is_parent,code)
values ('Transaction Queue',@ID,2,1,'transation','/www/','N','' );
insert into apps_module_ref( module_name	,parent_id	,menu_level	,sort_order	,page_name	,folder_path	,is_parent,code)
values ('Bill Projection',@ID,2,3,'projection','/www/billing/','N','' );
insert into apps_module_ref( module_name	,parent_id	,menu_level	,sort_order	,page_name	,folder_path	,is_parent,code)
values ('Billing',@ID,2,2,'','','Y','' );
SELECT @ID := LAST_INSERT_ID();
insert into apps_module_ref( module_name	,parent_id	,menu_level	,sort_order	,page_name	,folder_path	,is_parent,code)
values ('Billing Interface',@ID,3,1,"BillingInterface","/",'N','' );
insert into apps_module_ref( module_name	,parent_id	,menu_level	,sort_order	,page_name	,folder_path	,is_parent,code)
values ('Billing Adjustment',@ID,3,2,"Transaction","/",'N','' );

/*
--Angular
-- page_name   -
-- folder_path - parent folder path
-- code        - Authorization Code
-- form_name   - parameters ?
-- is_parent   - With Child
*/
/*
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order,folder_path,page_name,is_parent)
  values (100, 'N','Transaction',null, 1, 1, null, null, 'Y');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order,folder_path,page_name,is_parent) 
  values (101, 'N','Transaction Queue',100, 2, 1,'/www/','transation', 'N');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order,folder_path,page_name,is_parent) 
  values (102, 'N','Bill Projection',100, 2, 3,'/www/billing/','projection', 'N');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order,folder_path,page_name,is_parent) 
  values (103, 'N','Billing',100, 2, 2,'','', 'Y');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order,folder_path,page_name,is_parent) 
  values (104, 'N','Billing Interface',103, 3, 1,'/','BillingInterface', 'N');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order,folder_path,page_name,is_parent) 
  values (105, 'N','Billing Adjustment',103, 3, 2,'/','Transaction', 'N');
*/
update apps_module_ref
   set created_by = 0
 where module_id >= 100;

\! echo Create User For delete...
insert into users ( id,email,name,password,chngpass )
  values(1,'root@admin.com','Admin',md5('1'),'N');

insert into users ( id,email,name,password,chngpass )
    values(2,'user@admin.com','User Admin',md5('1'),'N');

