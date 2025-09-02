/***************************************************************
Retorno: Status das réplicas de um banco de dados em um grupo de disponibilidade Always On
Objetivo: Retornar o status das réplicas de um banco de dados em um grupo de disponibilidade Always On
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Executar no Primário e Secundário
***************************************************************/

 /* Executar no Primário */
select last_backup_file, last_backup_date
 from msdb.dbo.log_shipping_monitor_primary

/* Executar no Secundário */
select last_copied_file,last_restored_file,last_restored_date
 from msdb.dbo.log_shipping_monitor_secondary

 