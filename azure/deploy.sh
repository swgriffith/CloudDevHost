#/bin/bash

# Change these five parameters as needed 
SUFFIX=<Suffix>
RESOURCE_GROUP=<RG Name>
#Azure Files Connection Info
STORAGE_ACCOUNT_NAME=<SA Name>
STORAGE_KEY="<SA Access Key>"
LOCATION=<Location>
SHARE_NAME=<Azure Files Share Name>
PASSWORD=<Password to set for Coder>

# Create the resource group 
az group create -n $RESOURCE_GROUP -l $LOCATION --output table

az appservice plan create --name plan-$SUFFIX --resource-group $RESOURCE_GROUP --sku B1 --is-linux
az webapp create --resource-group $RESOURCE_GROUP --plan plan-$SUFFIX --name web-$SUFFIX --deployment-container-image-name stevegriffith/coder-azure:latest
az webapp config appsettings set --resource-group $RESOURCE_GROUP --name web-$SUFFIX --settings WEBSITES_PORT=8443 PASSWORD=$PASSWORD
az webapp config storage-account add --resource-group $RESOURCE_GROUP --name web-$SUFFIX --custom-id storage-$SUFFIX --storage-type AzureFiles --share-name $SHARE_NAME --account-name $STORAGE_ACCOUNT_NAME --access-key $STORAGE_KEY --mount-path /root
az webapp update --https-only true -g $RESOURCE_GROUP -n web-$SUFFIX

# Write URL out
echo "Browse to http://$(az webapp show -g $RESOURCE_GROUP -n web-$SUFFIX -o json | jq '.hostNames[0]' -r)"
