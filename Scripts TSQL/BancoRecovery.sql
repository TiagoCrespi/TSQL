/***************************************************************
Retorno: Banco de dados em Suspect
Objetivo: Tentar recuperar o banco de dados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Caso o banco esteja em suspect, seguir os passos abaixo para tentar recuperar o banco
    Trocar <banco> pelo nome do banco
    Caso o banco esteja em uso, colocar em single user
***************************************************************/

/* 1 - Ver se tem paginas em suspect */
use master  
go
select * from sys.suspect_pages

/* 2 - Tentar fazer o restore com with recovery */ß
restore database with recovery 

/* 3 - Colocar o banco em modo emergencia e rodar o DBCC */
alter database <banco> set emergency
alter database <banco> set single_user
Dbcc checkdb (<banco>,  allowdataloss) with all_errormessages
alter database <banco> set multi_user


SHUTDOWN WITH NOWAIT;