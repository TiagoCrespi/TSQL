/***************************************************************
Retorno: Tamanho do banco de dados atual, detalhado por arquivo
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações:
 - Se precisar do tamanho de um banco específico, basta fazer o USE <banco> antes de executar o script.
 - Se precisar do tamanho por arquivo de log, descomentar a linha do final do script, valor 1 = dados, 0 = log 
***************************************************************/

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
--where f.type = 1