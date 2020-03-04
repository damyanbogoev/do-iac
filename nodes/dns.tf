resource "powerdns_record" "bastion" {
  name = "${digitalocean_droplet.bastion.name}."

  zone = "${var.dc_domain}."
  type = "A"
  ttl = 300
  records = [
    digitalocean_droplet.bastion.ipv4_address_private]
}

resource "powerdns_record" "web_server" {
  name = "${element(digitalocean_droplet.web_server_node.*.name, count.index)}."
  count = var.web_servers_size

  zone = "${var.dc_domain}."
  type = "A"
  ttl = 300
  records = [
    element(digitalocean_droplet.web_server_node.*.ipv4_address_private, count.index)]
}
