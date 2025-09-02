/***************************************************************
Retorno: Queries de processos em execução no Postgres
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Lista os processos em execução no Postgres
***************************************************************/
select 
       pid, 
       usename, 
       pg_blocking_pids(pid) as blocked_by, 
       query as blocked_query
from pg_stat_activity
---where cardinality(pg_blocking_pids(pid)) > 0;
where usename = 'tiagocrespi'


/* Processos em Execução */
SELECT pid,backend_xid,wait_event_type,wait_event,state,query FROM pg_stat_activity

/* Processos em Idle */
select * from pg_stat_activity where state != 'idle'

