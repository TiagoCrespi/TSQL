/***************************************************************
Retorno: Retorna o tamanho das tabelas e índices em um banco de dados PostgreSQL.
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações:
- Exclui os esquemas do sistema (pg_catalog e information_schema).
- Ordena o resultado pelo nome do esquema e da tabela.
- Utiliza funções do PostgreSQL para obter o tamanho das tabelas e índices.
- Inclui informações sobre o número de linhas, tamanho da tabela, nome do índice, tamanho do índice, se o índice é único, número de varreduras, tuplas lidas e tuplas buscadas.
***************************************************************/

SELECT
    t.schemaname,
    t.tablename,
    c.reltuples::bigint                            AS num_rows,
    pg_size_pretty(pg_relation_size(c.oid))        AS table_size,
    psai.indexrelname                              AS index_name,
    pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
    CASE WHEN i.indisunique THEN 'Y' ELSE 'N' END  AS "unique",
    psai.idx_scan                                  AS number_of_scans,
    psai.idx_tup_read                              AS tuples_read,
    psai.idx_tup_fetch                             AS tuples_fetched
FROM
    pg_tables t
    LEFT JOIN pg_class c ON t.tablename = c.relname
    LEFT JOIN pg_index i ON c.oid = i.indrelid
    LEFT JOIN pg_stat_all_indexes psai ON i.indexrelid = psai.indexrelid
WHERE
    t.schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY 1, 2;

