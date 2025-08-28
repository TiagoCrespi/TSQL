/***************************************************************
Retorna a data do ultimo acesso ao banco de dados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
***************************************************************/


SELECT name as [Database Name], [Last Access Date] =(select MAX(temp.lastaccess)
from ( select lastaccess =
max(last_user_seek)
where max(last_user_seek)is not null
union all
select lastaccess = max(last_user_scan)
where max(last_user_scan)is not null
union all
select lastaccess = max(last_user_lookup)
where max(last_user_lookup) is not null
union all
select lastaccess =max(last_user_update)
where max(last_user_update) is not null) temp)
FROM master.dbo.sysdatabases sysdb
left outer join sys.dm_db_index_usage_stats Idxus
on sysdb.dbid= Idxus.database_id
group by sysdb.name