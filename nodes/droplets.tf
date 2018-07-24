# Create web server nodes
data "template_file" "web_server_user_data" {
  template = "${file("nodes/templates/web_server_user_data")}"

  vars {
    dns_ip = "${var.dns_private_ip}"
    dns_name = "${var.dc_domain}",
  }
}

resource "digitalocean_volume" "web_server_volume" {
  name = "web-server-${count.index + 1}.volume.${var.dc_domain}"
  count = "${var.web_servers_size}"

  region = "${var.digitalocean_region}"
  size = "${var.web_server_memory_size}"
}

resource "digitalocean_droplet" "web_server_node" {
  name = "web-server-${count.index + 1}.${var.dc_domain}"
  count = "${var.web_servers_size}"

  image = "${var.nodes_image}"
  region = "${var.digitalocean_region}"
  size = "${var.web_server_memory_size}"

  monitoring = true
  private_networking = true
  ssh_keys = "${var.nodes_ssh_keys}"
  user_data = "${data.template_file.web_server_user_data.rendered}"
  volume_ids = [
    "${element(digitalocean_volume.web_server_volume.*.id, count.index)}"]

  tags = [
    "${var.tag_web_server}",
    "${var.tag_general}"]
}

# Create the Bastion node in the DC
data "template_file" "bastion_user_data" {
  template = "${file("nodes/templates/bastion_user_data")}"

  vars {
    dns_ip = "${var.dns_private_ip}"
    dns_name = "${var.dc_domain}",
  }
}

resource "digitalocean_droplet" "bastion" {
  name = "bastion.${var.dc_domain}"

  image = "${var.nodes_image}"
  region = "${var.digitalocean_region}"
  size = "${var.bastion_memory_size}"

  monitoring = true
  private_networking = true
  ssh_keys = "${var.bastion_ssh_keys}"
  user_data = "${data.template_file.bastion_user_data.rendered}"

  tags = [
    "${var.tag_general}",
    "${var.tag_bastion}"]
}