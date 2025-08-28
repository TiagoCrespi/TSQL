/****************************************************************
Retorno: Lista de Jobs com agendamento ativo
Descrição: Script para listar os jobs com agendamento ativo
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
*****************************************************************/
select a.[name] as [job_name], suser_sname(a.[owner_sid]) as [owner_name], a.[enabled]
, c.[name] as [schedule_name], d.step_name as [Step_name] --, d.command as [Command]
, msdb.dbo.agent_datetime(b.next_run_date, b.next_run_time) as [next_run_dttm]
, msdb.dbo.agent_datetime(c.active_start_date, c.active_start_time) as [active_start_dttm]
, msdb.dbo.agent_datetime(c.active_end_date, c.active_end_time) as [active_end_dttm]

, case c.freq_type when 1 then 'One time only'
when 4 then 'Daily'
when 8 then 'Weekly'
when 16 then 'Monthly'
when 32 then 'Monthly, relative to freq_interval'
when 64 then 'Runs when SQL Server Agent service starts'
when 128 then 'Runs when computer is idle'
else 'Unknown'
end as [freq_type_descr]
, case when c.freq_type = 1 then 'Unused'
when c.freq_type = 4 then 'Every ' + convert(varchar(10), c.freq_interval) + ' days'
when c.freq_type = 8 then 'Weekly: every'
+ case when c.freq_interval & 1 = 1 then ' Sunday' else '' end
+ case when c.freq_interval & 2 = 2 then ' Monday' else '' end
+ case when c.freq_interval & 4 = 4 then ' Tuesday' else '' end
+ case when c.freq_interval & 8 = 8 then ' Wednesday' else '' end
+ case when c.freq_interval & 16 = 16 then ' Thursday' else '' end
+ case when c.freq_interval & 32 = 32 then ' Friday' else '' end
+ case when c.freq_interval & 64 = 64 then ' Saturday' else '' end

when c.freq_type = 16 then 'Monthly: on the ' + convert(varchar(10), c.freq_interval) + ' day of every ' + convert(varchar(10), c.freq_recurrence_factor) + ' month(s)'
when c.freq_type = 32 then 'Monthly: on the ' + case when c.freq_relative_interval = 0 then 'Unused'
when c.freq_relative_interval = 1 then 'First'
when c.freq_relative_interval = 2 then 'Second'
when c.freq_relative_interval = 4 then 'Third'
when c.freq_relative_interval = 8 then 'Fourth'
when c.freq_relative_interval = 16 then 'Last'
else 'Unknown' end + ' ' + case when c.freq_interval = 1 then 'Sunday'
when c.freq_interval = 2 then 'Moday'
when c.freq_interval = 3 then 'Tusday'
when c.freq_interval = 4 then 'Wednesday'
when c.freq_interval = 5 then 'Thursday'
when c.freq_interval = 6 then 'Friday'
when c.freq_interval = 7 then 'Saturday'
when c.freq_interval = 8 then 'Day'
when c.freq_interval = 9 then 'Weekday'
when c.freq_interval = 10 then 'Weekend day'
end + ' of every ' + convert(varchar(10), c.freq_recurrence_factor) + ' month(s)'
else 'Unused'
end as [freq_interval_descr]
, case when c.freq_type = 1 then 'At the specified time'
when c.freq_subday_type = 1 then 'At the specified time'
when c.freq_subday_type = 2 then 'Seconds'
when c.freq_subday_type = 4 then 'Minutes'
when c.freq_subday_type = 8 then 'Hours'
end as [freq_subday_type_descr]
, case
when c.freq_type = 1 then 'At ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_start_date, c.active_start_time), 121),12, 12)
when c.freq_subday_type = 1 then 'At ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_start_date, c.active_start_time), 121),12, 12)
when c.freq_subday_type in (2,4,8) then 'Every ' + convert(varchar(10), c.freq_subday_interval) + ' ' + case c.freq_subday_type when 1 then 'At the specified time'
when 2 then 'Seconds' + ' between ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_start_date, c.active_start_time), 121),12, 12) + ' and ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_end_date, c.active_end_time), 121),12, 12)
when 4 then 'Minutes' + ' between ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_start_date, c.active_start_time), 121),12, 12) + ' and ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_end_date, c.active_end_time), 121),12, 12)
when 8 then 'Hours' + ' between ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_start_date, c.active_start_time), 121),12, 12) + ' and ' + substring(convert(varchar(23), msdb.dbo.agent_datetime(c.active_end_date, c.active_end_time), 121),12, 12)
end
else 'Unused' end as [freq_subday_interval_descr]
from sysjobs as [a]
join sysjobschedules as [b] on b.job_id = a.job_id
join sysschedules as [c] on c.schedule_id = b.schedule_id and c.[enabled] = 1
join sysjobsteps as [d] on a.job_id = d.job_id
where a.[enabled] = 1
order by a.name
