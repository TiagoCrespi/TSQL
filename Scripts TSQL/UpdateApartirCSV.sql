/***************************************************************
Retorno: Atualiza tabela a partir de arquivo CSV
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
***************************************************************/


/***************************************************************
-- CRIA TABELA TEMPORÁRIA PARA IMPORTAÇÃO DOS DADOS DO CSV
***************************************************************/
USE [CIGAM]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ESMATERI_csv](
	[Cd_material] [varchar](100) NULL,
	[Qt_multiplo_com] varchar(100) NULL
) ON [PRIMARY]
GO

/***************************************************************
-- IMPORTA DADOS DO ARQUIVO CSV PARA A TABELA TEMPORÁRIA
***************************************************************/

bulk insert dbo.ESMATERI_csv
from 'C:\Users\crespidb\Desktop\Cubagem.csv'
with ( 
    fieldterminator = ';', 
    rowterminator = '\n'
)
go 
/********************************************************
-- ATUALIZA A TABELA DE DESTINO COM OS DADOS DA TABELA TEMPORÁRIA
*********************************************************/
update dbo.ESMATERI
set Qt_multiplo_com = parse(cs.Qt_multiplo_com as float using 'pt-BR')
from dbo.ESMATERI_csv as cs
    inner join dbo.ESMATERI as es on cs.Cd_material = es.Cd_material

------ TESTE

--drop table  [dbo].[ESMATERI_csv]
--select * from dbo.esmateri_csv
--truncate table dbo.esmateri_csv
