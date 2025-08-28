/***************************************************************
Retorno: Retorna o tamanho dos índices em KB
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Alterar o nome do banco de dados que se quer coletar o tamanho dos índices
***************************************************************/

use <nome_do_banco> --ALTERAR NOME DO BANCO
GO
SELECT tn.[name] AS [Table name], ix.[name] AS [Index name],
SUM(sz.[used_page_count]) * 8 AS [Index size (KB)]
FROM sys.dm_db_partition_stats AS sz
INNER JOIN sys.indexes AS ix ON sz.[object_id] = ix.[object_id] 
AND sz.[index_id] = ix.[index_id]
INNER JOIN sys.tables tn ON tn.OBJECT_ID = ix.object_id
GROUP BY tn.[name], ix.[name]
ORDER BY tn.[name]
