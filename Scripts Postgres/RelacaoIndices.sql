/***************************************************************
Retorno: Relação de Índices no PostgreSQL
Descrição: Este script retorna uma lista detalhada de índices em todas as tabelas do banco de
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
  - Inclui o tamanho do índice, se é único, e estatísticas de uso.
  - Filtra esquemas do sistema para focar apenas em dados do usuário.
  - Ordena a saída por nome do banco de dados e esquema.
  - Requer permissões adequadas para acessar as tabelas do sistema.
***************************************************************/

SELECT
      current_database()                             AS datname,
      t.schemaname,
      t.tablename,
      psai.indexrelname                              AS index_name,
      pg_relation_size(i.indexrelid)                 AS index_size,
      CASE WHEN i.indisunique THEN 1 ELSE 0 END      AS "unique",
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