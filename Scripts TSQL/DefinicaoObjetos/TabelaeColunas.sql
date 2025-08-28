/***********************************************************************
*  Script Name: TabelaeColunas.sql
*  Descrição: Lista as tabelas e colunas do banco de dados
*  Autor: Tiago Crespi
*  Data: 06/2024
*  Version: 1.0
***********************************************************************/

select --s.name, 
	t.name as Tabela, c.name as Coluna, ty.name as [Tipo de dados], c.max_length as Tamanho, c.precision as [Precisao]--, c.scale
from sys.tables as t
	inner join sys.columns as c on t.object_id = c.object_id
	inner join sys.schemas as s on s.schema_id = t.schema_id
	inner join sys.types as ty on c.user_type_id = ty.user_type_id
order by s.name, t.name, c.name


/*  */
select 	t.name as Tabela, --ty.name, 
count(*) as [Qtd. Colunas]
from sys.tables as t
	inner join sys.columns as c on t.object_id = c.object_id
	inner join sys.schemas as s on s.schema_id = t.schema_id
	inner join sys.types as ty on c.user_type_id = ty.user_type_id
where ty.name in ('varchar', 'nvarchar', 'varbinary', 'text', 'ntext', 'image', 'sql_variant', 'xml')
	and t.name in ('ComAgeAM', 'CODMOVIT', 'CTBLotIt', 'CODMOVIT', 'CODMOVIT_bkp_nao_excluir', 'CTBDAXMV', 'EMLLOG', 'GFATitu', 'GTCAVBITLG', 'GTCConhe', 'GTCCONIA', 'GTCCONLO', 'GTCConSf', 'GTCETQVL', 'GTCETQVL_bkp', 'GTCMANIM', 'GTCMovEn', 'GTCNf', 'SPDNFE_bkp', 'SPDNFE_old')
group by t.name --, ty.name
--order by s.name, t.name, c.name