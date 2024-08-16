
resource "google_compute_instance_template" "nginx_template_us_central" {
  depends_on = [
    google_compute_network.prod_network,
    google_compute_subnetwork.prod_subnet_us_central
  ]

  name         = "nginx-template-us-central"
  project      = var.project_id
  machine_type = "e2-medium"
  tags         = ["prod-vms"]

  network_interface {
    network    = google_compute_network.prod_network.self_link
    subnetwork = google_compute_subnetwork.prod_subnet_us_central.self_link
  }

  disk {
    disk_name    = "nginx-us-central1"
    source_image = var.image_name
    boot         = true
    disk_size_gb = 20
  }

  lifecycle {
    create_before_destroy = false
  }
}


resource "google_compute_instance_template" "nginx_template_europe_west" {
  depends_on = [
    google_compute_network.prod_network,
    google_compute_subnetwork.prod_subnet_eu_region
  ]

  name         = "nginx-template-europe-west"
  project      = var.project_id
  machine_type = "e2-medium"
  tags         = ["prod-vms"]

  network_interface {
    network    = google_compute_network.prod_network.self_link
    subnetwork = google_compute_subnetwork.prod_subnet_eu_region.self_link
  }

  disk {
    disk_name    = "nginx-europe-west1"
    source_image = var.image_name
    boot         = true
    disk_size_gb = 20
  }

  lifecycle {
    create_before_destroy = false
  }
}