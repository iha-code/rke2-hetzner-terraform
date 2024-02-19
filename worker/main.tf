resource "hcloud_server" "worker" {
  count = var.worker_count
  name = "${var.cluster_name}-worker-${count.index}"
  location = var.location
  image = var.os_version
  server_type = var.worker_type
  labels = {
    cluster: var.cluster_name,
    worker: "true"
  }
  backups = true
  ssh_keys = var.ssh_keys
  placement_group_id = var.spread_id
  user_data = templatefile("${path.module}/worker.yml", {
    public_key = var.public_key,
    rke2_cluster_secret = var.rke2_cluster_secret,
    lb_address = var.lb_ip,
    worker_index = count.index,
    rke2_version = var.rke2_version,
    cluster_name = var.cluster_name,
    lb_id = var.lb_id,
    api_token = var.api_token
  })
}

resource "hcloud_server_network" "worker" {
  count = var.worker_count
  server_id = hcloud_server.worker[count.index].id
  network_id = var.network_id
}


resource "hcloud_firewall" "proxy-worker" {
  name = "proxy-worker"
  ## Inbound rules
  rule {
    direction = "in"
    protocol  = "tcp"
    port ="3128"
    source_ips = [
      format("%s/32", hcloud_server.worker.*.ipv4_address[0]),
      format("%s/32", hcloud_server.worker.*.ipv4_address[1]),
      format("%s/32", hcloud_server.worker.*.ipv4_address[2])

    ]
  }
  apply_to {
    server = var.proxy_server_id
  }
  depends_on = [hcloud_server.worker]
}


resource "hcloud_firewall" "firewall-worker" {
  name = "firewall-worker"
  rule {
    destination_ips = []
    direction       = "in"
    port            = "any"
    protocol        = "tcp"
    source_ips      = [
      "0.0.0.0/0",
      "::/0",
    ]
  }
}

resource "hcloud_firewall_attachment" "firewall-worker_att" {
  firewall_id = hcloud_firewall.firewall-worker.id
  #server_ids  = [hcloud_server.worker.id] hcloud_server.worker[count.index]
  label_selectors = ["firewall-attachment=rke2-cluster-worker"]
}
