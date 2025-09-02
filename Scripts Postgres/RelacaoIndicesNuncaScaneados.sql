/***************************************************************
Retorno: Relação de Índices Nunca Scaneados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Identifica índices que nunca foram escaneados no banco de dados PostgreSQL, exibindo o tamanho do índice, o número de leituras da tabela e o número de gravações na tabela.
***************************************************************/

SELECT
    idstat.relname AS TABLE_NAME,
    indexrelname AS index_name,
    idstat.idx_scan AS index_scans_count,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
    tabstat.idx_scan AS table_reads_index_count,
    tabstat.seq_scan AS table_reads_seq_count,
    tabstat.seq_scan + tabstat.idx_scan AS table_reads_count,
    n_tup_upd + n_tup_ins + n_tup_del AS table_writes_count,
    pg_size_pretty(pg_relation_size(idstat.relid)) AS table_size
FROM pg_stat_user_indexes AS idstat
JOIN pg_indexes ON indexrelname = indexname AND idstat.schemaname = pg_indexes.schemaname
JOIN pg_stat_user_tables AS tabstat ON idstat.relid = tabstat.relid
WHERE indexdef !~* 'unique'
ORDER BY
    idstat.idx_scan DESC,
    pg_relation_size(indexrelid) DESC
