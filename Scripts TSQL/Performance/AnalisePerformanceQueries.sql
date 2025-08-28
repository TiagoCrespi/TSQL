/***********************************************************************
* Objetivo: Analise de performance de queries no SQL Server
* Autor: Tiago Crespi
* Data: 06/2024
* Version: 1.0
***********************************************************************/

select top 100
db_name(qt.dbid) AS [Database],
qs.creation_time as [Compilacao plano],
qs.last_execution_time as [Execucao],
qs.execution_count as [Qtd Execucao],
qs.last_worker_time as [Tempo CPU],
qs.last_physical_reads as [Leituras Fisicas],
qs.last_logical_writes as [Gravacoes Logicas],
qs.last_logical_reads as [Leituras Logicas],
qs.last_elapsed_time as [Tempo Execucao],
qs.last_rows as [Linhas Retornadas],
qs.last_dop as [Grau paralelismo],
qs.last_used_grant_kb as [Mem. Usada],
qs.last_ideal_grant_kb as [Mem. Ideal],
qp.query_plan AS [Query Plan],
SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
((CASE WHEN qs.statement_end_offset = -1
THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
ELSE qs.statement_end_offset
END - qs.statement_start_offset)/2) + 1) AS [Individual Query]
FROM sys.dm_exec_query_stats as qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
WHERE total_elapsed_time > 0
ORDER BY total_elapsed_time DESC
