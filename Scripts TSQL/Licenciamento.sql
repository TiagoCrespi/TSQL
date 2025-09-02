/***************************************************************
Retorno: Tipo de Licenciamento do SQL Server
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Nenhuma
***************************************************************/

/*  Versão do 2005 at  2008 */
SELECT serverproperty('licensetype'), serverproperty('numlicenses'), serverproperty('edition') 

/* Acima do 2012 */
EXEC sp_readerrorlog @p1 = 0, @p2 = 1, @p3 = 'Licensing'

