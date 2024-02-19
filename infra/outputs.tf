output "lb_ip" {
  value = hcloud_load_balancer_network.rke2-cluster-lbr-net.ip
}
output "lb_id" {
  value = hcloud_load_balancer_network.rke2-cluster-lbr-net.id
}
output "network_id" {
  value = hcloud_network.rke2-cluster-network.id
}
output "lb_ipv4" {
  value = hcloud_load_balancer.rke2-cluster-lbr.ipv4
}

output "api_token" {
  value = random_string.api_token.result
}

output "rke2_cluster_secret" {
  value = random_string.rke2_token.result
}

output "hcloud_ssh_key" {
  value = hcloud_ssh_key.ssh_key.name
}

output "ssh_private_key_path" {
  value = local_sensitive_file.ssh_private_key_pem.filename
}

output "private_key" {
  value = tls_private_key.global_key.private_key_pem
}

output "public_key" {
  value = tls_private_key.global_key.public_key_openssh
}

output "spread_id" {
  value = hcloud_placement_group.spread-group.id
}