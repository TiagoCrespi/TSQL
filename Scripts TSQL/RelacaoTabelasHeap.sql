/***************************************************************
retorna as tabelas HEAP do banco de dados atual
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs.: Tabelas HEAP são aquelas que não possuem índice clusterizado
    Trocar o nome da tabela na instrução ALTER TABLE
***************************************************************/


SELECT SCH.name + '.' + TBL.name AS TableName
FROM sys.tables AS TBL 
	INNER JOIN sys.schemas AS SCH ON TBL.schema_id = SCH.schema_id 
	INNER JOIN sys.indexes AS IDX ON TBL.object_id = IDX.object_id AND IDX.type = 0 
ORDER BY TableName

/* Para reconstruir uma tabela HEAP */

ALTER TABLE PartitionTable1 REBUILD PARTITION = ALL WITH (ONLINE = <Alterar>)