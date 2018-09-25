resource "digitalocean_loadbalancer" "public" {
  name = "lb-public.${var.dc_domain}"
  region = "${var.digitalocean_region}"

  redirect_http_to_https = true

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port = 443
    entry_protocol = "https"

    target_port = 443
    target_protocol = "https"

    tls_passthrough = true
  }

  healthcheck {
    port = 80
    protocol = "tcp"
  }

  droplet_tag = "${var.tag_web_servers}"
}