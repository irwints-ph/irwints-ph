-- for: 
SELECT 
  CONCAT(
    CONCAT(
	  CASE
	    a.IS_ADMIN
	    WHEN 'Y' then 'N'
	    ELSE 'Y'
	  END
	  ,'Y'
	)
  ,CASE
    a.IS_ADMIN
    WHEN 'Y' then 'N'
    ELSE 'Y'
  END
  ) AS ACTON,
  a.MODULE_ID,
  a.MODULE_NAME,
  NVL(a.PAGE_NAME, ' ') AS PAGE_NAME,
  NVL(b.MODULE_NAME, ' ') AS PARENT_MENU,
  (
    CASE
      a.MENU_LEVEL
      WHEN 1 THEN 'Level 1'
      WHEN 2 THEN 'Level 2'
      WHEN 3 THEN 'Level 3'
      ELSE 'unkown'
    END
  ) AS MENU_LEVEL,
  a.SORT_ORDER,
  NVL(a.FOLDER_PATH, ' ') AS FOLDER_PATH,
  NVL(ra.ROLES_UNDER, ' ') as ROLES_UNDER,
  NVL(wa.module_id, 0) AS SPCL_AUTH,
  NVL(fa.module_id, 0) AS FLDS_AUTH
FROM  APPS_MODULE_REF a
  LEFT JOIN APPS_MODULE_REF b ON a.PARENT_ID = b.MODULE_ID
  LEFT JOIN APPS_ROLE_MODULE_REF c ON a.MODULE_ID = c.MODULE_ID
  AND c.IS_ACTIVE = 'Y'
  LEFT JOIN APPS_ROLE_REF ON c.ROLE_ID = APPS_ROLE_REF.ROLE_ID
  AND APPS_ROLE_REF.IS_ACTIVE = 'Y'
  LEFT JOIN (
    SELECT
      module_id,
      COUNT(module_id) AS cnt
    FROM
      APPS_MODULE_AUTH_REF
    WHERE
      IS_ACTIVE = 'Y'
    GROUP BY
      module_id
  ) wa ON wa.module_id = a.module_id
  LEFT JOIN (
    SELECT
      module_id,
      COUNT(module_id) AS cnt
    FROM
      APPS_MODULE_FLDS_REF
    WHERE
      IS_ACTIVE = 'Y'
    GROUP BY
      module_id
  ) fa ON fa.module_id = a.module_id
  LEFT JOIN (
	  SELECT e.MODULE_ID, LISTAGG(d.ROLE_NAME, ',') within group (order by ROLE_NAME) as ROLES_UNDER
	    FROM APPS_ROLE_REF d
	   INNER JOIN APPS_ROLE_MODULE_REF e 
	      ON d.ROLE_ID = e.ROLE_ID
	     AND e.IS_ACTIVE = 'Y'
	    WHERE d.IS_ACTIVE = 'Y'
	    GROUP BY e.MODULE_ID
  ) ra ON ra.module_id = a.module_id
WHERE
  a.IS_ACTIVE = 'Y'
GROUP BY
  a.IS_ADMIN,
  a.MODULE_ID,
  a.PAGE_NAME,
  a.MODULE_NAME,
  b.MODULE_NAME,
  a.MENU_LEVEL,
  a.SORT_ORDER,
  a.FOLDER_PATH,
  a.FOLDER_PATH,
  NVL(wa.module_id, 0),
  NVL(fa.module_id, 0),
  ra.ROLES_UNDER
ORDER BY
  a.MENU_LEVEL,
  a.SORT_ORDER,
  a.MODULE_NAME
;

-----------------------------------------------
  CONCAT(
    CONCAT(
	  CASE
	    a.IS_ADMIN
	    WHEN 'Y' then 'N'
	    ELSE 'Y'
	  END
	  ,'Y'
	)
  ,CASE
    a.IS_ADMIN
    WHEN 'Y' then 'N'
    ELSE 'Y'
  END
  ) AS ACTON,

     
      SELECT e.MODULE_ID, LISTAGG(d.ROLE_NAME, ',') within group (order by ROLE_NAME) as ROLES_UNDER
        FROM APPS_ROLE_REF d
       INNER JOIN APPS_ROLE_MODULE_REF e 
          ON d.ROLE_ID = e.ROLE_ID
         AND e.IS_ACTIVE = 'Y'
        WHERE d.IS_ACTIVE = 'Y'
        GROUP BY e.MODULE_ID
        ;
