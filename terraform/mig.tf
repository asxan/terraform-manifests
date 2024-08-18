# Manage Instance groups

# GCP global health check to check the health of instances in the MIG's
#
resource "google_compute_health_check" "http_health_check" {
  name = "http-health-check"

  description = "Health check via http"

  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  tcp_health_check {
    port = "80"
  }
}

# GCP Managed instance group in us-central region in prod network
#
resource "google_compute_region_instance_group_manager" "prod_mig_us_central1" {
  depends_on = [
    google_compute_instance_template.nginx_template_us_central,
    google_compute_health_check.http_health_check
  ]

  name               = "nginx-app-us"
  description        = "The prod region MIG in us-central1 region"
  region             = var.us-region
  project            = var.project_id
  base_instance_name = "nginx-us"

  named_port {
    name = "http"
    port = 80
  }

  version {
    instance_template = google_compute_instance_template.nginx_template_us_central.self_link
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http_health_check.self_link
    initial_delay_sec = 60
  }
}

# GCP Autoscaling policy for MIG in us-central1 region
#
resource "google_compute_region_autoscaler" "prod_autoscaler_us_central1" {
  depends_on = [
    google_compute_region_instance_group_manager.prod_mig_us_central1
  ]
  name        = "prod-autoscaler-us"
  description = "The prod region MIG autoscaler in us-central1 region"
  region      = var.us-region
  target      = google_compute_region_instance_group_manager.prod_mig_us_central1.id

  autoscaling_policy {
    max_replicas    = 0
    min_replicas    = 0
    cooldown_period = 60

    load_balancing_utilization {
      target = 0.8
    }
  }
}

# GCP Managed instance group in eu-west3 region in prod network
#
resource "google_compute_region_instance_group_manager" "prod_mig_eu_west3" {
  depends_on = [
    google_compute_instance_template.nginx_template_europe_west,
    google_compute_health_check.http_health_check
  ]
  name               = "nginx-app-eu"
  description        = "The prod region MIG in eu-west3 region"
  region             = var.eu-region
  project            = var.project_id
  base_instance_name = "nginx-eu"

  named_port {
    name = "http"
    port = 80
  }

  version {
    instance_template = google_compute_instance_template.nginx_template_europe_west.self_link
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http_health_check.self_link
    initial_delay_sec = 60
  }
}

# GCP Autoscaling policy for MIG in eu-west3 region
#
resource "google_compute_region_autoscaler" "prod_autoscaler_eu_west3" {
  depends_on = [
    google_compute_region_instance_group_manager.prod_mig_eu_west3
  ]
  name        = "prod-autoscaler-eu"
  description = "The prod region MIG autoscaler in eu-west3 region"
  region      = var.eu-region
  target      = google_compute_region_instance_group_manager.prod_mig_eu_west3.id

  autoscaling_policy {
    max_replicas    = 0
    min_replicas    = 0
    cooldown_period = 60

    load_balancing_utilization {
      target = 0.8
    }
  }
}
