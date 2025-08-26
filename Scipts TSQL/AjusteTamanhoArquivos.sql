/* #### Sempre colocar a barra no final do endereco ####*/

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

