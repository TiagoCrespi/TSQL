/***************************************************************
Retorno: Tamanho dos bancos de dados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Retorna o tamanho de todos os bancos de dados do servidor
***************************************************************/


	DECLARE	@SqlStatement nvarchar(MAX);
	DECLARE @DatabaseName sysname;

	create table #dadosarq (
		type_ bigint 
		,DATABASE_ID    int
		,DATABASE_NAME	sysname
		,LOGICAL_NAME	sysname
		,PHYSICAL_NAME	sysname
		,FILE_SIZE_MB	decimal(10, 3)
		,MAX_SIZE		decimal(10, 3)
		,GROWTH			decimal(10, 3)
		,SPACE_USED_MB	decimal(10, 3)
		,FREE_SPACE_MB	decimal(10, 3)
		,PERCENT_USED	decimal(10, 3)
		,TPGROWTH		bit
		,FILE_NAME_		sysname
	)	
	DECLARE DatabaseList CURSOR LOCAL FAST_FORWARD FOR
	SELECT name FROM sys.databases where state = 0;
	OPEN DatabaseList;
	WHILE 1 = 1
	BEGIN
		FETCH NEXT FROM DatabaseList INTO @DatabaseName;
		IF @@FETCH_STATUS = -1 BREAK;
		SET @SqlStatement = N'USE '
			+ QUOTENAME(@DatabaseName)
			+ CHAR(13)+ CHAR(10)
		+ N'INSERT INTO #dadosarq 
		select
			f.type,
			DB_ID() as database_id,
			DB_NAME() as database_name,
			f.name as logical_name,
			f.physical_name as physical_name,
			CONVERT(decimal(10,3), round(f.size/128.000,2)) as file_size_mb,
			CONVERT(decimal(10,3), ROUND(f.max_size/128.000,2)) as max_size,
			CONVERT(decimal(10,3), ROUND(f.growth/128.000,2)) as growth,
			CONVERT(decimal(10,3), round(fileproperty(f.name,''SpaceUsed'')/128.000,2)) as space_user_mb,
			CONVERT(decimal(10,3), round((f.size-fileproperty(f.name,''SpaceUsed''))/128.000,2)) as free_space_mb,
			CONVERT(decimal(10,3), (round((f.size-fileproperty(f.name,''SpaceUsed''))/128.000,2)/round(f.size/128.000,2)))*(100) as percent_used,
			is_percent_growth,
			f.name as file_name
		from sys.database_files as f
'		
		EXECUTE(@SqlStatement);
	END
select DATABASE_ID, DATABASE_NAME, sum(FILE_SIZE_MB) as file_size_mb
from #dadosarq	
group by DATABASE_ID, DATABASE_NAME
Order by DATABASE_ID