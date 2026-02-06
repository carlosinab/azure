$appName = "app-azurelab-sysres"
$rg = "rg-azurelab-sysres"

# Staging slot publish profile
az webapp deployment list-publishing-profiles `
    --name $appName `
    --resource-group $rg `
    --slot "staging" `
    --xml

# Production slot publish profile  
az webapp deployment list-publishing-profiles `
    --name $appName `
    --resource-group $rg `
    --xml