/***************************************************************
Retorna a data de instalação do SQL Server Trial Edition
e a data de expiração (180 dias) e quantos dias faltam para expirar
***************************************************************/

SELECT
    CREATE_DATE AS 'Data de Instalação',
    DATEADD(DAY, 180, CREATE_DATE) AS 'Data de Expiração (180 dias)',
    DATEDIFF(DAY, GETDATE(), DATEADD(DAY, 180, CREATE_DATE)) AS 'Dias Restantes'
FROM sys.server_principals
WHERE name = 'NT AUTHORITY\SYSTEM';