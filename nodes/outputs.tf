output "bastion_ip" {
  value = "${digitalocean_droplet.bastion.ipv4_address}"
}

output "nodes bootstrapping" {
  value = "nodes bootstrapping could take some time to complete: cloud init is a bit slow"
}