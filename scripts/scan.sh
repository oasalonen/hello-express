# Script to run OWASP ZAP in an Azure Container Instance and download its reports

apispec=https://oasalonen-hello-express.azurewebsites.net/openapi
group=learn
container=zap
location=westeurope
share=zap
storage=oasalonenzap

storage_key=`az storage account keys list -g $group -n $storage --query "[0].value" -o tsv`

# Create the ACI and run the scan
az container create -g $group -n $container -l $location \
    --image owasp/zap2docker-stable --ip-address Private --memory 0.5 --restart-policy Never \
    --command-line "zap-api-scan.py -t $apispec -f openapi -r report.html -x report.xml -J report_json" \
    --azure-file-volume-account-name $storage \
    --azure-file-volume-account-key $storage_key \
    --azure-file-volume-share-name $share \
    --azure-file-volume-mount-path /zap/wrk

# Cleanup the ACI
az container delete -g $group -n $container --yes

# Download the reports
az storage file download -s $share -p report.html --account-key $storage_key --account-name $storage
az storage file download -s $share -p report.xml --account-key $storage_key --account-name $storage

# Upload HTML report
# Viewable at https://oasalonenzap.z6.web.core.windows.net/report.html
az storage blob upload -f report.html -c '$web' -n report.html --account-name $storage --account-key $storage_key --content-type 'text/html; charset=utf-8'