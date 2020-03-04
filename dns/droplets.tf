data "template_file" "user_data" {
  template = file("dns/templates/user_data")

  vars = {
    powerdns_api_key = var.powerdns_api_key
    powerdns_api_port = var.powerdns_api_port
  }
}

# Create the DNS node in the DC
resource "digitalocean_droplet" "dns" {
  name = "dns.${var.dc_domain}"

  image = var.dns_image
  region = var.digitalocean_region
  size = var.dns_memory_size

  monitoring = true
  private_networking = true
  ssh_keys = var.nodes_ssh_keys

  user_data = data.template_file.user_data.rendered

  tags = [
    var.tag_general,
    var.tag_dns]
}
