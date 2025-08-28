/***************************************************************
Retorno: Retorna queries que demoraram mais de 5 segundos para serem executadas
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Cria uma Extended Event para capturar queries que demoraram mais de 5 segundos
     O arquivo .xel fica salvo em C:\CDB\CDB_QueryLongRun.xel
     Deve ser alterado o caminho do arquivo conforme o ambiente
     A consulta no final do script lê o arquivo .xel e retorna as queries
     Deve ser executado com uma conta que tenha permissão para criar Extended Events
***************************************************************/

/* Cria a Extended Event */
CREATE EVENT SESSION [CDB_QueryLongRun] ON SERVER
ADD EVENT sqlserver.sp_statement_completed(
    ACTION(
			package0.collect_system_time,
		   sqlserver.client_app_name,
           sqlserver.client_hostname,
           sqlserver.database_name,
		   sqlserver.nt_username,
		   sqlserver.session_id,
		   sqlserver.plan_handle,
		   sqlserver.query_hash,
           sqlserver.sql_text
		  )
          where duration > 5000000 --- 5 segundos 
	),
ADD EVENT sqlserver.sql_statement_completed(
	ACTION(
			package0.collect_system_time,
		   sqlserver.client_app_name,
           sqlserver.client_hostname,
           sqlserver.database_name,
		   sqlserver.nt_username,
		   sqlserver.session_id,
		   sqlserver.plan_handle,
		   sqlserver.query_hash,
           sqlserver.sql_text			
	)
	where duration > 5000000  --- 5 segundos
)

ADD TARGET package0.asynchronous_file_target
(SET filename = N'C:\CDB\CDB_QueryLongRun.xel',
     metadatafile = 'C:\CDB\CDB_QueryLongRun.xem',
     max_file_size=(65536),
     max_rollover_files=5)
WITH (MAX_DISPATCH_LATENCY = 5SECONDS)
GO

ALTER EVENT SESSION [CDB_QueryLongRun] ON SERVER
STATE = START;


/* Consulta o arquivo .xel e retorna as queries que demoraram mais de 5 segundos */
WITH events_cte AS (
  SELECT
    xevents.event_data,
    	
    xevents.event_data.value ('(event/@timestamp)[1]', 'datetime') as event_timestamp,
	xevents.event_data.value ('(event/@name)[1]', 'varchar(max)') as event_name,
    xevents.event_data.value ('(event/data[@name="statement"]/value)[1]','varchar(max)') as statement,
	xevents.event_data.value ('(event/data[@name="duration"]/value)[1]','bigint')/1000 as Duration_ms,
	xevents.event_data.value ('(event/data[@name="cpu_time"]/value)[1]','bigint')/1000 as CpuTime_ms,
	xevents.event_data.value ('(event/data[@name="physical_reads"]/value)[1]','bigint') as Physical_reads,
	xevents.event_data.value ('(event/data[@name="logical_reads"]/value)[1]','bigint') as Logical_reads,
	xevents.event_data.value ('(event/data[@name="writes"]/value)[1]','bigint') as Writes,
	xevents.event_data.value ('(event/data[@name="row_count"]/value)[1]','bigint') as Row_count,
	xevents.event_data.value ('(event/action[@name="database_name"]/value)[1]','varchar(100)') as DatabaseName,
	xevents.event_data.value ('(event/action[@name="client_hostname"]/value)[1]','varchar(120)') as HostName,
	xevents.event_data.value ('(event/action[@name="client_app_name"]/value)[1]','varchar(200)') as AppName,
	xevents.event_data.value ('(event/action[@name="nt_username"]/value)[1]','varchar(100)') as NtUser,
	'0x'+xevents.event_data.value ('(event/action[@name="plan_handle"]/value)[1]','varchar(150)') as PlanHandle
    
  FROM    sys.fn_xe_file_target_read_file
    ('C:\RDornel\XE_LongQuery\RDX_QueryLongRun*xel',
     'C:\RDornel\XE_LongQuery\RDX_QueryLongRun*xem',
     null, null)
    CROSS APPLY (SELECT CAST(event_data AS XML) AS event_data) as xevents
)
SELECT	 convert(varchar(10),event_timestamp, 103) as Data, event_name, statement, Duration_ms,CpuTime_ms,Physical_reads,Logical_reads,Writes,Row_count,DatabaseName,
		HostName, AppName, NtUser--, PlanHandle --, (select [query_plan] from sys.dm_exec_query_plan (cast(PlanHandle as varbinary))) as PlanQuery
		into #temp
FROM 
		events_cte a
		---cross apply sys.dm_exec_query_plan (convert(varbinary,a.PlanHandle))
 where event_timestamp > '20210704'


 --select query_plan from sys.dm_exec_query_plan (0x06000800474b6f0b00dccb67b800000001000000000000000000000000000000000000000000000000000000)

