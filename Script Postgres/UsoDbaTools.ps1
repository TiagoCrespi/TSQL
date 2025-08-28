<#***************************************************************
Retorno: Comandos para uso do módulo dbatools
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário ter o módulo dbatools instalado
***************************************************************#>
Import-Module dbatools

<#  Restore de backup conforme os ultimos backuos feitos #>
Get-DbaDbBackupHistory -SqlInstance cdb-tiago\sqlserver2019 -Database Metadados -Last |Restore-DbaDatabase -DatabaseName Metadados_1 -SqlInstance cdb-tiago\sqlserver2019 -DestinationDataDirectory D:\backup_teste\ -DestinationLogDirectory D:\backup_teste\ -WithReplace

<# Restore do banco com os dados de um diretório #>
Restore-DbaDatabase -DatabaseName TSQL -SqlInstance cdb-tiago\sqlserver2019 -DestinationDataDirectory D:\bancos\ -DestinationLogDirectory D:\bancos\ -WithReplace -Path D:\bkp\

<# Backup pelo DbaTools #> 
Backup-DbaDatabase -Path e:\backup\dfentrada -SqlInstance srv-bbm-dbs01\dfentrada -Database ('tn3intranet', 'tn3nfe_producao', 'tn3dfentrada') -CompressBackup


ß