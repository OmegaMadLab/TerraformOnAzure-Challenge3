# Requires Az module
# Requires PowerShell 7

login-azaccount

$rgName     = "TerraformOnAzure-TfState3"
$location   = "westeurope"

$rg = New-AzResourceGroup -Name $rgName `
        -Location $location

# Storage account for TF state
$sa = New-AzStorageAccount -ResourceGroupName $rg.ResourceGroupName `
        -Name "tfonazure3$(Get-random -Maximum 99999999)" `
        -location $rg.Location `
        -SkuName "Standard_LRS" `
        -Kind "StorageV2"

$container = New-AzStorageContainer -Name "tfstate" -Context $sa.Context

Write-Host "Storage Account Name: $($sa.StorageAccountName)"
Write-Host "Storage Account Key: $((($sa | Get-AzStorageAccountKey) | ? KeyName -eq "Key1").Value)"
Write-Host "Container Name: $($container.Name)"

# Security principal for TF
$sp = New-AzADServicePrincipal -DisplayName "TerraformOnAzure" 

$secret = New-AzADSpCredential -ServicePrincipalObject $sp `
                -StartDate (Get-Date) `
                -EndDate (Get-Date).AddYears(3) 
        
Write-Host "ApplicationID: $($sp.ApplicationId)"
Write-Host "ClientSecret: $($secret.Secret | ConvertFrom-SecureString)"
Write-Host "TenantID: $((Get-AzContext).Tenant.Id)"
Write-Host "SubscriptionID: $((Get-AzContext).Subscription.Id)"


