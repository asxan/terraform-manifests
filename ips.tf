resource "google_compute_address" "internal_custom_ip" {
  depends_on = [google_compute_subnetwork.custom_europe_west3_subnetwork]

  name         = "internal-custom-ip"
  project      = var.project_id
  subnetwork   = google_compute_subnetwork.custom_europe_west3_subnetwork.id
  address_type = "INTERNAL"
  region       = var.region
}

resource "google_compute_address" "external_custom_ip" {
  name         = "external-custom-ip"
  project      = var.project_id
  address_type = "EXTERNAL"
  region       = var.region
}