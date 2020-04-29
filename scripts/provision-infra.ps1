# Script to provision Azure infrastructure for this project and its CI/CD pipeline

$subscription = "Olli_Salonen_subscription"
$location = "westeurope"
$group = "learn"
$storage = "oasalonenzap"
$share = "zap"
$plan = "learn_plan"
$app = "oasalonen-hello-express"

az group create -n $group -l $location --subscription $subscription

# Create the App Service to host the API
az appservice plan create -n $plan -g $group --subscription $subscription --sku Free

az webapp create -n $app -p $plan -g $group --subscription $subscription

# Create the Storage File share for ZAP to publish reports to
az storage account create -n $storage --sku Standard_LRS -g $group -l $location --subscription $subscription

$storage_connection_string=$(az storage account show-connection-string -n $storage -g $group -o tsv --subscription $subscription)

az storage share create -n $share --connection-string $storage_connection_string --subscription $subscription

# Static website to host HTML reports in
az storage blob service-properties update --account-name $storage --static-website --404-document error.html --index-document index.html