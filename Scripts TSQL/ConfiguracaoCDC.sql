IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'Cobranca' AND is_cdc_enabled = 1)
BEGIN
    USE Cobranca
                EXEC sys.sp_cdc_enable_db
END
GO
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Cliente' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Cliente', 
                                                @role_name     = null,
                                                @supports_net_changes = 1 
 
END
 
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Cobranca' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Cobranca', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
 
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'CobrancaTitulo' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'CobrancaTitulo', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'ClienteEnderecos' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'ClienteEnderecos', 
                                                @role_name     = null,
                                                @supports_net_changes = 1 
 
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'descricao_historico' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'descricao_historico', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
 
 
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'TelefoneCliente' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'TelefoneCliente', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
 
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Judicial' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Judicial', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'CobrancaBem' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'CobrancaBem', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Historico' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Historico', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Acionamento' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Acionamento', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
 
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Distribuicao' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Distribuicao', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'AcionamentoResultado' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'AcionamentoResultado', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'Motivo_Atraso' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'Motivo_Atraso', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'TelefoneEstatistica' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'TelefoneEstatistica', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'ClienteCalculo' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'ClienteCalculo', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'ClienteCalculoLinha' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'ClienteCalculoLinha', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'PropostaBancoPan' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'PropostaBancoPan', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
IF NOT EXISTS(SELECT name,type,type_desc FROM sys.tables WHERE name = 'SMSRetorno' AND is_tracked_by_cdc = 1)
BEGIN 
                EXEC sys.sp_cdc_enable_table 
                                                @source_schema = 'dbo', 
                                                @source_name   = 'SMSRetorno', 
                                                @role_name     = null,
                                                @supports_net_changes = 1
END
USE Cobranca
EXEC sp_cdc_change_job @job_type='cleanup', @retention = 120, @threshold = 15000
 
/*
 
create nonclustered index [IDX_dbo_CobrancaTitulo_CT_processo_parcela] on cdc.dbo_CobrancaTitulo_CT (cd_processo,cd_parcela)
create nonclustered index [IDX_dbo_CobrancaTitulo_CT_processo] on cdc.dbo_CobrancaTitulo_CT (cd_processo);
create nonclustered index [IDX_dbo_Cobranca_CT_processo] on cdc.dbo_Cobranca_CT (cd_processo);
create nonclustered index [IDX_dbo_TelefoneEstatistica_CT_processo] on cdc.dbo_TelefoneEstatistica_CT (cd_processo);
create nonclustered index [IDX_dbo_Acionamento_CT_processo] on cdc.dbo_Acionamento_CT (cd_processo);
create nonclustered index [IDX_dbo_Cliente_CT_cliente] on cdc.dbo_Cliente_CT (cd_cliente);
create nonclustered index [IDX_dbo_Cobranca_CT_cliente] on cdc.dbo_Cobranca_CT (cd_cliente);
create nonclustered index [IDX_dbo_Cobranca_CT_devedor] on cdc.dbo_Cobranca_CT (cd_devedor);
create nonclustered index [IDX_dbo_ClienteEnderecos_CT_devedor] on cdc.dbo_ClienteEnderecos_CT (cd_cliente);
create nonclustered index [IDX_dbo_TelefoneCliente_CT_devedor] on cdc.dbo_TelefoneCliente_CT (cd_cliente);
create nonclustered index [IDX_dbo_Historico_CT_processo] on cdc.dbo_Historico_CT (cd_processo);
 
*/
 