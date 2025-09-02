/***************************************************************
Retorno: Movimentar Arquivos do Banco de Dados
Objetivo: Mover os arquivos de dados e log do banco de dados CrespiDB
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Nenhuma
***************************************************************/
use master
go
select name, physical_name from sys.master_files where database_id = db_id('CrespiDB')
go
alter database CrespiDB set offline
go
alter database CrespiDB modify file 
(name = CrespiDB, filename = 'C:\ClusterStorage\Volume3\Dados\CrespiDB\CrespiDB.mdf')
go
alter database CrespiDB modify file 
(name = CrespiDB_log, filename = 'C:\ClusterStorage\Volume2\Logs\CrespiDB\CrespiDB_log.ldf')
go
alter database CrespiDB set online
