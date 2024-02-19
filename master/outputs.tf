output "ipv4s" {
  value = hcloud_server.master.*.ipv4_address
}
output "helm_host" {
  value = hcloud_server.master.*.ipv4_address[0]
}


output "master_nodes" {
  value = hcloud_server.master.*.name
}


