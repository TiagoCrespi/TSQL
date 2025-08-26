SELECT  sd.name AS [Database],
min(bs.backup_start_date) [Primeiro backup], max(bs.backup_finish_date) [Ultimo backup]
FROM master..sysdatabases sd
	LEFT OUTER JOIN msdb..backupset bs ON RTRIM(bs.database_name) = RTRIM(sd.name)
	LEFT OUTER JOIN msdb..backupmediafamily bmf ON bs.media_set_id = bmf.media_set_id
group by sd.name
order by sd.name