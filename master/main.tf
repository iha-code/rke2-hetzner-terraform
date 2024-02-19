resource "hcloud_server" "master" {
  count = var.master_count
  name = "${var.cluster_name}-master-${count.index}"
  location = var.location
  image = var.os_version
  server_type = var.master_type
  labels = {
    cluster: var.cluster_name,
    master: "true"
  }
  backups = true
  ssh_keys = var.ssh_keys
  placement_group_id = var.spread_id
  user_data = templatefile("${path.module}/master.yml", {
    public_key = var.public_key,
    rke2_cluster_secret = var.rke2_cluster_secret,
    lb_address = var.lb_ip,
    lb_ext_ip = var.lb_ext_ip,
    master_index = count.index,
    rke2_version = var.rke2_version,
    domains = var.domains,
    cluster_name = var.cluster_name,
    lb_id = var.lb_id,
    hcloud_token = var.hcloud_token,
    api_token = var.api_token
    })
}



resource "hcloud_server_network" "master" {
  count = var.master_count
  server_id = hcloud_server.master[count.index].id
  network_id = var.network_id
}


resource "hcloud_firewall" "proxy-master" {
  name = "proxy-master"
  ## Inbound rules
  rule {
    direction = "in"
    protocol  = "tcp"
    port ="3128"
    source_ips = [
      format("%s/32", hcloud_server.master.*.ipv4_address[0]),
      format("%s/32", hcloud_server.master.*.ipv4_address[1]),
      format("%s/32", hcloud_server.master.*.ipv4_address[2])

    ]
  }
  apply_to {
    server = var.proxy_server_id
  }
  depends_on = [hcloud_server.master]
}



resource "hcloud_firewall" "firewall-master" {
  name = "firewall-master"
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

resource "hcloud_firewall_attachment" "firewall-master_att" {
firewall_id = hcloud_firewall.firewall-master.id
label_selectors = ["firewall-attachment=rke2-cluster-master"]
}

