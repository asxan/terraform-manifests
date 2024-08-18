terraform {
  backend "gcs" {
    bucket = "tf-task-3"
    prefix = "terraform/state"
    versioning = true
  }
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}
