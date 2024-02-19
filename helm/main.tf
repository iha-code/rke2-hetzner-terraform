resource "kubernetes_node_taint" "rke2_taint" {
  for_each = toset(var.rke2_nodes)
  metadata {
    name = each.value
  }
  taint {
    key    = "node.cloudprovider.kubernetes.io/uninitialized"
    value  = "true"
    effect = "NoSchedule"
  }
}

resource "helm_release" "hcloud-ccm" {
  depends_on = [kubernetes_node_taint.rke2_taint]
  name       = "hcloud-cloud-controller-manager"
  repository = "https://helm-charts.mlohr.com/"
  chart      = "hcloud-cloud-controller-manager"
  namespace  = "kube-system"
  version    = var.version_ccm_chart
  timeout    = 600

  set {
    name  = "secret.hcloudApiToken"
    value = var.hcloud_token
  }
}

resource "helm_release" "hcloud-csi" {
  name       = "hcloud-csi-driver"
  repository = "https://helm-charts.mlohr.com/"
  chart      = "hcloud-csi-driver"
  namespace  = "kube-system"
  version    = var.version_csi_chart
  timeout    = 600

  set {
    name  = "secret.hcloudApiToken"
    value = var.hcloud_token
  }
}

resource "helm_release" "nginx_ingress" {
  depends_on       = [helm_release.hcloud-ccm]
  name             = "rke2-ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "kube-system"
  version          = var.version_ingress_chart
  timeout          = 600

  set {
    name      = "controller.replicaCount"
    value     = 1
  }

  set {
    name      = "controller.scope.enabled"
    value     = true
  }
  set {
    name      = "controller.service.type"
    value     = "LoadBalancer"
    type      = "string"
  }
  set {
    name      = "controller.service.loadBalancerIP"
    value     = var.lb_ext_ip
    type      = "string"
  }
  set {
    name      = "controller.service.annotations.load-balancer\\.hetzner\\.cloud/location"
    value     = "nbg1"
    type      = "string"
  }
  set {
    name      = "controller.service.annotations.load-balancer\\.hetzner\\.cloud/use-private-ip"
    value     = false
    #type      = "bool"
  }

  set {
    name      = "controller.service.annotations.load-balancer\\.hetzner\\.cloud/network-zone"
    value     = "eu-central"
    type      = "string"
  }
  set {
    name      = "controller.service.annotations.load-balancer\\.hetzner\\.cloud/network"
    value     = "rke2-cluster"
    type      = "string"
  }


  set {
    name      = "controller.service.annotations.load-balancer\\.hetzner\\.cloud/type"
    value     = "lb11"
    type      = "string"
  }
  set {
    name      = "controller.service.annotations.load-balancer\\.hetzner\\.cloud/name"
    value     = "rke2-cluster-lbr"
    type      = "string"
  }
  set {
    name      = "controller.resources.requests.cpu"
    value     = "100m"
    type      = "string"
  }
  set {
    name      = "controller.resources.requests.memory"
    value     = "100Mi"
    type      = "string"
  }
  set {
    name      = "controller.ingressClassResource.controllerValue"
    value     = "k8s.io/ingress-nginx"
    type      = "string"
  }
  set {
    name      = "controller.ingressClassResource.default"
    value     = false
    #type      = "bool"
  }
  set {
    name      = "controller.ingressClassResource.enabled"
    value     = false
    #type      = "bool"
  }
  set {
    name      = "controller.ingressClassResource.name"
    value     = "nginx"
    type      = "string"
  }
}

