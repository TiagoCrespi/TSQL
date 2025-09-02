<#***************************************************************
Retorno: Gera script de criação de todos os objetos do banco de dados
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário ter o módulo SQLServer instalado
    Deve ser trocado o servidor, instancia e banco de dados no path do foreach
***************************************************************#>


Import-Module sqlserver
$pathScript = 'c:\temp\procedures.sql' 
foreach ($tbl in Get-ChildItem SQLSERVER:\SQL\cdb-tiago\sqlserver2019\DATABASES\metadados\StoredProcedures\ )
{
    $tbl.Script() | Out-File $pathScript -Append
}

