# Peering connection

resource "google_compute_network_peering" "bastion_custom_vpc_peering" {
  depends_on   = [google_compute_network.custom_net, google_compute_network.bastion_net]
  name         = "bastion-custom-vpc-peering"
  network      = google_compute_network.bastion_net.self_link
  peer_network = google_compute_network.custom_net.self_link
}

resource "google_compute_network_peering" "custom_bastion_vpc_peering" {
  depends_on   = [google_compute_network.custom_net, google_compute_network.bastion_net]
  name         = "custom-bastion-vpc-peering"
  network      = google_compute_network.custom_net.self_link
  peer_network = google_compute_network.bastion_net.self_link
}