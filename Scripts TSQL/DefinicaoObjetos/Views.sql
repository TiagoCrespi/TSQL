/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
 - Retorna todas as views que contenham atribuições de valores a variáveis.
***************************************************************/

select v.TABLE_CATALOG as [Database], v.TABLE_NAME as [Table], v.VIEW_DEFINITION as [Script]
from INFORMATION_SCHEMA.VIEWS as v
where v.VIEW_DEFINITION like '%*=%'
OR v.VIEW_DEFINITION like '%=*%''