/* mysql version 1.1 */
DROP DATABASE IF EXISTS LaravelDB;
create database LaravelDB;
use LaravelDB;

/*--------------------------------------------------------
--  ddl for table apps_role_ref
--------------------------------------------------------*/
  create table apps_role_ref
   (	role_id          int auto_increment not null 
	   ,role_name        varchar(50)
	   ,role_description varchar(100)
	   ,parent_id        int
	   ,is_active        char(1) default 'Y'
	   ,is_admin         char(1) default 'N'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int default null
     ,last_upd_date timestamp default current_timestamp
     ,constraint pk_apps_ref_role00 primary key (role_id)
   );

/*--------------------------------------------------------
--  ddl for table apps_user_role_ref
--------------------------------------------------------  */
  create table apps_user_role_ref
   (	uuid          int
     ,role_id       int
     ,is_active     char(1) default 'Y'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int default null
     ,last_upd_date timestamp default current_timestamp
     ,constraint pk_apps_ref_user_role00 primary key (uuid,role_id)
   );

/*--------------------------------------------------------
--  ddl for table apps_module_ref
--------------------------------------------------------*/
  create table apps_module_ref
   (	module_id     int auto_increment not null
	   ,module_name   varchar(50)
	   ,parent_id     int
	   ,menu_level    int not null
	   ,sort_order    int
	   ,form_name     varchar(50)
	   ,page_name     varchar(50)
	   ,folder_path   varchar(50)
	   ,type          varchar(5 )
	   ,code          varchar(10)
	   ,is_active     char(1) default 'Y'
     ,is_admin      char(1) default 'N'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int default null
     ,last_upd_date timestamp default current_timestamp
     ,constraint pk_apps_ref_module00 primary key (module_id)
   );


/*--------------------------------------------------------
--  ddl for table apps_role_module_ref
--------------------------------------------------------*/
  create table apps_role_module_ref
   (	role_id       int
	   ,module_id     int
	   ,autohrztn     char(5) default 'YYYYY'
	   ,is_active     char(1) default 'Y'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int default null
     ,last_upd_date timestamp default current_timestamp
     ,constraint pk_apps_ref_role_module00 primary key (role_id,module_id)
   );

/*--------------------------------------------------------
--  table apps_audit_hdr_ref
--------------------------------------------------------*/
  create table apps_audit_hdr_ref
   (	
      audit_id      int auto_increment not null
     ,actiontype    char(01)  not null check (actiontype in ('A','E','D'))                  -- a for add, e for edi, d for delete
     ,user_name     varchar(50)
     ,comp_name     varchar(50)
     ,module_id     int
     ,tablename     varchar(50)
     ,table_key     varchar(30)
     ,actionrmrk    varchar(100)
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,constraint pk_apps_audit_hdr_ref01 primary key (audit_id)
   );

/*--------------------------------------------------------
--  table apps_audit_dtl_ref
--------------------------------------------------------*/
  create table apps_audit_dtl_ref
   (	
      audit_id    int
     ,linenubr    int
     ,fieldnam    varchar(50)
     ,oldvalue    varchar(150)
     ,newvalue    varchar(150)
     ,constraint pk_apps_audit_dtl_ref01 primary key (audit_id,linenubr,fieldnam)
   );

/*--------------------------------------------------------
--  table apps_user_session
--------------------------------------------------------*/
/*-- drop table apps_user_session*/
  create table apps_user_session
   (	
      sessonid   varchar(100) not null
     ,username   varchar(100) not null
     ,logindate  timestamp default current_timestamp
     ,cmprname   varchar(100)
     ,uuid       int
     ,srvrname   varchar(100)
	   ,is_active  char(1) default 'Y'
     ,deactdate  timestamp null
     ,constraint pk_apps_user_session primary key (sessonid,username,logindate)
   );

/*--------------------------------------------------------
--  table apps_user_module_logs
--------------------------------------------------------*/
  create table apps_user_module_logs
   (	
       module_id  int	       not null
      ,uuid	      int	       not null
      ,log_date	  timestamp default current_timestamp
      ,username	  varchar(100)	   not null
      ,cmprname	  varchar(100)
      ,srvrname	  varchar(100)
   );


/*--------------------------------------------------------
--  ddl for table apps_module_flds_ref
--------------------------------------------------------*/
  create table apps_module_flds_ref
   (
        module_id     int not null
       ,field_name    varchar(20) not null
       ,description   varchar(50) not null
       ,is_active     char(1) default 'Y'
       ,created_by    int default null
       ,created_date  timestamp default current_timestamp
       ,last_upd_by   int default null
       ,last_upd_date timestamp default current_timestamp
       ,constraint pk_apps_module_flds_ref_ref00 primary key (module_id, field_name)
 );


/*--------------------------------------------------------
--  ddl for table apps_module_auth_ref
--------------------------------------------------------*/

create table apps_module_auth_ref
   (	
        module_id     int not null
       ,auth_name     varchar(50) not null
       ,objtype       char(2) not null
       ,is_active     char(1) default 'Y'
       ,created_by    int default null
       ,created_date  timestamp default current_timestamp
       ,last_upd_by   int default null
       ,last_upd_date timestamp default current_timestamp
       ,constraint pk_apps_module_auth_ref_00 primary key (module_id, auth_name)
   );

/*--------------------------------------------------------
--  ddl for table apps_role_module_flds_ref
--------------------------------------------------------*/

  create table apps_role_module_flds_ref
   (	
        role_id       int not null
       ,module_id     int not null
       ,field_name    varchar(50) not null
       ,value         char(2) not null
       ,created_by    int default null
       ,created_date  timestamp default current_timestamp
       ,last_upd_by   int default null
       ,last_upd_date timestamp default current_timestamp
       ,is_active     char(1) default 'Y'
       ,constraint pk_apps_role_module_flds00 primary key (role_id, module_id, field_name)
   );


/*--------------------------------------------------------
--  ddl for table apps_role_module_auth_ref
--------------------------------------------------------
--  drop table apps_role_module_auth_ref*/
  create table apps_role_module_auth_ref
   (	
        role_id       int not null
       ,module_id     int not null
       ,auth_name     varchar(50) not null
       ,value         varchar(20) not null
       ,is_active     char(1) default 'Y'
       ,created_by    int default null
       ,created_date  timestamp default current_timestamp
       ,last_upd_by   int default null
       ,last_upd_date timestamp default current_timestamp
--       ,constraint pk_apps_role_module_auth_ref00 primary key (role_id,module_id, auth_name)
       ,constraint fk_apps_role_module_auth_ref00 foreign key (role_id) references apps_role_ref (role_id)
   );

insert into apps_role_ref (
                            role_id
                           ,role_name
                           ,role_description
                           ,is_active
                           ,is_admin
                           ,created_by
                          )
        values(0,'apps_all','Application Root Administrator','Y','Y',1);

/* make sure role_id is 0*/
update apps_role_ref set role_id = 0 where role_name='apps_all';
alter table apps_role_ref auto_increment=0;
		
insert into apps_role_ref (
                            role_id
                           ,role_name
                           ,role_description
                           ,is_active
                           ,is_admin
                           ,created_by
                          )
        values(1,'admin','Admin','Y','Y',1);
insert into apps_user_role_ref (
                                  uuid
                                 ,role_id
                                 ,is_active
                                 ,created_by
                                )
        values(1,0,'Y',1);

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
    1,'Tools',null,1,100,null,null,null,null,'Y','Y',1
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
    2,'Menu Maintenance',1,2,1,'frmmenu','menu','/tools/','Y','Y',1
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
    3,'Role Maintenance',1,2,2,'frmrole','roles','/tools/','Y','Y',1
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
    4,'User Maintenance',1,2,3,'frmusermaster','usermanagement','/tools/','Y','Y',1
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
    5,'Application Query',1,2,4,'frmquery','query','/tools/','Y','Y',1
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
    6,'Application Information',1,2,5,'frmappinfo','appinfo','/tools/','Y','Y',1
  );

insert into apps_role_module_ref
  (
     role_id
	,module_id
	,is_active
	,created_by
  )
values (1,2,'Y',1);

insert into apps_role_module_ref
  (
     role_id
	,module_id
	,is_active
	,created_by
  )
values (1,3,'Y',1);

insert into apps_role_module_ref
  (
     role_id
	,module_id
	,is_active
	,created_by
  )
values (1,4,'Y',1);

insert into apps_role_module_ref
  (
     role_id
    ,module_id
	,is_active
	,created_by
	,created_date
  )
values (1,5,'Y',0,current_date( ));

insert into apps_role_module_ref
  (
     role_id
	,module_id
	,is_active
	,created_by
  )
values (1,6,'Y',1);

insert into apps_role_ref (
                            role_id
                           ,role_name
                           ,role_description
                           ,is_active
                           ,is_admin
                           ,created_by
                          )
        values(2,'User Admin','User Administrator','Y','y',1);



/*
alter table apps_module_ref modify column module_id int not null auto_increment;
*/
alter table apps_module_ref auto_increment=100;
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


/*--------------------------------------------------------
--  function get_userauth_all
--------------------------------------------------------*/
delimiter //
drop procedure if exists get_userauth_all //
create procedure 
  get_userauth_all( pi_uuid int )
begin
  select distinct b2.autohrztn, b2.role_id, l2.module_id, l2.module_name, l2.parent_id, l2.menu_level, l2.page_name, l2.folder_path, l2.sort_order 
  from apps_module_ref as l2
  inner join (
    select role_id, l.module_id, l.parent_id, b1.module_id as o_module, b1.parent_id as o_parent, b1.autohrztn from apps_module_ref as l
    inner join (
      select role_id, l0.module_id, parent_id, autohrztn from apps_module_ref l0
      inner join (
        select role_id, module_id, autohrztn from apps_role_module_ref where role_id in (
        select role_id from apps_user_role_ref where uuid = pi_uuid and is_active = 'Y'
        ) 
      ) x on x.module_id = l0.module_id
    ) b1 on b1.module_id = l.module_id or b1.parent_id = l.module_id
  ) b2 on b2.module_id = l2.module_id or b2.parent_id = l2.module_id
  order by parent_id,sort_order,module_name	
  ;
end 
//
delimiter ;

/*--------------------------------------------------------
--  function get_user_module_auth
--------------------------------------------------------*/
delimiter //
drop procedure if exists get_user_module_auth //
create procedure 
  get_user_module_auth( pv_uuid int, pv_pagename varchar(50))
begin
  select distinct b2.autohrztn, b2.role_id, l2.module_id, l2.module_name, l2.parent_id, l2.menu_level, l2.page_name, l2.folder_path, l2.sort_order 
  from apps_module_ref as l2
  inner join (
    select role_id, l.module_id, l.parent_id, b1.module_id as o_module, b1.parent_id as o_parent, b1.autohrztn from apps_module_ref as l
    inner join (
      select role_id, l0.module_id, parent_id, autohrztn from apps_module_ref l0
      inner join (
        select role_id, module_id, autohrztn from apps_role_module_ref where role_id in (
        select role_id from apps_user_role_ref where uuid = pv_uuid and is_active = 'Y'
        ) 
      ) x on x.module_id = l0.module_id
    ) b1 on b1.module_id = l.module_id or b1.parent_id = l.module_id
  ) b2 on b2.module_id = l2.module_id or b2.parent_id = l2.module_id
  where l2.page_name = pv_pagename
  order by parent_id,sort_order,module_name	
  ;
end 
//
delimiter ;



/* menu data */
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (100, 'N','Supply Chain Management',null, 1, 1);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (127, 'N','Stock Management',100, 2, 1);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (101, 'N','Purchase Management',100, 2, 2);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (102, 'N','Inventory And Warehouse Management',100, 2, 3);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (103, 'N','Sales To Delivery Management',100, 2, 4);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (104, 'N','Credit And Collection Management',100, 2, 5);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (105, 'N','Asset Management',100, 2, 6);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (106, 'N','Financial Reports',100, 2, 7);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (107, 'N','Analytics And Reporting',100, 2, 8);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (108, 'N','User Control',100, 2, 9);

insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (128, 'N','Product & Item Center',127, 3, 1);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order, page_name, folder_path) values (129, 'N','Product Category',128, 4, 1,'stk_pni_prod_cat','/');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order, page_name, folder_path) values (130, 'N','Trade Stock',128, 4, 2,'stk_pni_trade','/');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order, page_name, folder_path) values (131, 'N','Non-Trade Stock',128, 4, 3,'stk_pni_non_trade','/');

insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (109, 'N','Purchase Requisition',101, 3, 1);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (110, 'N','Purchase Order',101, 3, 2);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (111, 'N','Supplier And Vendor Center',101, 3, 3);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (112, 'N','Inventory Receipt',102, 3, 1);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (113, 'N','Inventory Transfer',102, 3, 2);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (114, 'N','Warehouse And Pallet Assignment',102, 3, 3);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (115, 'N','Inventory Revaluation',102, 3, 4);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (116, 'N','Inventory Reports',102, 3, 5);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (117, 'N','Product (Stock) Center',102, 3, 6);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (118, 'N','Warehouse Center',102, 3, 7);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (119, 'N','Sales Order',103, 3, 1);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (120, 'N','Sales Invoice',103, 3, 2);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (121, 'N','Delivery Receipt',103, 3, 3);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (122, 'N','Dispatch Management',103, 3, 4);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (123, 'N','Courier Center',103, 3, 5);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (124, 'N','Customer Center',103, 3, 6);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (125, 'N','Deals And Discount Center',103, 3, 7);
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order) values (126, 'N','SO Rules And Requirements',103, 3, 8);

insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order, page_name, folder_path) values (140, 'N','Role Master',108, 3, 1,'roles','/tools/');
insert into apps_module_ref (module_id, is_admin, module_name, parent_id, menu_level, sort_order, page_name, folder_path) values (141, 'N','User Master',108, 3, 2,'usermanagement','/tools/');


insert into apps_role_module_ref
  (
    role_id
   ,module_id
	 ,is_active
	 ,created_by
  )
values (2,140,'y',1);

insert into apps_role_module_ref
  (
    role_id
   ,module_id
	 ,is_active
	 ,created_by
  )
values (2,141,'y',1);


insert into apps_role_module_ref
  (
    role_id
   ,module_id
	 ,is_active
	 ,created_by
  )
values (2,129,'y',1);

insert into apps_user_role_ref (
  uuid
 ,role_id
 ,is_active
 ,created_by
)
values(2,2,'y',1);
