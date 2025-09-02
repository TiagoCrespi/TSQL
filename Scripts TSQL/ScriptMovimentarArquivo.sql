/***************************************************************
Retorno: Script de movimentação de arquivos de dados e logs de um banco de dados
         para outro local.
Objetivo: Auxiliar na movimentação de arquivos de dados e logs de um banco de dados
         para outro local.
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Antes de executar o script, certifique-se que o banco de dados está em modo SINGLE_USER.
      Altere as variáveis @nmbanco, @dscaminhoDados e @dscaminhoLogs conforme necessário.
      Execute os comandos retornados pelo script um a um.
***************************************************************/

declare @nmbanco as varchar(100) = 'tempdb';
declare @dscaminhoDados as varchar(100) = 'T:\Dados\';
declare @dscaminhoLogs as varchar(100) = 'T:\Logs\';
declare @tbcomandos as table(dscomando varchar(1000))

select name, physical_name from sys.master_files where database_id = db_id(@nmbanco)

insert into @tbcomandos
select  'alter database ' + @nmbanco + ' set offline'

insert into @tbcomandos
select 	'alter database ' + @nmbanco + ' modify file ' +	'(name = ' + name + ', filename = ''' + @dscaminhodados + reverse(left(reverse(physical_name), charindex('\', reverse(physical_name)) -1)) + '''' + ')' + '' as [ScriptAlteracao]
from sys.master_files where database_id = db_id(@nmbanco) and data_space_id = 1

insert into @tbcomandos
select 	'alter database ' + @nmbanco + ' modify file ' +	'(name = ' + name + ', filename = ''' + @dscaminhoLogs + 	reverse(left(reverse(physical_name), charindex('\', reverse(physical_name)) -1)) + '''' + ')' + '' as [ScriptAlteracao]
from sys.master_files where database_id = db_id(@nmbanco) and data_space_id = 0

insert into @tbcomandos
select  'alter database ' + @nmbanco + ' set online'


select * from @tbcomandos

