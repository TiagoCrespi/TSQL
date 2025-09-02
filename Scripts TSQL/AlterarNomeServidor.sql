/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Altera o nome do servidor SQL Server
     Troque <antigo> pelo nome atual do servidor
     Troque <Novo> pelo novo nome do servidor
***************************************************************/

EXEC sp_dropserver '<antigo>';  
GO  
EXEC sp_addserver '<Novo>', local;  
GO 