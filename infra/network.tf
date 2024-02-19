resource "hcloud_network" "rke2-cluster-network" {
  name = var.cluster_name
  ip_range = var.network
}

resource "hcloud_network_subnet" "rke2-cluster-subnet" {
  network_id = hcloud_network.rke2-cluster-network.id
  type = "cloud"
  network_zone = var.net_zone
  ip_range   = var.subnet
}

resource "hcloud_placement_group" "spread-group" {
  name = "spread-group"
  type = "spread"
}


