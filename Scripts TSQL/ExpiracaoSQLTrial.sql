/***************************************************************
Retorno: Duração restante para expiração do SQL Trial (180 dias)
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Funciona apenas para SQL Server Trial (180 dias)
***************************************************************/

SELECT
    CREATE_DATE AS 'Data de Instalação',
    DATEADD(DAY, 180, CREATE_DATE) AS 'Data de Expiração (180 dias)',
    DATEDIFF(DAY, GETDATE(), DATEADD(DAY, 180, CREATE_DATE)) AS 'Dias Restantes'
FROM sys.server_principals
WHERE name = 'NT AUTHORITY\SYSTEM';