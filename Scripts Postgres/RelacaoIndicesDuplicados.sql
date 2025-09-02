/***************************************************************
Retorno: Relação de Índices Duplicados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Identifica índices duplicados no banco de dados PostgreSQL, exibindo o tamanho total ocupado por esses índices e os nomes dos índices duplicados.
***************************************************************/

SELECT pg_size_pretty(sum(pg_relation_size(idx))::bigint) as size,
       (array_agg(idx))[1] as idx1, (array_agg(idx))[2] as idx2,
       (array_agg(idx))[3] as idx3, (array_agg(idx))[4] as idx4
FROM (
    SELECT indexrelid::regclass as idx, (indrelid::text ||E'\n'|| indclass::text ||E'\n'|| indkey::text ||E'\n'||
                                         coalesce(indexprs::text,'')||E'\n' || coalesce(indpred::text,'')) as key
    FROM pg_index) sub
GROUP BY key HAVING count(*)>1
ORDER BY sum(pg_relation_size(idx)) DESC;

