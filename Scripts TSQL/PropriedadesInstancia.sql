/***************************************************************
retorna propriedades da instância do SQL Server
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