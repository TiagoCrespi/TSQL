select v.TABLE_CATALOG as [Database], v.TABLE_NAME as [Table], v.VIEW_DEFINITION as [Script]
from INFORMATION_SCHEMA.VIEWS as v
where v.VIEW_DEFINITION like '%*=%'
OR v.VIEW_DEFINITION like '%=*%''