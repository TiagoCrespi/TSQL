/***************************************************************
Retorno: Tempo do último backup completo de todas as bases de dados
Objetivo: Obter o tempo do último backup completo de todas as bases de dados no servidor SQL.
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observação: 
  - O script retorna o tempo do último backup completo de todas as bases de dados.
  - O tempo é retornado em minutos.
  - Certifique-se de que o serviço SQL Server Agent esteja em execução para que os backups sejam registrados corretamente.
  - Ajuste a variável @dbname se quiser filtrar por uma base de dados específica.
  - Requer permissões adequadas para acessar a tabela msdb.dbo.backupset
***************************************************************/

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