/***************************************************************
Retorno: Ajusta o tamanho dos arquivos de dados e log de um banco de dados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Altera o nome do servidor SQL Server
     Troque <antigo> pelo nome atual do servidor
     Troque <Novo> pelo novo nome do servidor
***************************************************************/

/*  Sempre colocar a barra no final do endereco */

declare @nmbanco as varchar(100) = 'tempdb';
declare @tamanhoarq as varchar(10) = '2048';
declare @tbcomandos as table(dscomando varchar(1000));

--select name, physical_name from sys.master_files where database_id = db_id(@nmbanco)

insert into @tbcomandos
select 	'alter database ' + @nmbanco + ' modify file ' +	'(name = ' + name + ', Size = ' + @tamanhoarq + ' )' 
from sys.master_files where database_id = db_id(@nmbanco) and data_space_id = 1

insert into @tbcomandos
select 	'alter database ' + @nmbanco + ' modify file ' +	'(name = ' + name + ', Size = ' + @tamanhoarq + ' )' 
from sys.master_files where database_id = db_id(@nmbanco) and data_space_id = 0

select * from @tbcomandos

