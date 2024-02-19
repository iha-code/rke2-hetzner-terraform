output "ipv4s" {
  value = hcloud_server.worker.*.ipv4_address
}

output "worker_nodes" {
  value = hcloud_server.worker.*.name
}
