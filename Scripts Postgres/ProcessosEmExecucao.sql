/***************************************************************
Retorno: Queries de processos em execução no Postgres
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Lista os processos em execução no Postgres
***************************************************************/
SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state
FROM pg_stat_activity 
--where now() - query_start > interval '5 minute' 
--AND  state != 'idle'


/* Processos em Execução */
SELECT pid,backend_xid,wait_event_type,wait_event,state,query FROM pg_stat_activity

/* Processos em Idle */
select * from pg_stat_activity where state != 'idle'