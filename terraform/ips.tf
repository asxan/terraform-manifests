# External ip for GCP Global HTTPS Load Balancer
#
resource "google_compute_global_address" "external_static_ip" {
  name         = "external-static-ip"
  address_type = "EXTERNAL"
  description  = "External ip for global https lb"
}

