drop type t_auth_dets;
--------------------------------------------------------
--  Function get_userauth_all
--------------------------------------------------------
-- Type auth_dets
create or replace type auth_dets as object (
      autohrztn     char(5)
     ,role_id       number
     ,module_id     number
     ,module_name   VARCHAR(50)
     ,parent_id     number
     ,menu_level    VARCHAR(50)
	   ,PAGE_NAME     VARCHAR(50)
	   ,FOLDER_PATH   VARCHAR(50) 
     ,sort_order    NUMBER(3,0)
);
/

-- Table type auth_dets
create or replace type t_auth_dets as table of auth_dets;
/

-- Function get_userauth_all
create or replace Function get_userauth_all
  ( pi_uuid IN NUMBER )
    return t_auth_dets
is
    return_value t_auth_dets;
BEGIN
  SELECT auth_dets(
					 autohrztn
					,role_id
					,module_id
					,module_name
					,parent_id
					,menu_level
					,PAGE_NAME  
					,FOLDER_PATH
					,sort_order
  )
  bulk collect into return_value
  from (
    select 
      distinct b2.autohrztn, b2.role_id, l2.module_id, l2.module_name, l2.parent_id, l2.menu_level, l2.page_name, l2.folder_path, l2.sort_order 
    from apps_module_ref l2
    inner join (
      select role_id, l.module_id, l.parent_id, b1.module_id as o_module, b1.parent_id as o_parent, b1.autohrztn from apps_module_ref l
      inner join (
        select role_id, l0.module_id, parent_id, autohrztn from apps_module_ref l0
        inner join (
          select role_id, module_id, autohrztn from apps_role_module_ref where role_id in (
          select role_id from apps_user_role_ref where uuid = pi_uuid and is_active = 'Y'
          ) 
        ) x on x.module_id = l0.module_id
      ) b1 on b1.module_id = l.module_id or b1.parent_id = l.module_id
    ) b2 on b2.module_id = l2.module_id or b2.parent_id = l2.module_id
    --order by parent_id,sort_order,module_name	
  );
  return return_value;
END;
/

/*--------------------------------------------------------
--  function get_user_module_auth
--------------------------------------------------------*/
create or replace Function get_user_module_auth
  ( pv_uuid IN NUMBER
   ,pv_pagename IN varchar2
  )
    return t_auth_dets
is
    return_value t_auth_dets;
BEGIN
  SELECT auth_dets(
					 autohrztn
					,role_id
					,module_id
					,module_name
					,parent_id
					,menu_level
					,PAGE_NAME  
					,FOLDER_PATH
					,sort_order
  )
  bulk collect into return_value
  from (
    select distinct b2.autohrztn, b2.role_id, l2.module_id, l2.module_name, l2.parent_id, l2.menu_level, l2.page_name, l2.folder_path, l2.sort_order 
    from apps_module_ref l2
    inner join (
      select role_id, l.module_id, l.parent_id, b1.module_id as o_module, b1.parent_id as o_parent, b1.autohrztn from apps_module_ref l
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
    --order by parent_id,sort_order,module_name	
  );
  return return_value;
END;
/

/*--------------------------------------------------------
--  function get_auth_by_user
--------------------------------------------------------*/
create or replace Function get_auth_by_user( pv_modid numeric, pv_uname varchar2)
    return t_auth_dets
is
    return_value t_auth_dets;
BEGIN
  SELECT auth_dets(
					 autohrztn
					,role_id
					,module_id
					,module_name
					,parent_id
					,menu_level
					,PAGE_NAME  
					,FOLDER_PATH
					,sort_order
  )
  bulk collect into return_value
  from (
    select distinct b2.autohrztn, b2.role_id, l2.module_id, l2.module_name, l2.parent_id, l2.menu_level, l2.page_name, l2.folder_path, l2.sort_order 
    from apps_module_ref l2
    inner join (
      select role_id, l.module_id, l.parent_id, b1.module_id as o_module, b1.parent_id as o_parent, b1.autohrztn from apps_module_ref l
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
  );
  return return_value;
END;
/

show errors;
exit;