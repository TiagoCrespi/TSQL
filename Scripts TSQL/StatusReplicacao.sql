/***************************************************************
Retorno: Status das réplicas de um banco de dados em um grupo de disponibilidade Always On
Objetivo: Retornar o status das réplicas de um banco de dados em um grupo de disponibilidade Always On
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Observação: Necessário ter permissão de leitura na base distribution
***************************************************************/

select * from distribution.dbo.MSdistribution_agents;   
