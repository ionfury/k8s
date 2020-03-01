export AZURE_TENANT_ID=$(az account show --query tenantId -o tsv) \
  && export AZURE_CLIENT_ID=$(az ad sp list --display-name ion-keyvault-sp --query "[0].appId" -o tsv) \
  && export AZURE_CLIENT_SECRET=$(az keyvault secret show --vault-name sops-D66185F135194728 --name sops-secret --query value -o tsv)