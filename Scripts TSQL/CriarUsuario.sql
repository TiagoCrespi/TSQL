/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Cria usuário no banco de dados
    Deve-se alterar o nome do usuário e a senha
    Deve-se alterar o nome do banco de dados onde o usuário será criado
***************************************************************/


CREATE LOGIN [<nome do usuário>]
    WITH PASSWORD = '<Senha do usuário>' 
GO


CREATE USER [<nome do usuário>]
    FOR LOGIN [<nome do usuário>]
    WITH DEFAULT_SCHEMA = dbo
GO
-- Add user to the database owner role
EXEC sp_addrolemember N'db_datareader', N'Nome do usuário'
GO
EXEC sp_droprolemember N'db_datawriter', N'Nome do usuário'
GO