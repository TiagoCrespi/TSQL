/***************************************************************
Retorno: Cadeia de Locks no ambiente
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Testado no SQL Server 2012, 2014, 2016, 2017, 2019 e 2022
    Comando retorna a cadeia de locks ocorrendo no banco de dados.
    O resultado é a nível da instancia, sendo assim, não é necessário indicar o database
***************************************************************/
/* Configurações iniciais */
drop table if exists #Temp_Table

SELECT SPID,BLOCKED, REPLACE (REPLACE (T.TEXT, CHAR(10), ' '), CHAR (13), ' ' ) AS BATCH
INTO #Temp_Table
FROM
    sys.sysprocesses R
    CROSS APPLY sys.dm_exec_sql_text(R.SQL_HANDLE) T
GO

WITH BLOCKERS (SPID, BLOCKED, LEVEL, BATCH)
AS
(
SELECT SPID, BLOCKED, CAST (REPLICATE ('0', 4-LEN (CAST (SPID AS VARCHAR))) + CAST (SPID AS VARCHAR) AS VARCHAR (1000)) AS LEVEL, BATCH
FROM
    #Temp_Table R
WHERE
    (BLOCKED = 0 OR BLOCKED = SPID)
AND     EXISTS (SELECT * FROM #Temp_Table R2 WHERE R2.BLOCKED = R.SPID AND R2.BLOCKED <> R2.SPID)
UNION ALL
SELECT R.SPID, R.BLOCKED, CAST (BLOCKERS.LEVEL + RIGHT (CAST ((1000 + R.SPID) AS VARCHAR (100)), 4) AS VARCHAR (1000)) AS LEVEL, R.BATCH
FROM
    #Temp_Table AS R
    INNER JOIN BLOCKERS ON R.BLOCKED = BLOCKERS.SPID
WHERE
    R.BLOCKED > 0
    AND R.BLOCKED <> R.SPID
)
SELECT  N' ' + REPLICATE (N'| ', LEN (LEVEL)/4 - 1) +
CASE WHEN (LEN(LEVEL)/4 - 1) = 0
THEN 'HEAD - '
ELSE '|----- ' END
+ CAST (SPID AS NVARCHAR (10)) + N' ' + BATCH AS BLOCKING_TREE
FROM
    BLOCKERS
ORDER BY LEVEL ASC
GO