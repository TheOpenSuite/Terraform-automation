terraform {
  backend "gcs" {
    bucket = "bucket-tf-state-konecta"
    prefix = "gcp-autoproject/terraform.tfstate"
  }
}

