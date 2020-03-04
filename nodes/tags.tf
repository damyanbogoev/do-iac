resource "digitalocean_tag" "general" {
  name = var.tag_general
}

resource "digitalocean_tag" "bastion" {
  name = var.tag_bastion
}

resource "digitalocean_tag" "web" {
  name = var.tag_web_servers
}
