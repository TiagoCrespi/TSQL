/***************************************************************
Retorno: Lista de backups realizados no servidor SQL
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações:
  - Exibe a lista de backups realizados no servidor SQL, com a data do primeiro e
	do último backup para cada banco de dados.
  - Considera todos os tipos de backup (completo, diferencial e log).
  - Ordena a lista pelo nome do banco de dados.
  - Pode ser útil para auditoria e monitoramento de backups.
  - Requer permissões adequadas para acessar as tabelas do sistema.
***************************************************************/
SELECT  sd.name AS [Database],
min(bs.backup_start_date) [Primeiro backup], max(bs.backup_finish_date) [Ultimo backup]
FROM master..sysdatabases sd
	LEFT OUTER JOIN msdb..backupset bs ON RTRIM(bs.database_name) = RTRIM(sd.name)
	LEFT OUTER JOIN msdb..backupmediafamily bmf ON bs.media_set_id = bmf.media_set_id
group by sd.name
order by sd.name