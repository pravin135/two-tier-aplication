provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("credentials.json")
}

terraform {
  backend "gcs" {
    bucket = "tf-state-prod315"
    prefix = "terraform/tfstate"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"

}