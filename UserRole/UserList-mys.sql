SELECT
  u.UUID,
  u.FULLNAME,
  IFNULL(mf.module_name, 'Home') AS DEFMOD,
  IFNULL(ra.USER_ROLES, ' ') AS USER_ROLES
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
	  SELECT b.UUID, GROUP_CONCAT(distinct a.ROLE_NAME) as USER_ROLES
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
  mf.module_name
ORDER BY
  u.FULLNAME
  ;