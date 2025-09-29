terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  credentials = file("/media/linfut/Secondary/Courses/DevOps/Related Stuff/Intern/Hands-on/Task 2/marwankonecta2-44d13da4480b.json")
  region      = var.region
  scopes      = ["https://www.googleapis.com/auth/cloud-platform"]
}

module "project_factory" {
  source            = "./modules/project"
  project_id        = var.project_id
  billing_account   = var.billing_account
  labels            = var.labels
  apis              = var.apis
}

module "network_vpc" {
  source     = "./modules/network-vpc"
  # FIX 1: Corrected project_factory output reference
  project_id = module.project_factory.project_id
  region     = var.region
  depends_on = [module.project_factory]
}

module "security_iap_access" {
  source            = "./modules/security-iap-access"
  # FIX 1: Corrected project_factory output reference
  project_id        = module.project_factory.project_id
  iap_support_email = var.iap_support_email
  # FIX 2: Corrected network_vpc output reference
  network_name      = module.network_vpc.vpc_self_link 
  depends_on        = [module.network_vpc]
}

module "iam_service_account" {
  source         = "./modules/iam-service-account"
  # FIX 1: Corrected project_factory output reference
  project_id     = module.project_factory.project_id
  account_id     = "app-runner-sa"
  display_name   = "Application Runner Service Account"
  roles = [
    "roles/run.invoker",
    "roles/storage.objectAdmin"
  ]
  depends_on = [module.project_factory]
}

module "datastore_sql" {
  source     = "./modules/datastore-sql"
  # FIX 1: Corrected project_factory output reference
  project_id = module.project_factory.project_id
  region     = var.region
  # FIX 2: Corrected network_vpc output reference
  network_id = module.network_vpc.vpc_id
  depends_on = [module.network_vpc]
}

module "datastore_storage" {
  source      = "./modules/datastore-storage"
  # FIX 1: Corrected project_factory output reference
  project_id  = module.project_factory.project_id
  bucket_name = "${var.project_id}-app-data"
  location    = var.region
  depends_on  = [module.project_factory]
}

module "application_cloud_run" {
  source         = "./modules/application-cloud-run"
  # FIX 1: Corrected project_factory output reference
  project_id     = module.project_factory.project_id
  service_name   = "${var.project_id}-hello-service"
  region         = var.region
  depends_on     = [module.project_factory]
}

module "secrets_manager" {
  source                 = "./modules/secrets-manager"
  # FIX 1: Corrected project_factory output reference
  project_id             = module.project_factory.project_id
  secret_id              = "database-password"
  secret_data            = "a-very-secret-password"
  # FIX 3: Corrected iam_service_account output reference
  service_account_member = "serviceAccount:${module.iam_service_account.service_account_email}"
  depends_on             = [module.iam_service_account]
}

module "monitoring_alarms" {
  source      = "./modules/monitoring-alarms"
  # FIX 1: Corrected project_factory output reference
  project_id  = module.project_factory.project_id
  alert_email = var.alert_email
  depends_on  = [module.project_factory]
}

module "logging_sinks" {
  source                     = "./modules/logging-sinks"
  # FIX 1: Corrected project_factory output reference
  project_id                 = module.project_factory.project_id
  log_destination_project_id = var.project_id # For simplicity, sending logs to the same project.
  depends_on                 = [module.project_factory]
}
