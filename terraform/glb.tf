

# forwarding rule

resource "google_compute_global_forwarding_rule" "prod_lb_global_forwarding_rule" {
  depends_on = [
    google_compute_target_https_proxy.prod_lb_http_proxy,
    google_compute_global_address.external_static_ip
  ]

  name                  = "prod-lb-gl-fw-rule"
  description           = "Prod https load balancer global forwarding rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.prod_lb_http_proxy.id
  ip_address            = google_compute_global_address.external_static_ip.id
}


# http proxy
resource "google_compute_target_https_proxy" "prod_lb_http_proxy" {
  depends_on = [
    google_compute_url_map.prod_lb_url_map,
    google_compute_ssl_certificate.prod_easyio_tls_certs
  ]
  name        = "prod-lb-http-proxy"
  description = "Prod https load balancer target http proxy"
  url_map     = google_compute_url_map.prod_lb_url_map.id
  ssl_certificates = [google_compute_ssl_certificate.prod_easyio_tls_certs.id]
}

# url map
resource "google_compute_url_map" "prod_lb_url_map" {
  depends_on = [
    google_compute_health_check.http_health_check,
    google_compute_backend_service.prod_us_central_backend
  ]

  name = "prod-lb-url-map"

  description     = "Prod https load balancer url map"
  default_service = google_compute_backend_service.prod_us_central_backend.id

  host_rule {
    hosts        = ["easyio.asxan.fun."]
    path_matcher = "easyio"
  }

  path_matcher {
    name            = "easyio"
    default_service = google_compute_backend_service.prod_us_central_backend.self_link

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.prod_us_central_backend.self_link
    }
  }
}