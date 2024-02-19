output "result" {
  value = ssh_resource.kubeconfig.result
}
output "kube_config" {
  value = local_file.k8s_config.filename
}

