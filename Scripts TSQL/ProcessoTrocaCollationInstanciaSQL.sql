/***************************************************************
Retorno: null
Autor: Tiago Crespi
Data: 06/2024
Version: 1.0 
Obs: Processo de troca de collation da Instancia SQL Server
    Alterar o collation da instancia do SQL Server não é uma tarefa simples,
    pois envolve parar o serviço do SQL Server e iniciar em modo de usuário único
    com parâmetros específicos para alterar o collation.
    Este processo pode causar indisponibilidade temporária do serviço,
    portanto, deve ser planejado e executado com cuidado.
    Recomenda-se fazer um backup completo de todos os bancos de dados
    e testar o procedimento em um ambiente de desenvolvimento antes de aplicá-lo em produção.
    Alterar o nome da instancia conforme o ambiente
***************************************************************/

-- Processo de troca de collation da Instancia:

1 - Desatch os databases de usuario

2 - Parar os serviços do SQL Server

3 - Abrir o cmd como Administrator

4 - Ir até o diretorio Binn dentro da pasta de instalação do SQL Server

5 - Executar o comando abaixo indicando a nova collatio:
	- Instancia Default
		sqlservr -m -T4022 -T3659 -s"MSSQLSERVER" -q"<NovoCollation>"
	- Instancia nomeada
		sqlservr -m -T4022 -T3659 -s"<NomeInstancia>" -q"<NovoCollation>"
		
	Resumo dos parâmetros:
	-m = mode admin single user
	-T = Habilitar o trace flag
	-q = Nova collation
	
	Trace Flag
	T4022 = Faz um bypass nos procedimentos de inicialização do SQL Server
	T3569 = Habilita o log para todos os comandos de durante o processo de inicializacao
		
6 - Aguardar finalizar

7 - Iniciar os serviços do SQL Server e validar se houve a troca do collation antes de subir os databases de usuario

8 - Attachment dos databases
