\! echo Starting function get_userauth_all...
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

\! echo Starting function get_user_module_auth...
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

\! echo Starting function get_auth_by_user...
/*--------------------------------------------------------
--  function get_auth_by_user
--------------------------------------------------------*/
delimiter //
drop procedure if exists get_auth_by_user //

CREATE procedure  get_auth_by_user( pv_modid int, pv_uname varchar(50))
begin
  select distinct b2.autohrztn, b2.role_id, l2.module_id, l2.module_name, l2.parent_id, l2.menu_level, l2.page_name, l2.folder_path, l2.sort_order 
  from apps_module_ref as l2
  inner join (
    select role_id, l.module_id, l.parent_id, b1.module_id as o_module, b1.parent_id as o_parent, b1.autohrztn from apps_module_ref as l
    inner join (
      select role_id, l0.module_id, parent_id, autohrztn from apps_module_ref l0
      inner join (
        select role_id, module_id, autohrztn from apps_role_module_ref where role_id in (
        select role_id from apps_user_role_ref where is_active = 'Y' and uuid = ( 
			select uuid from APPS_USER_MAPPER where USERNAME = pv_uname
		  ) 
        ) 
      ) x on x.module_id = l0.module_id
    ) b1 on b1.module_id = l.module_id or b1.parent_id = l.module_id
  ) b2 on b2.module_id = l2.module_id or b2.parent_id = l2.module_id
  where l2.module_id = pv_modid
  ;
end 
//
delimiter ;

/* Application Specific Scripts should be separate */
