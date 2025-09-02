/***************************************************************
Retorno: Parâmetros de Performance PostgreSQL
Descrição: Script para retornar os principais parâmetros de performance do PostgreSQL
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Execute este script em um banco de dados PostgreSQL para obter os principais parâmetros de performance configurados no sistema.
***************************************************************/

select name, context, unit, setting, boot_val, reset_val 
from pg_settings 
where name in ('max_connections', 'shared_buffers',  'effective_cache_size', 'maintenance_work_mem', 'checkpoint_completion_target', 'wal_buffers',
                'default_statistics_target', 'random_page_cost', 'effective_io_concurrency', 'work_mem', 'min_wal_size', 'max_wal_size', 
                'max_worker_processes', 'max_parallel_workers_per_gather', 'max_parallel_workers', 'max_parallel_maintenance_workers') 
order by context, name;


SELECT name, setting, category, short_desc, context, pending_restart
FROM pg_catalog.pg_settings
WHERE category IN('Write-Ahead Log / Archive Recovery','Write-Ahead Log / Recovery Target')
OR name IN ('primary_conninfo','primary_slot_name','promote_trigger_file','recovery_min_apply_delay')
ORDER BY category, name;

