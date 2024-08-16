
resource "google_compute_ssl_certificate" "prod_easyio_tls_certs" {
  name        = "prod-easyio-tls-certs"
  private_key = data.google_secret_manager_secret_version.easyio_ssl_priv_key.secret_data
  certificate = data.google_secret_manager_secret_version.easyio_ssl_chain.secret_data
}