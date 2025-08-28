<#***************************************************************
Retorno: Cria uma credencial criptografada para ser usada em scripts
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Necessário alterar o path do arquivo XML
***************************************************************#>

$credencial = get-credential
$credencial | Export-Clixml -Path C:\CrespiDB\EmailCredential.xml
