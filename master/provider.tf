terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = ">= 1.24.1"
    }
    sshcommand = {
      source  = "invidian/sshcommand"
      version = "0.2.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
