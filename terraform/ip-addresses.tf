# External and internal ip addresses

# Internal ip address
resource "google_compute_address" "bastion_host_internal" {
  depends_on = [google_compute_subnetwork.bastion_net_subnet_europe_north1]

  name         = "bastion-host-internal"
  region       = "europe-north1"
  subnetwork   = google_compute_subnetwork.bastion_net_subnet_europe_north1.self_link
  address_type = "INTERNAL"
  address      = "192.168.0.2"
}

resource "google_compute_address" "jenkins_instance" {
  depends_on = [google_compute_subnetwork.custom_net_subnet_us_central1]

  name         = "jenkins-instance"
  region       = "us-central1"
  subnetwork   = google_compute_subnetwork.custom_net_subnet_us_central1.self_link
  address_type = "INTERNAL"
  address      = "10.128.0.2"
}

resource "google_compute_address" "nginx_instance_internal" {
  depends_on = [google_compute_subnetwork.custom_net_subnet_europe_north1]

  name         = "nginx-instance-internal"
  region       = "europe-north1"
  subnetwork   = google_compute_subnetwork.custom_net_subnet_europe_north1.self_link
  address_type = "INTERNAL"
  address      = "10.166.0.2"
}


# External ip address

resource "google_compute_address" "nginx_external_ip" {
  depends_on = [google_compute_subnetwork.custom_net_subnet_europe_north1]

  name         = "nginx-external-ip"
  region       = "europe-north1"
  address_type = "EXTERNAL"
}