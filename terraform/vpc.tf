# Google Compute networks and subnets

# Google Prod VPC
#
resource "google_compute_network" "prod_network" {
  name                    = "prod-net"
  project                 = var.project_id
  description             = "Production VPC"
  auto_create_subnetworks = false
}

# Subnet on prod vpc in us-central1 region
#
resource "google_compute_subnetwork" "prod_subnet_us_central" {
  depends_on    = [google_compute_network.prod_network]
  name          = "prod-subnet-us-central"
  network       = google_compute_network.prod_network.self_link
  region        = var.us-region
  ip_cidr_range = "10.128.10.0/24"
}

# Subnet on prod vpc in eu-west3 region
#
resource "google_compute_subnetwork" "prod_subnet_eu_region" {
  depends_on    = [google_compute_network.prod_network]
  name          = "prod-subnet-eu-region"
  network       = google_compute_network.prod_network.self_link
  region        = var.eu-region
  ip_cidr_range = "10.128.20.0/24"
}
