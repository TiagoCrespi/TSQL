SELECT 
    sysobjects.name AS trigger_name, 
    OBJECT_NAME(parent_obj) AS table_name,
    OBJECT_DEFINITION(id) AS trigger_definition
FROM sysobjects 
WHERE sysobjects.type = 'TR' 
	and (OBJECT_DEFINITION(id) like '%*=%'
OR OBJECT_DEFINITION(id) like '%=*%')