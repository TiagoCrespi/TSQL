/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
 - Retorna todas as procedures que contenham atribuições de valores a variáveis.
***************************************************************/

select ROUTINE_CATALOG as [Database], ROUTINE_NAME as [Procedure], ROUTINE_DEFINITION as [Script]
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_DEFINITION like '%*=%'
OR ROUTINE_DEFINITION like '%=*%'