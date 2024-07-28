terraform {
  backend "gcs" {
    bucket = "tf-task-2"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

provider "time" {
  # Configuration options
}