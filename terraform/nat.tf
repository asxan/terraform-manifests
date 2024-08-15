
# Cloud Router for Nat Gateway in us-central1
resource "google_compute_router" "prod_net_us_central_nat_router" {
  depends_on = [google_compute_network.prod_network]
  name       = "prod-net-us-central-nat-router"
  project    = var.project_id
  network    = google_compute_network.prod_network.self_link
  region     = var.us-region
}

# Nat gateway in us-central1
resource "google_compute_router_nat" "prod_net_us_central_nat" {
  depends_on = [
    google_compute_network.prod_network,
    google_compute_router.prod_net_us_central_nat_router
  ]
  name                               = "prod-net-us-central-nat"
  router                             = google_compute_router.prod_net_us_central_nat_router.name
  region                             = var.us-region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


# Cloud Router for Nat Gateway in us-central1
resource "google_compute_router" "prod_net_europe_north_nat_router" {
  depends_on = [
    google_compute_network.prod_network
  ]
  name    = "prod-net-europe-north-nat-router"
  project = var.project_id
  network = google_compute_network.prod_network.self_link
  region  = var.eu-region
}

# Nat gateway in us-central1
resource "google_compute_router_nat" "prod_net_europe_north_nat" {
  depends_on = [
    google_compute_network.prod_network,
    google_compute_router.prod_net_europe_north_nat_router
  ]
  name                               = "prod-net-europe-north-nat"
  router                             = google_compute_router.prod_net_europe_north_nat_router.name
  region                             = var.eu-region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}