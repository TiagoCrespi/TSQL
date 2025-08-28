/***************************************************************
Retorno: Retornar os itens de email com falha, enviados e log de eventos do Database Mail
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
***************************************************************/

/* Configura o Database Mail
   1 - Habilita o Database Mail XPs
   2 - Cria um perfil de email
   3 - Cria uma conta de email
   4 - Adiciona a conta ao perfil
   5 - Configura o perfil como padrão
   6 - Testa o envio de email
*/
select * from sysmail_faileditems order by mailitem_id desc
select * from sysmail_sentitems order by mailitem_id desc
select * from sysmail_event_log order by mailitem_id desc

