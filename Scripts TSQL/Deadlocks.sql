/***************************************************************
Retorno: Queries que retornam os deadlocks ocorridos no SQL Server
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Retorna os deadlocks ocorridos no SQL Server
***************************************************************/
 
SELECT XEvent.query('(event/data/value/deadlock)[1]') AS DeadlockGraph
FROM
(
  SELECT XEvent.query('.') AS XEvent
  FROM
  (
    SELECT CAST(target_data AS XML) AS TargetData
    FROM sys.dm_xe_session_targets st
      INNER JOIN sys.dm_xe_sessions s
        ON s.address = st.event_session_address
    WHERE s.name = 'system_health'
       AND st.target_name = 'ring_buffer'
  ) AS Data
    CROSS APPLY TargetData.nodes('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData(XEvent)
) AS source;
 