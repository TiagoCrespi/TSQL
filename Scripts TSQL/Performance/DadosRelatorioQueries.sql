/***********************************************************************
*  Script Name: DadosRelatorioQueries.sql
*  Objetivo: Retorna dados para relatorio de queries no SQL Server
*  Autor: Tiago Crespi
*  Data: 06/2024
*  Version: 1.0
***********************************************************************/


SELECT top 100
	db_name(qt.dbid) AS [Database],       
	CAST(total_elapsed_time / 1000000.0 AS DECIMAL(28, 2)) AS [Total Duration (s)],
	qs.total_dop as [Grau paralelismo],
	cast((total_worker_time * 100.0 / total_elapsed_time)/qs.total_dop AS DECIMAL(28, 2)) AS [% CPU],
	CAST((total_elapsed_time - total_worker_time)* 100.0 / total_elapsed_time AS DECIMAL(28, 2)) AS [% Waiting],
	execution_count as [Count Executions],
	CAST(total_elapsed_time / 1000000.0 / execution_count AS DECIMAL(28, 2)) AS [Average Duration (s)],
	SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
	((CASE WHEN qs.statement_end_offset = -1
			THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
			ELSE qs.statement_end_offset
	END - qs.statement_start_offset)/2) + 1) AS [Individual Query],
	SUBSTRING(qt.text,1,100) AS [Parent Query], 
	qp.query_plan AS [Query Plan]
FROM sys.dm_exec_query_stats qs
	CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
	CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
WHERE total_elapsed_time > 0
ORDER BY [% CPU] asc