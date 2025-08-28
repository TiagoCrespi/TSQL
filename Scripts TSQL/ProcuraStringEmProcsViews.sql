/***************************************************************
Retorno: Retorna todas as procedures, views e functions que contenham a string informada
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
***************************************************************/

SELECT
    SchemaName      = SCHEMA_NAME ([Objects].schema_id) ,
    ObjectName      = [Objects].[name] ,
    ObjectType      = [Objects].[type_desc] ,
    [Definition]    = SQLModules.[definition]
FROM
    sys.sql_modules AS SQLModules
INNER JOIN
    sys.objects AS [Objects]
ON
    SQLModules.[object_id] = [Objects].[object_id]
WHERE
    SQLModules.[definition] LIKE N'%minha_string%'

