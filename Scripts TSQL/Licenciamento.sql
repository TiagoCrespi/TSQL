/***************************************************************
Retorna o tipo de licença, número de licenças e edição do SQL Server
***************************************************************/

/*  Versão do 2005 at  2008 */
SELECT serverproperty('licensetype'), serverproperty('numlicenses'), serverproperty('edition') 

/* Acima do 2012 */
EXEC sp_readerrorlog @p1 = 0, @p2 = 1, @p3 = 'Licensing'

