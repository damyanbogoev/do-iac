provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

provider "powerdns" {
  api_key = "${var.powerdns_key}"
  server_url = "http://${var.dns_public_ip}:8093"
}