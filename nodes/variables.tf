variable "digitalocean_token" {
  description = "The Digital Ocean token."
}

variable "digitalocean_region" {
  description = "The Digital Ocean region to create resources in."
}

variable "dc_domain" {
  description = "The domain name for the given DC."
}

variable "dc_name_suffix" {
  description = "Tag name suffix used for different resources for the given DC."
}

variable "tag_general" {
}

variable "tag_bastion" {
}

variable "tag_web_server" {
}

variable "dns_private_ip" {
  description = "The internal private ip of the DNS server."
}

variable "dns_public_ip" {
  description = "The public ip of the DNS server."
}

variable "dc_subdomain" {
  description = "The subdomain of the cluster."
}

variable "nodes_image" {
  description = "The Digital Ocean images to be used for the OpenShift infrastructure."
  default = "centos-7-x64"
}

variable "powerdns_api_key" {
  description = "The PowerDNS API key. This can also be specified with PDNS_API_KEY environment variable."
}

variable "powerdns_api_port" {
  description = "PowerDNS API port."
}

variable "bastion_memory_size" {
  description = "The memory size of the bastion to be created."
}

variable "bastion_ssh_keys" {
  description = "The ssh keys to be used for bastion access."
  type = "list"
}

variable "nodes_ssh_keys" {
  description = "The ssh keys to be used for nodes access from the bastion node."
  type = "list"
}

variable "load_balancers" {}

variable "web_servers_size" {
  description = "The total number of web server nodes to be created."
}

variable "web_server_memory_size" {
  description = "The memory size of the web server node to be created."
}

variable "web_server_volume_size" {
  description = "The size of the attached volume for the web server node."
}