/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Pausa bancos do AG e depois retoma
    Deve ser executado em todas as réplicas
    Deve se alterar os nomes dos bancos conforme o ambiente
***************************************************************/

/* Pausa bancos do AG */
ALTER DATABASE BancoScript SET HADR SUSPEND;
GO
ALTER DATABASE CDB SET HADR SUSPEND;
GO
ALTER DATABASE cdbDW SET HADR SUSPEND;
GO
ALTER DATABASE cdbUpload SET HADR SUSPEND;
GO
ALTER DATABASE CrespiDB SET HADR SUSPEND;
GO
ALTER DATABASE dwCorporativo SET HADR SUSPEND;
GO
ALTER DATABASE ponto SET HADR SUSPEND;
GO

/* Retoma bancos do AG */
ALTER DATABASE BancoScript SET HADR RESUME;
GO
ALTER DATABASE CDB SET HADR RESUME;
GO
ALTER DATABASE cdbDW SET HADR RESUME;
GO
ALTER DATABASE cdbUpload SET HADR RESUME;
GO
ALTER DATABASE CrespiDB SET HADR RESUME;
GO
ALTER DATABASE dwCorporativo SET HADR RESUME;
GO
ALTER DATABASE ponto SET HADR RESUME;
GO
