resource "google_compute_firewall" "allow_all_internal_custom" {
  depends_on = [google_compute_network.custom_network]

  name    = "allow-all-internal-custom"
  network = google_compute_network.custom_network.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "192.168.10.0/24"
  ]

  allow {
    protocol = "all"
  }
}


resource "google_compute_firewall" "allow_icmp_custom" {
  depends_on = [google_compute_network.custom_network]

  name    = "allow-icmp-custom"
  network = google_compute_network.custom_network.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "0.0.0.0/0"
  ]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_ssh_custom" {
  depends_on = [google_compute_network.custom_network]

  name    = "allow-ssh-custom"
  network = google_compute_network.custom_network.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "0.0.0.0/0"
  ]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["allow-ssh-custom"]
}


resource "google_compute_firewall" "allow_http_custom_net" {
  depends_on = [google_compute_network.custom_network]

  name    = "allow-http-custom-net"
  network = google_compute_network.custom_network.name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "0.0.0.0/0"
  ]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-server"]
}
