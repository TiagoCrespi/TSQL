/***************************************************************
Retorno: Lista diretório dos arquivos de configuração do Postgres
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
  - Necessário rodar como superusuário
***************************************************************/

 /* Localização dos arquivos de configuração */
select name, setting from pg_settings where category = 'File Locations';

/* Exemplos */
/* 
--- Windows
Cd C:\Program Files\PostgreSQL\11\bin\

--- Red Hat
Configuração
/var/lib/pgsql/<VERSÃO MAJORITÁRIA>/data
Dados
/var/lib/pgsql/<VERSÃO MAJORITÁRIA>/data

---- Debian
Dados
/var/lib/postgres/<VERSÃO MAJORITÁRIA>/data
Configurações
/etc/postgres/<VERSÃO MAJORITÁRIA>/
*/ 