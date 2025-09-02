/***************************************************************
Retorno: Progresso da Reindexação
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações:
- Retorna o progresso da reindexação em andamento no PostgreSQL.
***************************************************************/

SELECT pid,
       datname,
       relid::regclass AS tabela,
       index_relid::regclass AS indice,
       phase,
       blocks_done,
       blocks_total,
       round(100.0 * blocks_done / NULLIF(blocks_total,0), 2) AS progresso
FROM pg_stat_progress_create_index;

/* Exemplo de comandos para reindexação e otimização de uma tabela específica

REINDEX TABLE <table_name>; 
CLUSTER <table_name>; 
Vaccum full  <table_name>;
*/