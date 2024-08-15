# external ip for global https lb
resource "google_compute_global_address" "external_static_ip" {
  name         = "external-static-ip"
  address_type = "EXTERNAL"
  description  = "External ip for global https lb"
}

