/***************************************************************
Retorno: Todas as travas ativas no banco de dados PostgreSQL
Objetivo: Auxiliar na identificação de bloqueios que possam estar impactando a performance do banco
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: Necessário ter permissão de superusuário para visualizar todas as travas
***************************************************************/

select * from pg_catalog.pg_locks

SELECT locktype,transactionid,virtualtransaction,pid,mode,granted,fastpath FROM pg_locks

