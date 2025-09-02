/***************************************************************
Retorno: Retorna o tamanho dos índices não utilizados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Retorna o tamanho dos índices não utilizados
     Índices que não foram utilizados para buscas, varreduras ou pesquisas
***************************************************************/

WITH pagecount AS (
SELECT object_id, index_id ,(sum(used_page_count) * 8) AS IndexSizeKB
FROM sys.dm_db_partition_stats
GROUP BY object_id, index_id
)
SELECT
so.name AS [Table Name],
i.name AS [IndexName],
--p.object_id AS [ObjectID],
--ius.index_id AS [IndexID],
ius.user_scans AS [User Scans],
ius.user_seeks AS [User Seeks],
ius.user_lookups AS [User Lookups],
ius.user_updates AS [Updates],
p.IndexSizeKB AS [IndexSizeKB]
FROM sys.dm_db_index_usage_stats AS ius
INNER JOIN sys.indexes AS i ON i.index_id = ius.index_id AND ius.OBJECT_ID = i.OBJECT_ID
INNER JOIN sys.objects AS so ON ius.OBJECT_ID = so.OBJECT_ID
INNER JOIN pagecount AS p on p.index_id = ius.index_id and ius.OBJECT_ID = p.OBJECT_ID
WHERE i.is_primary_key = 0
AND i. is_unique = 0
AND ius. user_lookups = 0
AND ius.user_seeks = 0
AND ius.user_scans = 0
AND i.name != 'NULL'
ORDER BY
p.IndexSizeKB DESC

