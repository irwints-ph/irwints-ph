SELECT a.uuid as uuid 
       ,case a.UUID  when 0 then 0 else 1 end as isedt 
       ,case a.UUID  when 0 then 0 else 1 end as isdel 
       ,a.username 
       ,u.fullname as name 
       ,a.is_active 
       ,n.fullname as created_by 
	  ,TO_CHAR(a.created_date,'MM/DD/YYYY') AS created_date 
  FROM apps_user_mapper a 
 INNER JOIN apps_user_ref u ON a.uuid = u.uuid 
 INNER JOIN apps_user_ref n ON a.created_by = n.uuid 
 WHERE a.is_active = 'Y' 
 ORDER BY UPPER(u.fullname);
 

