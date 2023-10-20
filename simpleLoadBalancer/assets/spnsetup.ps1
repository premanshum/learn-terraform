# Login to Azure using your credentials
az login

# Create an SPN, only if you are Owner of Subscription or have User Access Management role
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/df43b9ea-cec5-46f2-ace2-622430cfc26d" --display-name "spn-prem-cpl"

# Alternatively, create an SPN via Admiral and provide the Contributor role.
# For this case, use service-principal spn-prem-cpl (appid: eec83b7b-fb97-4af5-a989-ffcd18e8df9d)

az login --service-principal -u eec83b7b-fb97-4af5-a989-ffcd18e8df9d -p rIt8Q~DAU-ALHl30UIyqG~dVtLz~qeMdSTYVGdm4 --tenant 05d75c05-fa1a-42e7-9cf1-eb416c396f2d

# Set environment variables for Azure login
$env:ARM_CLIENT_ID = "eec83b7b-fb97-4af5-a989-ffcd18e8df9d"
$env:ARM_CLIENT_SECRET = "rIt8Q~DAU-ALHl30UIyqG~dVtLz~qeMdSTYVGdm4"
$env:ARM_SUBSCRIPTION_ID = "df43b9ea-cec5-46f2-ace2-622430cfc26d"
$env:ARM_TENANT_ID = "05d75c05-fa1a-42e7-9cf1-eb416c396f2d"