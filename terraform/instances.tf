# GCE VM instances

resource "google_compute_instance" "bastion_host" {
  depends_on = [google_compute_network.bastion_net,
    google_compute_subnetwork.bastion_net_subnet_europe_north1,
    google_compute_address.bastion_host_internal
  ]

  name         = "bastion-host"
  machine_type = "e2-medium"
  zone         = "europe-north1-a"

  boot_disk {
    device_name = "bastion-host"
    auto_delete = true
    initialize_params {
      image = "bastion-host"
      size  = 20
      type  = "pd-balanced"
    }
  }

  tags = ["bastion-ssh"]

  network_interface {
    network    = google_compute_network.bastion_net.self_link
    subnetwork = google_compute_subnetwork.bastion_net_subnet_europe_north1.self_link
    network_ip = google_compute_address.bastion_host_internal.address

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_compute_instance" "jenkins_instance" {
  depends_on = [google_compute_network.custom_net,
    google_compute_subnetwork.custom_net_subnet_us_central1,
    google_compute_address.jenkins_instance,
    google_compute_firewall.bastion_custom_ssh
  ]

  name         = "jenkins-instance"
  machine_type = "e2-medium"

  zone = "us-central1-a"

  boot_disk {
    device_name = "jenkins-instance"
    auto_delete = true
    initialize_params {
      image = "centos-stream-9-v20240515"
      size  = 20
      type  = "pd-balanced"
    }
  }

  tags = ["bastion-custom-ssh"]

  network_interface {
    network    = google_compute_network.custom_net.self_link
    subnetwork = google_compute_subnetwork.custom_net_subnet_us_central1.self_link
    network_ip = google_compute_address.jenkins_instance.address
  }
}


resource "time_sleep" "nginx_external_ip" {
  create_duration = "120s"
  depends_on      = [google_compute_address.nginx_external_ip]
}


resource "google_compute_instance" "nginx_instance" {
  depends_on = [
    google_compute_network.custom_net,
    google_compute_subnetwork.bastion_net_subnet_europe_north1,
    google_compute_address.nginx_instance_internal,
    google_compute_firewall.custom_net_allow_https,
    google_compute_firewall.bastion_custom_ssh,
    time_sleep.nginx_external_ip
  ]

  name         = "nginx-instance"
  machine_type = "e2-medium"

  zone = "europe-north1-a"

  boot_disk {
    device_name = "nginx-instance"
    auto_delete = true
    initialize_params {
      # centos-stream-9
      image = "nginx-reverse-jenkins"
      size  = 20
      type  = "pd-balanced"
    }
  }

  tags = ["allow-https", "bastion-custom-ssh"]

  network_interface {
    network    = google_compute_network.custom_net.self_link
    subnetwork = google_compute_subnetwork.custom_net_subnet_europe_north1.self_link
    network_ip = google_compute_address.nginx_instance_internal.address

    access_config {
      nat_ip = google_compute_address.nginx_external_ip.address
    }
  }
}