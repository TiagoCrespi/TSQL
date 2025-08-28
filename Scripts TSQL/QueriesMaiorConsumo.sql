/***************************************************************
Retorna as queries com maior consumo de CPU e I/O no SQL Server
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0    
***************************************************************/


 SELECT
    db_name(cast(pa.value AS int)) AS [Database],        CAST(total_elapsed_time / 1000000.0 AS DECIMAL(28, 2)) AS [Total Duration (s)],
    CAST(total_worker_time * 100.0 / total_elapsed_time AS DECIMAL(28, 2)) AS [% CPU],
    CAST((total_elapsed_time - total_worker_time)* 100.0 / total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting],
    execution_count,
    CAST(total_elapsed_time / 1000000.0 / execution_count AS DECIMAL(28, 2)) AS [Average Duration (s)],
    SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
    ((CASE WHEN qs.statement_end_offset = -1
         THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
         ELSE qs.statement_end_offset
    END - qs.statement_start_offset)/2) + 1) AS [Individual Query],
    SUBSTRING(qt.text,1,100) AS [Parent Query]
FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
    CROSS APPLY sys.dm_exec_plan_attributes(qs.plan_handle) AS pa
WHERE total_elapsed_time > 0
    AND pa.attribute = 'dbid'
    ORDER BY total_elapsed_time DESC