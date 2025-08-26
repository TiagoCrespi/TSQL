-- 1 - Ver se tem paginas em suspect
select * from sys.suspect_pages

-- 2 - Tentar fazer o restore com with recovery
restore database with recovery 

-- 3 - Colocar o banco em modo emergencia e rodar o DBCC 
alter database <banco> set emergency
alter database <banco> set single_user
Dbcc checkdb (<banco>,  allowdataloss) with all_errormessages
alter database <banco> set multi_user


SHUTDOWN WITH NOWAIT;