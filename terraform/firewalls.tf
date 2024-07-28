# Firewall rules

resource "google_compute_firewall" "bastion_net_allow_custom" {
  depends_on = [google_compute_network.bastion_net]

  name        = "bastion-net-allow-custom"
  network     = google_compute_network.bastion_net.self_link
  description = "Firewall rule to allow all traffic inside the bastion-net network"

  direction     = "INGRESS"
  source_ranges = ["192.168.0.0/20"]

  allow {
    protocol = "all"
  }
}


resource "google_compute_firewall" "bastion_net_allow_icmp" {
  depends_on  = [google_compute_network.bastion_net]
  name        = "bastion-net-allow-icmp"
  network     = google_compute_network.bastion_net.self_link
  description = "Firewall rule to allow all icmp traffic inside the bastion-net network"

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}


resource "google_compute_firewall" "bastion_net_allow_ssh" {
  depends_on  = [google_compute_network.bastion_net]
  name        = "bastion-net-allow-ssh"
  network     = google_compute_network.bastion_net.self_link
  description = "Allows TCP connections from any source to instances with the tag in the network using port 2222."

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  target_tags = ["bastion-ssh"]

  allow {
    protocol = "tcp"
    ports    = ["33000"]
  }
}


resource "google_compute_firewall" "bastion_custom_ssh" {
  depends_on  = [google_compute_network.custom_net]
  name        = "bastion-custom-ssh"
  network     = google_compute_network.custom_net.self_link
  description = "The firewall rule to allow ssh traffic from the bastion vpc to the custom vpc"

  direction     = "INGRESS"
  source_ranges = ["192.168.0.0/20"]
  target_tags   = ["bastion-custom-ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}


resource "google_compute_firewall" "custom_net_allow_https" {
  depends_on = [google_compute_network.custom_net]

  name        = "custom-net-allow-http"
  network     = google_compute_network.custom_net.self_link
  description = "The firewall rule to allow http traffic from anywhere to instances with specific tag"

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-https"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}


resource "google_compute_firewall" "custom_net_allow_custom" {
  depends_on = [google_compute_network.custom_net]

  name        = "custom-net-allow-custom"
  network     = google_compute_network.custom_net.self_link
  description = "Firewall rule to allow all traffic inside the custom-net network"

  direction     = "INGRESS"
  source_ranges = ["10.166.0.0/20", "10.128.0.0/20"]

  allow {
    protocol = "all"
  }
}


resource "google_compute_firewall" "custom_net_allow_icmp" {
  depends_on  = [google_compute_network.custom_net]
  name        = "custom-net-allow-icmp"
  network     = google_compute_network.custom_net.self_link
  description = "Allows ICMP connections from any source to any instance on the network"

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}