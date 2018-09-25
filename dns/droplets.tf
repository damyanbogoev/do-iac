# Create the DNS node in the DC
resource "digitalocean_droplet" "dns" {
  name = "dns.${var.dc_domain}"

  image = "${var.dns_image}"
  region = "${var.digitalocean_region}"
  size = "${var.dns_memory_size}"

  monitoring = true
  private_networking = true
  ssh_keys = "${var.nodes_ssh_keys}"

  user_data = "${file("dns/templates/user_data")}"

  tags = [
    "${var.tag_general}",
    "${var.tag_dns}"]
}