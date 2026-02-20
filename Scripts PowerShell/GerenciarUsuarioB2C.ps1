# Desconecta do Microsoft Graph para garantir que não haja conexões ativas
Disconnect-MgGraph

# Conecta ao Microsoft Graph usando o TenantId e as permissões necessárias
Connect-MgGraph -TenantId "9bc439e9-c9d6-4170-bf51-de9b14aa2e1f" -Scopes "User.Read.All","User.ReadWrite.All"

# Remove o usuário
Remove-MgUser -UserId   # O nome de exibição do usuário

# Cria um novo usuário com as informações fornecidas
$pwdProfile = @{
    Password = " " # A senha deve atender aos requisitos de complexidade do Azure AD
    ForceChangePasswordNextSignIn = $false
}

New-MgUser -DisplayName "Demo ERP Summit" ` # O nome de exibição do usuário
  -UserPrincipalName d `
  -MailNickname "Demo" `
  -AccountEnabled:$true `
  -PasswordProfile $pwdProfile