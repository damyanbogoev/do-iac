output "set_dns_private_ip" {
  value = "export TF_VAR_dns_private_ip=${digitalocean_droplet.dns.ipv4_address_private}"
}

output "set_dns_public_ip" {
  value = "export TF_VAR_dns_public_ip=${digitalocean_droplet.dns.ipv4_address}"
}