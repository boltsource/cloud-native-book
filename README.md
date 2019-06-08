# Setting up Infrastructure

Login to GCloud
```bash
gcloud auth login
```

Set the compute zone
```bash
gcloud config set compute/zone us-central1-a
```

Create a project
```bash
gcloud projects create tf-gcp-gql
```

Get existing organizational billing accounts
```bash
gcloud beta billing accounts list
```

Link an existing billing account to the project
```bash
gcloud beta billing projects link tf-gcp-gql --billing-account=<YOUR BILLING ACCOUNT ID>"
```

Set the active project
```bash
gcloud config set project tf-gcp-gql
```

Enabled the Cloud Resource Manager API for the project
```bash
gcloud services enable cloudresourcemanager.googleapis.com 
```

Create the terraform service account
```bash
gcloud beta iam service-accounts create sa-terraform \
    --description "Terraform service account" \
    --display-name "Terraform SA"
```

Grant the service account ownership roles (for the sake of brevity)
```bash
gcloud projects add-iam-policy-binding tf-gcp-gql \
--member serviceAccount:sa-terraform@tf-gcp-gql.iam.gserviceaccount.com \
--role roles/owner
```


Create a local key for the service account
```bash
gcloud iam service-accounts keys create ~/.terraform/service-account.json --iam-account sa-terraform@tf-gcp-gql.iam.gserviceaccount.com
```

**Temporary** Visit the UI to enable billing on Google Cloud Storage page

Create a storage bucket to store terraform state
```bash
gsutil mb -p tf-gcp-gql gs://tf-gcp-gql-tf-state
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

Configure `kubectl`
```bash
gcloud container clusters get-credentials main-cluster-v2
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
