This guide provides a detailed walkthrough for creating a reusable and automated system to provision new Google Cloud Platform (GCP) projects using Terraform, Python, and YAML.

## Project Goal

The primary goal is to build a small, working setup that can:

1. Take a simple YAML configuration file with project details.
2. Use that configuration to generate a new, fully-configured GCP project automatically.
3. Be easy enough for anyone on a team to reuse without needing to write or understand complex Terraform code for every new project.
## 1. Prerequisites

Before you begin, ensure you have the following installed and configured:

- **GCP Account & Permissions:**
    - An active GCP account.
    - An Organization ID and a Billing Account ID.
    - A user or service account with the following IAM roles at the Organization level
        - `Project Creator`
        - `Billing Account User`
        - `Service Usage Admin`
- **Terraform:** [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli "null").
- **Google Cloud SDK (`gcloud`):** [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install "null").
- **Python:** [Install Python](https://www.python.org/downloads/ "null") (version 3.7 or newer) and `pip`.
- **Git:** [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git "null").

Authenticate with GCP for local execution:

```
gcloud auth application-default login
```

Or Authenticate using json file

```
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/the/json/secret/marwankonecta-123456789.json"
```

## 2. Set Up the Terraform State Backend

For Terraform to work in a CI/CD environment, its state must be stored remotely, for security and team collaboaration, to avoid clashes. A Google Cloud Storage (GCS) bucket must be made for this purpose before running any automation.

1. **Choose a Globally Unique Bucket Name:** For example, `konecta-tf-state-12345`.
2. **Create the GCS Bucket (through gcloud):**
```
gcloud config set project your-gcp-project
gsutil mb -p your-gcp-project-for-state gs://konecta-tf-state-12345/
```

3. **Enable Object Versioning:** This is crucial for protecting your state file from accidental deletion or corruption.
```
gsutil versioning set on gs://konecta-tf-state-12345/
```

4. Ensure the `backend.tf` has the same name
## 3. Setting Up The Project Structure (Terraform, YAML, and Python Script Setup)

Creating the directories and empty files for the project.

## 4. Running the Automation Manually
Note: to run an already made project, the yaml and script assumes that the project name isn't directly connected or taken, to overcome this, import the name using this command:
```
terraform import module.project_factory.google_project.project projectname
```
1. Navigate to the root of the project directory.
2. Execute the Python script, passing the config file as an argument:

```
source venv/bin/activate
python3 scripts/deploy.py configs/example-project.yaml
```

Terraform will now automatically initialize with the GCS backend.

## 5. Automating with GitHub Actions (CI/CD)

The provided `.github/workflows/cicd.yml` file will trigger a deployment whenever a new *.yaml* file is pushed to the configs directory. With the GCS backend configured, this workflow will now function correctly.
### Setup Instructions

1. **Create the Workflow File
2. **Configure GCP for Workload Identity Federation:** This is the most secure way to authenticate. It avoids storing long-lived service account keys.
    - Create a Workload Identity Pool, a Provider, and a Service Account.
    - Grant the Service Account the permissions listed in the "Prerequisites" section at the Organization level.
    - Also, grant this Service Account the `Storage Object Admin` role on the bucket created for the Terraform state. This is required for the CI/CD pipeline to read and write the state file.
3. **Add those Secrets to the GitHub Repository:** Go to your repository's `Settings` > `Secrets and variables` > `Actions` and add the required secrets as described previously.

## 6. Destroying Resources

To tear down all resources managed by a specific configuration file, use the `destroy.py` script. It will use the remote state file in GCS to know what to destroy.

```
# To destroy the project
python3 scripts/destroy.py configs/example-project.yaml
```