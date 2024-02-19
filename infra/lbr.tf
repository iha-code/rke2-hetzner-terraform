resource "hcloud_load_balancer" rke2-cluster-lbr {
  name = "rke2-cluster-lbr"
  load_balancer_type = var.lb_type
  location     = var.lb_location
}

resource "hcloud_load_balancer_network" "rke2-cluster-lbr-net" {
  load_balancer_id = hcloud_load_balancer.rke2-cluster-lbr.id
  network_id = hcloud_network.rke2-cluster-network.id
  ip = var.int_lbr_ip
}

resource "hcloud_load_balancer_service" "lbr_rke2_cluster" {
  load_balancer_id = hcloud_load_balancer.rke2-cluster-lbr.id
  protocol = "tcp"
  listen_port = 9345
  destination_port = 9345
  health_check {
    protocol = "tcp"
    port = 9345
    interval = 5
    timeout = 2
    retries = 5
  }
}

resource "hcloud_load_balancer_service" "lbr_kublet" {
  load_balancer_id = hcloud_load_balancer.rke2-cluster-lbr.id
  protocol = "tcp"
  listen_port = 6443
  destination_port = 6443
  health_check {
    protocol = "tcp"
    port = 6443
    interval = 5
    timeout = 2
    retries = 2
  }
}

resource "hcloud_load_balancer_service" "lbr_sentry" {
  load_balancer_id = hcloud_load_balancer.rke2-cluster-lbr.id
  protocol = "tcp"
  listen_port = 9000
  destination_port = 80
  health_check {
    protocol = "tcp"
    port = 9000
    interval = 5
    timeout = 2
    retries = 2
  }
}

resource "hcloud_load_balancer_target" "rke2-cluster-lbr-target" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rke2-cluster-lbr.id
  label_selector   = "cluster=rke2-cluster,master=true"
  use_private_ip   = true
  depends_on = [hcloud_load_balancer_network.rke2-cluster-lbr-net]
}