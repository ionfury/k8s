az login
az account set --subscription "Visual Studio Professional"

kubectl delete secret "acr-secret"

kubectl create secret docker-registry acr-secret \
    --docker-server=ionfuryacr.azurecr.io \
    --docker-username=ionfuryacr \
    --docker-password=$(az acr credential show -n ionfuryacr --query "passwords[0].value" -o tsv) \
    --docker-email=ionfury@gmail.com