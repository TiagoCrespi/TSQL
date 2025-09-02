/***************************************************************
Retorno: Lista de bancos de dados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Nenhuma
***************************************************************/

select
	name, database_id, create_date, compatibility_level, collation_name, 
	is_read_only, is_auto_close_on, is_auto_shrink_on, state_desc, recovery_model_desc, 
	page_verify_option_desc, is_auto_create_stats_on
from sys.databases

