/***************************************************************
Retorno: Result set com tabelas heap e comando para rebuild
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Rebuild em tabelas heap
     Deve ser executado em horários de baixa utilização
     Pode ser agendado em job
     Testado no SQL Server 2016, 2017, 2019 e 2022
     Rebuild online requer Enterprise Edition ou superior
***************************************************************/



with heaps as (
select schema_name(tab.schema_id) + '.' + tab.name as [table], 
    cast(sum(spc.used_pages * 8)/1024.00 as numeric(36, 0)) as used_mb,
    cast(sum(spc.total_pages * 8)/1024.00 as numeric(36, 0)) as allocated_mb,
    cast(SUM((partstat.[used_page_count])* 8)/1024 as numeric(36, 0)) AS IndexSize_mb,
    sum(part.rows) as rowsTable
from sys.tables tab
    inner join sys.indexes as ind on tab.object_id = ind.object_id AND ind.type = 0 
    inner join sys.partitions as part on ind.object_id = part.object_id and ind.index_id = part.index_id
    inner join sys.allocation_units as spc on part.partition_id = spc.container_id
    inner join sys.dm_db_partition_stats as partstat ON ind.[object_id] = partstat.[object_id]
group by schema_name(tab.schema_id) + '.' + tab.name
)
select *, (used_mb + indexsize_mb) as total_mb, 
	'ALTER TABLE ' + [table] + ' REBUILD PARTITION = ALL WITH (ONLINE = ON)' as commando 
from heaps
where [table] not like '%bkp%'
	and [table] not like '%teste%'
	and [rowstable] > 0
order by used_mb desc
