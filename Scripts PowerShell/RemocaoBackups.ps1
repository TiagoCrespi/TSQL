<#***************************************************************
Retorno: Remove backups antigos, mantendo apenas o último full e os diferenciais posteriores
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário ter o módulo SQLServer instalado
    Deve ser trocado o servidor, instancia e banco de dados no path do foreach
***************************************************************#>


param(
	[string] $customer = '',  #Nome do cliente
    [string] $servername = '', #Nome do servidor
    [string] $nminstancia = '', #Nome da instancia
    [string] $Unidade = '', #Unidade onde estão os backups
    [string] $numberofweeks = 0 #Número de semanas para manter os backups
)

try {
    Get-ChildItem -Directory | 
        ForEach-Object {
            $directory = $_.Name
            [string]$dtultimoFull = Get-ChildItem *full* -path $directory |Select-Object -Property lastwritetime| select -last 1 
            $dtfiltro = $dtultimoFull.trim('@{LastWriteTime=').trim('}')
            Get-ChildItem -path $directory |Where-Object -FilterScript{$_.LastWriteTime -lt $dtfiltro} |Remove-Item
        }
    exit (0)
} catch {
    $Credential = Import-Clixml '' #Path do arquivo com as credenciais do e-mail
    $subject = “Erro de remocao de backup: " + $customer + ' - '+ $servername + ' - '+ $nminstancia
    Send-MailMessage -From “avisodba@crespidb.com.br” -To “oberdan@crespidb.com.br” -Subject $subject  -Body “Ecorreu um erro na tentativa de remocao dos backups do SQLSERVER.” `
                                        -Credential $Credential -SmtpServer “smtp-mail.outlook.com” -Port 587
    exit(1)    
}

