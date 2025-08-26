SELECT Us.name AS username, Obj.name AS object, Obj.type, dp.permission_name, dp.state_desc AS permission 
FROM sys.database_permissions dp 
JOIN sys.sysusers Us 
ON dp.grantee_principal_id = Us.uid 
JOIN sys.sysobjects Obj 
ON dp.major_id = Obj.id 
where Us.name not in('guest', 'public')
order by Us.name