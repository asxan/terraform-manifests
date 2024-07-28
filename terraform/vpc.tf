resource "google_compute_network" "custom_net" {
  name                    = "custom-net"
  project                 = var.project_id
  description             = "Custom vpc with two subnets in us-central1 and europe-north-1 regions"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom_net_subnet_us_central1" {
  depends_on    = [google_compute_network.custom_net]
  name          = "custom-net-subnet-uc1"
  network       = google_compute_network.custom_net.id
  region        = "us-central1"
  ip_cidr_range = "10.128.0.0/20"
}

resource "google_compute_subnetwork" "custom_net_subnet_europe_north1" {
  depends_on    = [google_compute_network.custom_net]
  name          = "custom-net-subnet-en1"
  network       = google_compute_network.custom_net.id
  region        = "europe-north1"
  ip_cidr_range = "10.166.0.0/20"
}

resource "google_compute_network" "bastion_net" {
  name                    = "bastion-net"
  project                 = var.project_id
  description             = "Bastion vpc with one subnet in europe-north-1 regions"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "bastion_net_subnet_europe_north1" {
  depends_on    = [google_compute_network.bastion_net]
  name          = "bastion-net-subnet-en1"
  network       = google_compute_network.bastion_net.id
  region        = "europe-north1"
  ip_cidr_range = "192.168.0.0/20"
}