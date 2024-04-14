resource "google_compute_network" "custom_network" {
  project                 = var.project_id
  name                    = "custom-net"
  description             = "Custom vpc for first terraform task"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "custom_europe_west3_subnetwork" {
  depends_on    = [google_compute_network.custom_network]
  name          = "custom-europe-west3-subnetwork"
  network       = google_compute_network.custom_network.id
  region        = var.region
  ip_cidr_range = "192.168.10.0/24"
}