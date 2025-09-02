/***************************************************************
Retorno: Listar tabelas sem foreign keys
Objetivo: Identificar tabelas que não possuem foreign keys
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observação: Pode ser útil para identificar tabelas que podem estar isoladas ou não relacionadas a outras tabelas no banco de dados.
***************************************************************/

select schema_name(fk_tab.schema_id) as schema_name, fk_tab.name as table_name, '>- no FKs' foreign_keys 
from sys.tables fk_tab 
left outer join sys.foreign_keys fk on fk_tab.object_id = fk.parent_object_id 
where fk.object_id is null 
order by schema_name(fk_tab.schema_id), fk_tab.name