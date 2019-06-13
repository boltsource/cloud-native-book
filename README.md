# Setting up the Project

Login to GCloud
```bash
gcloud auth login
```

Set the compute zone
```bash
gcloud config set compute/zone us-central1-a
```

Set environment variable for project id
```bash
PROJECT_ID=tf-gcp-gql
```

Create a project
```bash
gcloud projects create $PROJECT_ID
```

Get existing organizational billing accounts
```bash
gcloud beta billing accounts list
```

Link an existing billing account to the project
```bash
gcloud beta billing projects link $PROJECT_ID --billing-account=<YOUR BILLING ACCOUNT ID>
```

Set the active project
```bash
gcloud config set project $PROJECT_ID
```

Enabled the Cloud Resource Manager API for the project
```bash
gcloud services enable cloudresourcemanager.googleapis.com 
```

Configure `docker` credentials to use GCR
```
gcloud auth configure-docker
```

Create the terraform service account
```bash
gcloud beta iam service-accounts create sa-terraform \
    --description "Terraform service account" \
    --display-name "Terraform SA"
```

Grant the service account ownership roles (for the sake of brevity)
```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:sa-terraform@$PROJECT_ID.iam.gserviceaccount.com \
    --role roles/owner
```


Create a local key for the service account
```bash
gcloud iam service-accounts keys create ~/.terraform/service-account.json \
    --iam-account sa-terraform@$PROJECT_ID.iam.gserviceaccount.com
```

**Temporary** Visit the UI to enable billing on Google Cloud Storage page

Create a storage bucket to store terraform state
```bash
gsutil mb -p $PROJECT_ID gs://$PROJECT_ID-tf-state
```

Setup a basic terraform file in `ops/terraform/main.tf`

Init the project
```bash
terraform init ops/terraform
```

Add GKE in `ops/terraform/gke`

Apply the changes to create the GKE cluster
```bash
terraform apply ops/terraform
```

Configure `kubectl` credentials to use GKE
```bash
gcloud container clusters get-credentials main-cluster
```


Add SQL (Postgres) in `ops/terraform/sql`

Apply the changes to create the Postgres instance
```bash
terraform apply ops/terraform
```

Test connectivity between GKE and Cloud SQL

```bash

```

Add Memorystore (Redis) in `ops/terraform/memorystore.tf`

Apply the changes to create the Redis instance
```bash
terraform apply ops/terraform
```


# Enable Google Cloud Registry
```bash
gcloud auth configure-docker
```

# Creating the API
