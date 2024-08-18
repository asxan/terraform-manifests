# Data Sources

# Data source TLS certificate chain ( public key and CA certificate ) from GCP Secret Manager `KMS`
#
data "google_secret_manager_secret_version" "easyio_ssl_chain" {
  secret  = "easyio_ssl_chain"
  project = var.project_id
  version = "1"
}

# Data source TLS certificate  ( private key ) from GCP Secret Manager `KMS`
#
data "google_secret_manager_secret_version" "easyio_ssl_priv_key" {
  secret  = "easyio_ssl_priv_key"
  project = var.project_id
  version = "1"
}
