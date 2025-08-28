/************************************************************************
 * Objetivo: Tamanho das tabelas por banco de dados
 * Autor: Tiago Crespi
 * Data: 06/2024
 * Última Modificação: 06/2024
 * Observações: 
 *  - Testado no SQL Server 2012, 2014, 2016, 2017, 2019 e 2022
 ************************************************************************/

select
    a3.name as proprietario,
    a2.name as tabela,
    a1.rows as registros,
    (a1.reserved + isnull(a4.reserved,0)) * 8 as 'Espaço Total (kb)', 
    a1.data * 8 as 'Dados (kb)',
    (case when (a1.used + isnull(a4.used,0)) > a1.data then (a1.used + isnull(a4.used,0)) - a1.data else 0 end) * 8 as 'Índices (kb)',
    (case when (a1.reserved + isnull(a4.reserved,0)) > a1.used then (a1.reserved + isnull(a4.reserved,0)) - a1.used else 0 end) * 8 as 'Não Usado (kb)'
from (
    select
        ps.object_id,
            sum (
                case
                    when (ps.index_id < 2) then row_count
                    else 0
                end
                ) as [rows],
            sum (ps.reserved_page_count) as reserved,
            sum (
                case
                    when (ps.index_id < 2) then (ps.in_row_data_page_count + ps.lob_used_page_count + ps.row_overflow_used_page_count)
                    else (ps.lob_used_page_count + ps.row_overflow_used_page_count)
                end
                ) as data,
            sum (ps.used_page_count) as used
    from sys.dm_db_partition_stats ps
    where ps.object_id not in (select object_id from sys.tables where is_memory_optimized = 1)
    group by ps.object_id) as a1
left outer join (
    select
        it.parent_id,
        sum(ps.reserved_page_count) as reserved,
        sum(ps.used_page_count) as used
     from sys.dm_db_partition_stats ps
     inner join sys.internal_tables it on (it.object_id = ps.object_id)
     where it.internal_type in (202, 204)
     group by it.parent_id) as a4 on (a4.parent_id = a1.object_id)
inner join sys.all_objects a2  on ( a1.object_id = a2.object_id)
inner join sys.schemas a3 on (a2.schema_id = a3.schema_id)
where a2.type <> 's' and a2.type <> 'it'
order by a3.name, a2.name
