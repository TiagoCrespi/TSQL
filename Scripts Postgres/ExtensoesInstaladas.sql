/***************************************************************
Retorno: Lista das extensões instaladas no Postgres
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
  - Necessário rodar como superusuário
***************************************************************/

select name, default_version, installed_version, left(comment,30) 
from pg_available_extensions 
where installed_version is not null order by name;