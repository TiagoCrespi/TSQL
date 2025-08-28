/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Rebuild e Reorganize índices
***************************************************************/

/* Cria tabela temporária para armazenar os índices fragmentados */
drop table #_CheckList_Fragmentacao_Indice;

create table #_CheckList_Fragmentacao_Indice(
	[cdhistoricofragmentacaoindice] [int] IDENTITY(1,1) NOT NULL,
	[dtreferencia] [datetime] NULL,
	[nmservidor] [nvarchar](50) NULL,
	[nmdatabase] [nvarchar](50) NULL,
	[nmschema] [nvarchar](200) NULL,
	[nmtabela] [nvarchar](200) NULL,
	[nmindice] [nvarchar](200) NULL,
	[nrfragmentacaopercentual] [float] NULL,
	[nrpagecount] [bigint] NULL,
	[nrfillfactor] [int] NULL
) ON [PRIMARY]

truncate table #_CheckList_Fragmentacao_Indice
go
with x
as (
select 
getdate() data, @@SERVERNAME server, db_name(db_ID()) banco, s.name sX,
OBJECT_NAME(b.object_id) tabela, b.name Indice, 
avg_fragmentation_in_percent MedPer , page_count PgNr, fill_factor ff
from sys.dm_db_index_physical_stats( db_ID(), null, null, null,null) a
	inner join sys.indexes b WITH (NOLOCK) on a.object_id = b.object_id and a.index_id = b.index_id
	inner join sys.tables t WITH (NOLOCK) on t.object_id = b.object_id
	inner join sys.schemas s WITH (NOLOCK) on t.schema_id = s.schema_id
where avg_fragmentation_in_percent > 5  and page_count > 1000
)
select * from x


/* Insere os índices fragmentados na tabela temporária */
SET NOCOUNT ON;

if (object_id('tempdb.dbo.#tbRebuild') is not null) drop table #tbRebuild
if (object_id('tempdb.dbo.#tbReorganize') is not null) drop table #tbReorganize

Declare @tSQL varchar(Max)
DECLARE @DtReferencia datetime

create table #tbRebuild (NrLinha bigint identity(1,1), reindex varchar(max))

create table #tbReorganize (NrLinha bigint identity(1,1), reindex varchar(max))


/* Insere os índices fragmentados na tabela temporária */
insert into #tbRebuild ( reindex) 
select 
'alter index [' + nmindice + '] on [' + nmdatabase + '].[' + nmschema + '].['+ nmtabela + '] rebuild partition = all WITH (FILLFACTOR = 100, STATISTICS_NORECOMPUTE = Off,  ONLINE = <Alterar>, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)'
	from #_CheckList_Fragmentacao_Indice 
	where
	nmindice is not null
	and nrfragmentacaopercentual > 30 
	and nmtabela not like '%tmp%'
	--and nrpagecount > 1000

insert into #tbReorganize ( reindex) 
select 
'alter index [' + nmindice + '] on [' + nmdatabase + '].[' + nmschema + '].['+ nmtabela + '] reorganize with (lob_compaction = on)'
	from #_CheckList_Fragmentacao_Indice 
	where
	nmindice is not null
	and nrfragmentacaopercentual <= 30 
	--and nrpagecount > 100 

Declare @Contador int =1 
Declare @Max int 
set @Max = (select count(1) from #tbRebuild)

/*  Gera o script de rebuild dos índices fragmentados */

--While @Contador <= @Max
--begin
--	set @tSQL = (select reindex from #tbRebuild where NrLinha = @Contador )
--	print ('  ' + @tSQL)
--		PRINT ('PRINT '' + CAST(@Contador AS VARCHAR(10)) + '' DE ' + CAST(@Max AS VARCHAR(10)))
--	print ('go')
--	set @Contador = @Contador + 1
--end


set @Max = (select count(1) from #tbRebuild)


While @Contador <= @Max
begin
	set @tSQL = (select reindex from #tbRebuild where NrLinha = @Contador )

	print ('  ' + @tSQL)
	PRINT ('PRINT '''  + CAST(@Contador AS VARCHAR(10)) + ' DE ''  + ''' + CAST(@Max AS VARCHAR(10)) + '''')
	print ('go')

	set @Contador = @Contador + 1
end

set @Max = (select count(1) from #tbReorganize)
While @Contador <= @Max
begin
	set @tSQL = (select reindex from #tbReorganize where NrLinha = @Contador )

	print ('  ' + @tSQL)
	PRINT ('PRINT '''  + CAST(@Contador AS VARCHAR(10)) + ' DE ''  + ''' + CAST(@Max AS VARCHAR(10)) + '''')
	print ('go')

	set @Contador = @Contador + 1
end


