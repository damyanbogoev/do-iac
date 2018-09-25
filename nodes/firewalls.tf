resource "digitalocean_firewall" "bastion" {
  name = "bastion-${var.dc_name_suffix}"

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "22"
      source_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol = "icmp"
      // uncomment the code bellow for already created DC
      // in order to avoid the diff between the current and state to be
      // this is caused by issue in Terraform API
      //      port_range = "0"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "all"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "udp"
      port_range = "all"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
  ]

  tags = [
    "${digitalocean_tag.bastion.name}"]
}

resource "digitalocean_firewall" "nodes" {
  name = "nodes-${var.dc_name_suffix}"

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "22"
      source_tags = [
        "${digitalocean_tag.bastion.name}"]
    },
    {
      protocol = "udp"
      port_range = "all"
      source_tags = [
        "${digitalocean_tag.general.name}"]
    },
    {
      protocol = "icmp"
      // uncomment the code bellow for already created DC
      // in order to avoid the diff between the current and state to be
      // this is caused by issue in Terraform API
      //      port_range = "0"
      source_tags = [
        "${digitalocean_tag.general.name}"]
    },
    {
      protocol = "tcp"
      port_range = "all"
      source_tags = [
        "${digitalocean_tag.general.name}"]
      source_load_balancer_uids = "${split(",", var.load_balancers)}"
    },
  ]

  outbound_rule = [
    {
      protocol = "icmp"
      // uncomment the code bellow for already created DC
      // in order to avoid the diff between the current and state to be
      // this is caused by issue in Terraform API
      //      port_range = "0"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "all"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
    {
      protocol = "udp"
      port_range = "all"
      destination_addresses = [
        "0.0.0.0/0",
        "::/0"]
    },
  ]

  tags = [
    "${digitalocean_tag.general.name}"]
}