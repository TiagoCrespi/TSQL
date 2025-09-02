/***************************************************************
Retorno: Recarregar Configurações do Postgres
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Recarrega as configurações do Postgres sem a necessidade de reiniciar o serviço.
***************************************************************/

Select pg_reload_conf()

