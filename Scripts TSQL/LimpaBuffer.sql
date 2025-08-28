/***********************************************************************
*  Script Name: LimpaBuffer.sql
*  Descrição: Limpa o buffer do SQL Server
*  Objetivo: reforçar a limpeza do buffer do SQL Server
*  Autor: Tiago Crespi
*  Data: 06/2024
*  Version: 1.0
***********************************************************************/

CHECKPOINT
DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS