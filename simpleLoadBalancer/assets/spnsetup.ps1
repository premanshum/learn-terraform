# Login to Azure using your credentials
az login

# Create an SPN, only if you are Owner of Subscription or have User Access Management role
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription-guid>" --display-name "spn-prem-cpl"

# Alternatively, create an SPN via Admiral and provide the Contributor role.
# For this case, use service-principal s_p_n-p_r_e_m-cpl (appid: <guid>)

# Set environment variables for Azure login
$env:ARM_CLIENT_ID = ""
$env:ARM_CLIENT_SECRET = ""
$env:ARM_SUBSCRIPTION_ID = ""
$env:ARM_TENANT_ID = ""

az login --service-principal -u <CLIENT_ID> -p <CLIENT_SECRET> --tenant <TENANT_ID>
