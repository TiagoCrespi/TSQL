/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observações: 
 - Retorna todas as triggers que contenham atribuições de valores a variáveis.
***************************************************************/

SELECT 
    sysobjects.name AS trigger_name, 
    OBJECT_NAME(parent_obj) AS table_name,
    OBJECT_DEFINITION(id) AS trigger_definition
FROM sysobjects 
WHERE sysobjects.type = 'TR' 
	and (OBJECT_DEFINITION(id) like '%*=%'
OR OBJECT_DEFINITION(id) like '%=*%')