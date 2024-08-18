# Google Compute Load Balancer Backend

# Google Compute Backend for Global HTTPS Load Balancer
#
resource "google_compute_backend_service" "prod_us_central_backend" {
  depends_on = [
    google_compute_health_check.http_health_check,
    google_compute_region_instance_group_manager.prod_mig_eu_west3,
    google_compute_region_instance_group_manager.prod_mig_us_central1
  ]

  name                  = "prod-us-central-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  enable_cdn            = false
  health_checks         = [google_compute_health_check.http_health_check.id]

  backend {
    group                 = google_compute_region_instance_group_manager.prod_mig_us_central1.instance_group
    balancing_mode        = "RATE"
    capacity_scaler       = 1
    max_rate_per_instance = 50
  }

  backend {
    group                 = google_compute_region_instance_group_manager.prod_mig_eu_west3.instance_group
    balancing_mode        = "RATE"
    capacity_scaler       = 1
    max_rate_per_instance = 50
  }
}
