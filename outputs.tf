output "kubeconfig" {
  value = module.kubeconfig.result
  sensitive = true
}


output "id_rsa" {
  value = module.infra.private_key
  sensitive = true
}

output "id_rsa_pub" {
  value = module.infra.public_key
  sensitive = true
}

output "helm_host" {
  value = module.master.helm_host
}

