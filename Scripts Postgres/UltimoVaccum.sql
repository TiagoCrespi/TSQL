/***************************************************************
Retorno: Estatísticas de vacuum e analyze das tabelas
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
  - Necessário rodar como superusuário
***************************************************************/

/* Estatísticas de vacuum e analyze das tabelas */
select relname,last_vacuum, last_autovacuum, last_analyze, last_autoanalyze from pg_stat_user_tables;



/* Ver Configurações do autovacuum */
select * from pg_settings where name like '%autovacuum%';


