/***********************************************************************
*  Script Name: ListaTabelasPorTamanho.sql  
*  Descrição: Lista as tabelas por tamanho
*  Objetivo: Listar as tabelas por tamanho
*  Autor: Tiago Crespi
*  Data: 06/2024
*  Version: 1.0
*  Obs: Se somarmos o used_mb + indexSize_mb teremos o tamanho total da tabela
***********************************************************************/

select schema_name(tab.schema_id) + '.' + tab.name as [table], 
    cast(sum(spc.used_pages * 8)/1024.00 as numeric(36, 0)) as used_mb,
    cast(sum(spc.total_pages * 8)/1024.00 as numeric(36, 0)) as allocated_mb,
	cast(SUM((partstat.[used_page_count])* 8)/1024 as numeric(36, 0)) AS IndexSize_mb,
	sum(part.rows) as rowsTable
from sys.tables tab
    inner join sys.indexes as ind on tab.object_id = ind.object_id
    inner join sys.partitions as part on ind.object_id = part.object_id and ind.index_id = part.index_id
    inner join sys.allocation_units as spc on part.partition_id = spc.container_id
	inner join sys.dm_db_partition_stats as partstat ON ind.[object_id] = partstat.[object_id]
group by schema_name(tab.schema_id) + '.' + tab.name
order by sum(spc.used_pages) desc


/********* Tamanho das tabelas heaps **********/
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
order by sum(spc.used_pages) desc