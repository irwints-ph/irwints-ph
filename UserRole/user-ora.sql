-- For C:\$_Codes\_Candiate\03-api-token-base-session\DBAccess\Data\AppCore\Users.cs
-- Function: GetUserList()
SELECT
  CONCAT(
    CONCAT(
      CASE
        u.UUID
        when 0 then 'N'
        ELSE 'Y'
      END,
      'Y'
    ),
CASE
      u.UUID
      when 0 then 'N'
      ELSE 'Y'
    END
  ) AS ACTON,
  u.UUID,
  u.FULLNAME,
  NVL(mf.module_name, 'Home') AS DEFMOD,
  NVL(ra.USER_ROLES, ' ') AS USER_ROLES
FROM
  APPS_USER_REF u
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
  LEFT JOIN(
    SELECT
      b.UUID,
      LISTAGG(a.ROLE_NAME, ',') within group (
        order by
          ROLE_NAME
      ) as USER_ROLES
    FROM
      APPS_ROLE_REF a
      INNER JOIN APPS_USER_ROLE_REF b ON a.ROLE_ID = b.ROLE_ID
      AND b.IS_ACTIVE = 'Y'
    WHERE
      a.IS_ACTIVE = 'Y'
    GROUP BY
      b.UUID
  ) ra ON ra.uuid = u.uuid
WHERE
  u.IS_ACTIVE = 'Y'
GROUP BY
  u.UUID,
  u.FULLNAME,
  mf.module_name,
  ra.USER_ROLES
ORDER BY
  u.UUID,
  u.FULLNAME;
