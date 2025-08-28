/***************************************************************
Altera o nome do servidor SQL Server
***************************************************************/

EXEC sp_dropserver '<antigo>';  
GO  
EXEC sp_addserver '<Novo>', local;  
GO 