SELECT
  CASE
    a.IS_ADMIN
    when 'Y' then 'N'
    ELSE 'Y'
  END + 'Y' + CASE
    a.IS_ADMIN
    when 'Y' then 'N'
    ELSE 'Y'
  END AS ACTON,
  a.MODULE_ID,
  a.MODULE_NAME,
  ISNULL(a.PAGE_NAME, ' ') AS PAGE_NAME,
  ISNULL(b.MODULE_NAME, ' ') AS PARENT_MENU,
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
  ISNULL(a.FOLDER_PATH, ' ') AS FOLDER_PATH,
  ISNULL(
    STUFF(
      (
        SELECT
          ',' + d.ROLE_NAME
        FROM
          APPS_ROLE_REF d
          INNER JOIN APPS_ROLE_MODULE_REF e ON d.ROLE_ID = e.ROLE_ID
          AND e.IS_ACTIVE = 'Y'
        WHERE
          e.MODULE_ID = a.MODULE_ID
          AND d.IS_ACTIVE = 'Y' FOR XML PATH('')
      ),
      1,
      1,
      ''
    ),
    ' '
  ) AS ROLES_UNDER,
  ISNULL(wa.module_id, 0) AS SPCL_AUTH,
  ISNULL(fa.module_id, 0) AS FLDS_AUTH
FROM
  APPS_MODULE_REF a
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
  ISNULL(wa.module_id, 0),
  ISNULL(fa.module_id, 0)
ORDER BY
  a.MENU_LEVEL,
  a.SORT_ORDER,
  a.MODULE_NAME