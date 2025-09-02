<#***************************************************************
Retorno: Retorna a formatação das unidades do servidor
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário ter permissão de administrador para rodar o script
***************************************************************#>


$wmiQuery = "SELECT Name, Label, Blocksize FROM Win32_Volume WHERE FileSystem='NTFS'"
Get-WmiObject -Query $wmiQuery -ComputerName '.' | Sort-Object Name | Select-Object Name, Label, Blocksize

