provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

provider "powerdns" {
  api_key = "${var.powerdns_api_key}"
  server_url = "http://${var.dns_public_ip}:${var.powerdns_api_port}"
}