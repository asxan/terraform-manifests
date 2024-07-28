
# Cloud Router for Nat Gateway
resource "google_compute_router" "custom_net_us_central_nat_router" {
  depends_on = [google_compute_network.custom_net]
  name       = "custom-net-us-central-nat-router"
  project    = var.project_id
  network    = google_compute_network.custom_net.id
  region     = var.us-region
}

# Nat Gateway
resource "google_compute_router_nat" "custom_net_nat_us_central" {
  depends_on                         = [google_compute_router.custom_net_us_central_nat_router]
  name                               = "custom-net-nat-us-central"
  router                             = google_compute_router.custom_net_us_central_nat_router.name
  region                             = var.us-region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}