module "infra" {
  source = "./infra"
  hcloud_token = var.hcloud_token
  cluster_name = var.cluster_name
}

module "master" {
  source = "./master"
  hcloud_token = var.hcloud_token
  rke2_cluster_secret = module.infra.rke2_cluster_secret
  cluster_name = var.cluster_name
  lb_ip = module.infra.lb_ip
  lb_ext_ip = module.infra.lb_ipv4
  ssh_keys = [module.infra.hcloud_ssh_key]
  network_id = module.infra.network_id
  spread_id = module.infra.spread_id
  domains = [var.domain]
  lb_id = module.infra.lb_id
  api_token = module.infra.api_token
  public_key = [module.infra.public_key]
  master_count = 3
  proxy_server_id= var.proxy_server_id
}

module "worker" {
  source = "./worker"
  hcloud_token = var.hcloud_token
  rke2_cluster_secret = module.infra.rke2_cluster_secret
  cluster_name = var.cluster_name
  lb_ip = module.infra.lb_ip
  ssh_keys = [module.infra.hcloud_ssh_key]
  network_id = module.infra.network_id
  spread_id = module.infra.spread_id
  lb_id = module.infra.lb_id
  api_token = module.infra.api_token
  public_key = [module.infra.public_key]
  worker_count = 3
  proxy_server_id= var.proxy_server_id
}


module "kubeconfig" {
  depends_on = [module.infra, module.master.helm_host]
  hcloud_token = var.hcloud_token
  source = "./kubeconfig"
  host = module.master.helm_host
  private_key = module.infra.private_key
}

module "helm" {
 #depends_on = [module.infra, module.master, module.worker, module.kubeconfig]
 source = "./helm"
  hcloud_token = var.hcloud_token
  host = module.master.helm_host
  private_key = module.infra.private_key
  lb_ext_ip = module.infra.lb_ipv4
  rke2_nodes =concat(sort(module.master.master_nodes),sort(module.worker.worker_nodes))
}



