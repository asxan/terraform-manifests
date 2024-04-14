resource "google_compute_instance" "custom_nginx_instance" {
  depends_on = [
    google_compute_subnetwork.custom_europe_west3_subnetwork,
    google_compute_address.internal_custom_ip,
    google_compute_address.external_custom_ip
  ]
  machine_type = "e2-medium"
  name         = "custom-nginx"
  project      = var.project_id
  zone         = "${var.region}-a"

  boot_disk {
    auto_delete = true
    initialize_params {
      size  = 20
      type  = "pd-standard"
      image = var.image
      labels = {
        disk_type = "standard"
      }
    }
  }

  network_interface {
    network    = google_compute_network.custom_network.self_link
    subnetwork = google_compute_subnetwork.custom_europe_west3_subnetwork.self_link
    network_ip = google_compute_address.internal_custom_ip.address
    access_config {
      nat_ip = google_compute_address.external_custom_ip.address
    }
  }

  tags = [
    "allow-ssh-custom", "http-server"
  ]

  labels = {
    app = "nginx"
  }
}