/***************************************************************
REtorna o tamanho do banco de dados atual, detalhado por arquivo.
Se precisar do tamanho de um banco específico, basta fazer o USE <banco> antes de executar o script.
***************************************************************/

use DB_NAME()  -- Coloque o nome do banco aqui
;with x as (
select
	f.type,
	DB_ID() as database_id,
	DB_NAME() as database_name,
	f.physical_name as physical_name,
	CONVERT(decimal(10,3), round(f.size/128.000,2)) as file_size_mb,
	CONVERT(decimal(10,3), round(fileproperty(f.name,'SpaceUsed')/128.000,2)) as space_user_mb,
	CONVERT(decimal(10,3), round((f.size-fileproperty(f.name,'SpaceUsed'))/128.000,2)) as free_space_mb,
	CONVERT(decimal(10,3), (round((f.size-fileproperty(f.name,'SpaceUsed'))/128.000,2)/round(f.size/128.000,2)))*(100) as percent_Free,
	f.name as file_name
from sys.database_files as f
)
select DATABASE_ID, DATABASE_NAME, sum(FILE_SIZE_MB) as file_size_mb
from x 
group by DATABASE_ID, DATABASE_NAME