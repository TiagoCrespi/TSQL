use		master

-- Seleciona processos bloqueados
Select	spid as [SpId],
		hostname as [Computador],
		loginame as [Usuario],
		status as [Status],
		cmd as [TipoComando],
		program_name as [Aplicativo],
	   (select top 1
	           (select	Text
				from	sys.dm_exec_sql_text(A.sql_handle))
		from	sys.sysprocesses A
		where	A.spid = sysprocesses.spid) as [SQL]		
into	#Temp
from    sysprocesses
where	blocked = 0
and		exists (select	1 
				from	sysprocesses A 
				where	A.blocked = sysprocesses.spid)
and		datediff(second,last_batch,getdate()) > 180
and		cmd = ''SELECT''

-- Insere processos sleeping

insert	into #Temp
Select	spid as [SpId],
		hostname as [Computador],
		loginame as [Usuario],
		status as [Status],
		cmd as [TipoComando],
		program_name as [Aplicativo],
	   (select top 1
	           (select	Text
				from	sys.dm_exec_sql_text(A.sql_handle))
		from	sys.sysprocesses A
		where	A.spid = sysprocesses.spid) as [SQL]		
from    sysprocesses
where	blocked = 0
and		spid > 60
and		datediff(second,last_batch,getdate()) > 3600 -- 1 hora
and		cmd = ''AWAITING COMMAND''
and		status = ''sleeping''

select	identity(int,1,1) as ID,
		SpId,
		Computador,
		Usuario,
		Status,
		TipoComando,
		Aplicativo,
		SQL
into	#Processos
from	#Temp

-- Derruba processos de select que estão travados a mais de 3 segundos
declare	@Count	  int,
		@Max	  int,
		@Processo varchar(20)
		
select	top 1
		@Count = 1,
		@Max = ID
from	#Processos
order	by Id desc

if	@Count <= @Max
	insert	into Portal.DBO.LOGProcess
	select	SpId,
			getdate(),
			Computador,
			Usuario,
			Status,
			TipoComando,
			Aplicativo,
			SQL		
	from	#Processos

while	@Count <= @Max
	begin
		select	@Processo = cast(SpId as varchar(20))
		from	#Processos 
		where	Id = @Count	 
		execute(''KILL '' + @Processo)
		set	@Count = @Count +1
	end
	
-- Apaga tabela temporária
drop	table #Processos
drop	table #Temp', 