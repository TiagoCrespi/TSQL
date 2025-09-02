/***************************************************************
Retorno: retorna a porcentagem de rollback de uma transação em andamento
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: pode ser necessário ajustar o filtro do session_id
***************************************************************/

SELECT percent_complete, estimated_completion_time,estimated_completion_time/60000 as estimated_completion_time_MIN
  FROM sys.dm_exec_requests
  --where session_id = 121

