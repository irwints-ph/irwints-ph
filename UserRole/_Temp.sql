SELECT
  module_id
  ,module_name
  ,concat(folder_path, page_name) as selected
FROM
  apps_module_ref
WHERE
  concat(folder_path, page_name) = '/www/tools/roles';