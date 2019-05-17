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

variable "dns_image" {
  description = "The Digital Ocean image to be used for the PowerDNS server."
}

variable "dns_memory_size" {
  description = "The memory size of the dns to be created."
}

variable "powerdns_api_key" {
  description = "PowerDNS API key."
}

variable "powerdns_api_port" {
  description = "PowerDNS API port."
}

variable "nodes_ssh_keys" {
  description = "The ssh keys to be used for nodes access from the bastion node."
  type = "list"
}

variable "tag_general" {
}

variable "tag_dns" {
}