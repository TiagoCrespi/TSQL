<#***************************************************************
Retorno: Coleta dados de performance do servidor SQL Server
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário ter permissão de administrador no servidor
    Deve ser trocado o nome da instância e o nome da placa de rede no path do array $counter
***************************************************************#>


$counter = @(
    '\MSSQL$MSSQLTMS:Buffer Manager\Page life expectancy',
    '\MSSQL$MSSQLTMS:Memory Manager\Total Server Memory (KB)',
    '\MSSQL$MSSQLTMS:Memory Manager\Target Server Memory (KB)',
    '\Network Adapter(<trocar pelo nome da placa de rede >)\Bytes Total/sec',
    '\Network Adapter(<trocar pelo nome da placa de rede >)\Packets/sec', 
    '\Network Adapter(<trocar pelo nome da placa de rede >)\Packets Received/sec', 
    '\Network Adapter(<trocar pelo nome da placa de rede >)\Packets Sent/sec', 
    '\LogicalDisk(*)\Avg. Disk sec/Read', 
    '\LogicalDisk(*)\Avg. Disk sec/Write', 
    '\Processor(*)\% Processor Time'
)
get-counter -counter $counter -Continuous -SampleInterval 300 | Export-counter -Path J:\CrespiDB\performance.blg 



$counter = @("\SQLServer:Buffer Manager\Page life expectancy")
