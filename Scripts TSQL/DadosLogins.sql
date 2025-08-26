WITH ServerPermsAndRoles
AS (
SELECT spr.name AS principal_name,
spr.type_desc AS principal_type,
spm.permission_name COLLATE SQL_Latin1_General_CP1_CI_AS AS security_entity,
'permission' AS security_type,
spm.state_desc,ß
spr.is_disabled
FROM sys.server_principals spr
INNER JOIN sys.server_permissions spm ON spr.principal_id = spm.grantee_principal_id
WHERE spr.type IN('s', 'u')
UNION ALL
SELECT sp.name AS principal_name,
sp.type_desc AS principal_type,
spr.name AS security_entity,
'role membership' AS security_type,
NULL AS state_desc,
spr.is_disabled
FROM sys.server_principals sp
INNER JOIN sys.server_role_members srm ON sp.principal_id = srm.member_principal_id
INNER JOIN sys.server_principals spr ON srm.role_principal_id = spr.principal_id
WHERE sp.type IN('s', 'u'))
SELECT 
principal_name as[Login], 
principal_type as [Tipo], 
security_entity as [Segurança],
security_type as [Tipo Segurança],
state_desc [Status],
CASE WHEN is_disabled = 0 THEN 'HABILITADO' else 'DESABILITADO' END [Situacao] 
FROM ServerPermsAndRoles
where is_disabled = 0 --FILTRA LOGINS HABILITADOS
ORDER BY principal_name;
