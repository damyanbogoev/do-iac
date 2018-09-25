output "load_balancer_ids" {
  value = "export TF_VAR_load_balancers='${digitalocean_loadbalancer.public.id}'"
}