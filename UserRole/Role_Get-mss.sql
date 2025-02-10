SELECT a.is_admin AS isadm 
       ,CASE a.is_admin  WHEN 'Y' THEN 0 ELSE 1 END AS isedt 
       ,CASE a.is_admin  WHEN 'Y' THEN 0 ELSE 1 END AS isdel 
       ,a.role_id 
       ,ISNULL(a.role_name,' ')        AS role_name 
        ,ISNULL(a.role_description,' ') AS role_description 
       ,ISNULL(b.role_name,' ')        AS parent_role 
       ,ISNULL(STRING_AGG(c.module_name, ','),' ')       AS modules 
  FROM apps_role_ref a 
  LEFT JOIN apps_role_ref b 
  ON a.parent_id  = b.role_id 
   AND a.is_active = 'Y' 
  LEFT OUTER JOIN 
    (SELECT rm.role_id 
           ,m.module_name 
           ,rm.is_active 
    FROM apps_role_module_ref rm 
    inner join apps_module_ref m 
    ON m.module_id     = rm.module_id 
    WHERE rm.is_active = 'Y' 
    ) c ON c.role_id   = a.role_id 
  WHERE a.is_active    = 'Y' 
  GROUP BY a.is_admin 
          ,a.role_id 
          ,a.role_name 
          ,a.role_description 
          ,b.role_name 
  ORDER BY a.role_name 
