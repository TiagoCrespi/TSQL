DECLARE @dbname sysname
SET @dbname = '' --set this to be whatever dbname you want

SELECT 
  bup.database_name AS [Database],
 CAST((CAST(DATEDIFF(s, bup.backup_start_date, bup.backup_finish_date) AS int))/60 AS varchar) AS [Total Time (minutos)]
FROM msdb.dbo.backupset bup
WHERE bup.backup_set_id IN
  (SELECT MAX(backup_set_id) 
   FROM msdb.dbo.backupset
   WHERE type = 'I'  --only interested in the time of last full backup
   GROUP BY database_name) 
ORDER BY bup.database_name