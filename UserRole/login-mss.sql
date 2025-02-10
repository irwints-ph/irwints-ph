SELECT
       c.USERNAME as Username
      ,c.PASSWORD as Password
      ,a.FULLNAME as FullName
      ,CAST(a.UUID as INT) as uuid
  FROM apps_user_ref a
  LEFT JOIN apps_module_ref b 
    ON b.module_id = a.defmod
   AND b.is_active = 'Y'
  LEFT JOIN APPS_USER_MAPPER c ON c.UUID = a.UUID
 WHERE a.is_active = 'Y'
   and LOWER(c.USERNAME) = 'root'
   and c.PASSWORD = '1';