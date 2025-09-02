/***************************************************************
Retorno: Tamanho das 10 maiores tabelas do banco de dados PostgreSQL
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Necessário ter permissão de leitura nas tabelas do banco de dados
***************************************************************/

SELECT
t.tablename,
pg_size_pretty(pg_total_relation_size('"' || t.schemaname || '"."' || t.tablename || '"')) AS table_total_disc_size
FROM pg_tables t
WHERE
t.schemaname = 'public'
ORDER BY
pg_total_relation_size('"' || t.schemaname || '"."' || t.tablename || '"') DESC
LIMIT 10;