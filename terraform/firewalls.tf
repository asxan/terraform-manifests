# Firewall rules

resource "google_compute_firewall" "allow_all_internal_traffic" {
  depends_on = [google_compute_network.prod_network]

  name        = "allow-all-internal-traffic"
  network     = google_compute_network.prod_network.self_link
  description = "Firewall rule to allow all traffic inside the prod-network"
  direction   = "INGRESS"

  target_tags   = ["prod-vms"]
  source_ranges = ["10.128.0.0/16"]

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "allow_ssh_iap_access" {
  depends_on  = [google_compute_network.prod_network]
  name        = "allow-ssh-iap-access-prod-net"
  network     = google_compute_network.prod_network.self_link
  description = "Firewall rule to allow ssh access via IAP"
  direction   = "INGRESS"

  target_tags   = ["prod-vms"]
  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "fw_allow_health_checks" {
  depends_on  = [google_compute_network.prod_network]
  name        = "fw-allow-health-checks"
  network     = google_compute_network.prod_network.self_link
  description = "Firewall rule to allow health checks to instances in the prod-network"
  direction   = "INGRESS"

  target_tags   = ["prod-vms"]
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}