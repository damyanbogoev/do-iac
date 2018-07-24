resource "digitalocean_tag" "general" {
  name = "${var.tag_general}"
}

resource "digitalocean_tag" "dns" {
  name = "${var.tag_dns}"
}