/***************************************************************
Retorno: Uso de CPU do SQL Server
Objetivo: Monitorar o uso de CPU do SQL Server em relação ao sistema operacional
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Necessita de permissão VIEW SERVER STATE
***************************************************************/

DECLARE @ts_now bigint = (SELECT cpu_ticks/(cpu_ticks/ms_ticks)FROM sys.dm_os_sys_info);  
  
SELECT TOP(30)  
DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) AS [Event Time]  ,
SQLProcessUtilization AS [SQL Server Process CPU Utilization],  
               SystemIdle AS [System Idle Process],  
               100 - SystemIdle - SQLProcessUtilization AS [Other Process CPU Utilization]
              
FROM (  
  SELECT record.value('(./Record/@id)[1]', 'int') AS record_id,  
record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int')  
AS [SystemIdle],  
record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]',  
'int')  
AS [SQLProcessUtilization], [timestamp]  
  FROM (  
SELECT [timestamp], CONVERT(xml, record) AS [record]  
FROM sys.dm_os_ring_buffers  
WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'  
AND record LIKE '%<SystemHealth>%') AS x  
  ) AS y  
ORDER BY record_id DESC;



