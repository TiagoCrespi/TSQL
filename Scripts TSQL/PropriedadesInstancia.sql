/***************************************************************
Retorno: Propriedades da Instância SQL Server	
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Nenhuma
***************************************************************/

SELECT 
	SERVERPROPERTY('BuildClrVersion') 'netVersion',    
	SERVERPROPERTY('productversion') as 'Product Version',    
	SERVERPROPERTY('productlevel') as 'Service Pack',     
	SERVERPROPERTY('edition') as 'Edition',    
	SERVERPROPERTY('instancename') as 'Instance',    
	SERVERPROPERTY('servername') as 'Server Name',    
	SERVERPROPERTY('collation') as 'Collation',    
	SERVERPROPERTY('ComparisonStyle') as 'Windows Comp Style',   
	SERVERPROPERTY('EngineEdition') as 'EngineEdition',    
	SERVERPROPERTY('IsFullTextInstalled') as 'FullText',    
	SERVERPROPERTY('LCID') as 'Windows Locale Indentifier',   
	SERVERPROPERTY('LicenseType') as 'LicenseType',    
	SERVERPROPERTY('MachineName') as 'MachineName',    
	SERVERPROPERTY('NumLicenses') as 'NumLicenses',    
	SERVERPROPERTY('ProcessID') as 'ProcessID',    
	SERVERPROPERTY('LCID') as 'Windows Locale Indentifier',    
	SERVERPROPERTY('LicenseType') as 'LicenseType',    
	SERVERPROPERTY('MachineName') as 'MachineName',    
	SERVERPROPERTY('NumLicenses') as 'NumLicenses',    
    SERVERPROPERTY('ProcessID') as 'ProcessID'    