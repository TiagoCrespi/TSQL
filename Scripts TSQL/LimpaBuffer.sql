/***************************************************************
Retorno: Limpa o Buffer do SQL Server
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Executar com cautela, pois limpa o cache de planos e buffers do SQL Server
***************************************************************/

CHECKPOINT
DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS