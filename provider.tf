terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = ">= 1.24.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    sshcommand = {
      source  = "invidian/sshcommand"
      version = "0.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "helm" {
  kubernetes {
    config_path = module.kubeconfig.kube_config
  }
}

provider "kubernetes" {
  config_path = module.kubeconfig.kube_config
}

