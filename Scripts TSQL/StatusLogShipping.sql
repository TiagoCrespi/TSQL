------------ Executar no Primário ------------
select last_backup_file, last_backup_date
 from msdb.dbo.log_shipping_monitor_primary

------------ Executar no Secundário ------------
select last_copied_file,last_restored_file,last_restored_date
 from msdb.dbo.log_shipping_monitor_secondary

 