# CloudDevHost

Inspired by [this](https://twitter.com/evill_genius/status/1109198926694043654) tweet I got around to something I'd planned to do for a very long time. Browser based VS Code editor, using [Coder](https://coder.com/) on Ubuntu as a base, and then adding in some standard tools, including the Azure CLI. 

I decided to run this in Azure Web Apps for Containers, because I planned to join the container to and Azure Files Share for my and authenticate the Azure CLI to my subscription. I also planned on generating an SSH key for github, etc. With all that I needed to make sure I had TLS 1.2 with a proper cert instead of self signed, which you get from Web Apps. 

## To Run
This assumes you've already gone out and created an Azure File share and pulled the storage account name, share name and access key. 

1. Login to the Azure CLI (i.e. [Portal](https://portal.azure.com), [Cloud Shell](https://shell.azure.com), or from your locally installed cli)
1. Open the deploy.sh and update the following values:
    ```bash
    SUFFIX=<Suffix>
    RESOURCE_GROUP=<RG Name>
    #Azure Files Connection Info
    STORAGE_ACCOUNT_NAME=<SA Name>
    STORAGE_KEY="<SA Access Key>"
    LOCATION=<Location>
    SHARE_NAME=<Azure Files Share Name>
    PASSWORD=<Password to set for Coder>
    ```

1. Run the deployment script
    ```bash 
    ./deploy.sh
    ```

1. Browse to the URL it outputs and enter the password you set in the script to login.