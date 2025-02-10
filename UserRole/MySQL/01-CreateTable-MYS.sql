/* mysql version 1.1 */
/* \. E:\$_Codes\SkelProject\db\dbScript-mysql.sql */
\! echo Starting Script...

/* 1st 3 tables will be skipped if with other authentication mode */
\! echo 1st 3 tables will be skipped if with other authentication mode
\! echo User Refernce Table 01-apps_user_ref
/* --------------------------------------------------------
--  ddl for table apps_user_ref
-------------------------------------------------------- */
  create table apps_user_ref
   (	
      uuid          int auto_increment not null
     ,fullname      varchar(200)
     ,defmod        int default 0 not null 
     ,is_active     char(1) default 'Y'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int
     ,last_upd_date date 
     ,constraint pk_apps_ref_users_pk00 primary key (uuid)
   );


\! echo User Mapper 02-apps_user_mapper
/* --------------------------------------------------------
--  ddl for table apps_user_mapper
-- Contains user password for DB Base login
-------------------------------------------------------- */
create table apps_user_mapper(
      uuid          int not null
     ,username      varchar(50) not null
     ,password      nvarchar(100) not null
     ,saltkey       nvarchar(50) default ''
     ,is_active     char(1) default 'Y'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int
     ,last_upd_date date 
     ,constraint pk_apps_user_mapper primary key (uuid)
     ,constraint fk_apps_user_mapper foreign key (uuid)       references apps_user_ref (uuid)
); 

\! echo Personnel Master Table 03-apps_personnel_mstr
create table apps_personnel_mstr(
      uuid          int not null
     ,email         varchar(50)
     ,lastname      varchar(50)
     ,firstname     varchar(50)
     ,contactno     varchar(50)
     ,is_active     char(1) default 'Y'
     ,created_by    int default null
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int
     ,last_upd_date date 
     ,constraint pk_apps_personnel_mstr primary key (uuid)
     ,constraint fk_apps_personnel_mstr foreign key (uuid)       references apps_user_ref (uuid)
);
\! echo User Master Table
/* This is not on MS SQL */
create table users ( 
       id                     bigint unsigned auto_increment not null 
      ,name                   varchar(255)    not null 
      ,email                  varchar(255)    UNIQUE not null 
      ,avatar                 varchar(255)    default 'default.png' not null 
      ,email_verified_at      timestamp       
      ,password               varchar(255)    
      ,remember_token         varchar(100)    
      ,created_at             timestamp       default current_timestamp
      ,updated_at             timestamp       
      ,google_id              varchar(255)    
      ,defmod                 int
      ,is_active              char(1)         default 'Y'
      ,chngpass               char(1)         default 'Y'
      ,created_by             int             
      ,last_upd_by            int             
     ,constraint pk_users00 primary key (id)
);

\! echo Role Master Table 04-apps_role_ref
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


\! echo User Role Master Table 05-apps_user_role_ref
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

\! echo Module Master Table 06.0-apps_top_menu
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


\! echo Module Master Table 06.1-apps_module_ref
/*--------------------------------------------------------
--  ddl for table apps_module_ref
--------------------------------------------------------*/
  create table apps_module_ref
   (	module_id     int auto_increment not null
	   ,module_name   varchar(50)
     ,m_prnt_id     int                      /* 2025 for categorized menu*/
     ,tran_code     varchar(100) default ''  /* 2025 for short cut code */
	   ,parent_id     int
	   ,menu_level    int not null
	   ,sort_order    int
	   ,form_name     varchar(50) default ''
	   ,page_name     varchar(50) default ''
	   ,folder_path   varchar(50) default ''
	   ,type          varchar(05)              /* needed by function ?*/
     ,is_parent     char(1)     default 'N'
	   ,code          varchar(10) default ''   /* Authorization code */
	   ,is_active     char(1)     default 'Y'
     ,is_admin      char(1)     default 'N'
     ,created_by    int         default 0
     ,created_date  timestamp default current_timestamp
     ,last_upd_by   int default null
     ,last_upd_date timestamp default current_timestamp
     ,constraint pk_apps_ref_module00 primary key (module_id)
     ,CONSTRAINT FK_APPS_REF_MODULE01 FOREIGN KEY (CREATED_BY) REFERENCES APPS_USER_REF (UUID)
     ,constraint fk_apps_top_menu01   foreign key (m_prnt_id)  references apps_top_menu (m_prnt_id)
   );


\! echo 07-apps_role_module_ref
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

\! echo 08-apps_audit_hdr_ref
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

\! echo 09-apps_audit_dtl_ref
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

\! echo 10-apps_user_session
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

\! echo 11-apps_user_module_logs
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


\! echo 12-apps_module_flds_ref
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


\! echo 13-apps_module_auth_ref
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

\! echo 14-apps_role_module_flds_ref
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


\! echo 15-apps_role_module_auth_ref
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

