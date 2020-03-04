resource "digitalocean_firewall" "dns" {
  name = "dns-${var.dc_name_suffix}"

  inbound_rule {
    protocol = "tcp"
    port_range = "8093"
    source_addresses = [
      "0.0.0.0/0",
      "::/0"]
  }

  inbound_rule {
    protocol = "udp"
    port_range = "53"
    source_tags = [
      var.tag_general]
  }

  outbound_rule {
    protocol = "icmp"
    // uncomment the code bellow for already created DC
    // in order to avoid the diff between the current and state to be
    // this is caused by issue in Terraform API
    //      port_range = "0"
    destination_addresses = [
      "0.0.0.0/0",
      "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "all"
    destination_addresses = [
      "0.0.0.0/0",
      "::/0"]
  }

  outbound_rule {
    protocol = "udp"
    port_range = "all"
    destination_addresses = [
      "0.0.0.0/0",
      "::/0"]
  }

  tags = [
    var.tag_dns]
}
