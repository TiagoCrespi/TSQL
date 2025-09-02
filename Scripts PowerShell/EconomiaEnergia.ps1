<#***************************************************************
Retorno: Verifica o esquema de energia do Windows e recomenda o uso do modo alta performance
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário rodar como administradors
***************************************************************#>


$EsquemaAtual = Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes | Select ActivePowerScheme
#Retorna os planos no windows
$EsqumaEnergia = Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes | ForEach-Object {Get-ItemProperty $_.pspath}
#Loop em cada esquema de energia para identificar o nome amigavel
foreach ($Esquema in $EsqumaEnergia)
{
    if($Esquema.FriendlyName -like "*High Performance*")
    {
        $AltaPerf = $Esquema.PSChildName
    }
    if ($EsquemaAtual.ActivePowerScheme -eq $Esquema.PSChildName)
    {
        Write-Host "[INFO] Current power scheme: " $Esquema.FriendlyName.Split(",")[2] 
    }
}
if ($EsquemaAtual.ActivePowerScheme -ne $AltaPerf)
{
    Write-Host "Esquema de energia não recomendado. `n Utilize o esquema de alta-performance. Veja KB935799 para detalhes." -ForegroundColor Red
}

