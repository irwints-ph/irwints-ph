-- For C:\$_Codes\_Candiate\03-api-token-base-session\DBAccess\Data\AppCore\Users.cs
SELECT
  CONCAT(
    CONCAT(
	  CASE
	    u.UUID
	    WHEN 0 then 'N'
	    ELSE 'Y'
	  END
	  ,'Y'
	)
  ,CASE
    u.UUID
    WHEN 0 then 'N'
    ELSE 'Y'
  END
  ) AS ACTON,
  u.UUID,
  u.FULLNAME,
  NVL(mf.module_name, 'Home') AS DEFMOD,
  NVL(ra.USER_ROLES, ' ') AS USER_ROLES
FROM APPS_USER_REF u
  LEFT OUTER JOIN (
    SELECT
      ur.uuid,
      ur.role_id,
      r.role_name,
      ur.IS_ACTIVE
    FROM
      APPS_USER_ROLE_REF ur
      INNER JOIN APPS_ROLE_REF r ON r.role_id = ur.role_id
    WHERE
      ur.IS_ACTIVE = 'Y'
  ) c ON c.uuid = u.uuid
  LEFT OUTER JOIN APPS_MODULE_REF mf ON mf.module_id = u.defmod
  LEFT JOIN (
	  SELECT b.UUID, LISTAGG(a.ROLE_NAME, ',') within group (order by ROLE_NAME) as USER_ROLES
      FROM APPS_ROLE_REF a
     INNER JOIN APPS_USER_ROLE_REF b 
        ON a.ROLE_ID = b.ROLE_ID
       AND b.IS_ACTIVE = 'Y'
	    WHERE a.IS_ACTIVE = 'Y'
	    GROUP BY b.UUID
  ) ra ON ra.uuid = u.uuid
WHERE u.IS_ACTIVE = 'Y'
  and u.uuid = '0'
GROUP BY
  u.UUID,
  u.FULLNAME,
  mf.module_name,
  ra.USER_ROLES
ORDER BY
  u.FULLNAME
  ;

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