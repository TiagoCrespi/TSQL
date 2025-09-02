/***************************************************************
Retorno: Retorna dados de auditoria contidos em arquivos .sqlaudit
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Deve-se alterar o caminho do arquivo conforme o ambiente
***************************************************************/

/* Cria tabela temporária com os dados da auditoria */
SELECT * 
into coletaAuditoria
FROM Sys.fn_get_audit_file('f:\*.sqlaudit',default,default)  

 /* Consulta os dados da auditoria */
SELECT event_time,action_id,server_principal_name,statement,* 
FROM Sys.fn_get_audit_file('f:\*.sqlaudit',default,default)
