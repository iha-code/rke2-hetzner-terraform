variable "ssh_keys" {
  type        = list
  description = "ssh key names"
}
variable "cluster_name" {
  type        = string
  description = "name of the cluster"
}
variable "domains" {
  type        = list
  description = "list of cluster domains"
}


variable "master_count" {
  type        = number
  default     = 3
  description = "Count of rke2 master servers"
}
variable "master_type" {
  type        = string
  default     = "cx31"
  description = "machine type to use for the masters"
}
variable "public_key" {
  type        = list
  default     = []
  description = "Extra ssh keys to inject into Rancher instances"
}
variable "rke2_cluster_secret" {
  type        = string
  description = "Cluster secret for rke2 cluster registration"
}
variable "rke2_version" {
  type        = string
  default     = ""
  description = "Version of rke2 to install"
}
variable "location" {
  type        = string
  default     = "nbg1"
  description = "hetzner location"
}

variable "os_version" {
  type        = string
  default     = "ubuntu-20.04"
  description = "OS version"
}

variable "lb_ip" {
  type        = string
  description = "ip of the lb to use to connect masters"
}


variable "lb_ext_ip" {
  type        = string
  description = "external v4 ip of the lb"
}

variable "lb_id" {
  type        = string
  description = "id of the load balancer to connect masters"
}
variable "network_id" {
  type        = string
  description = "network id to put servers into"
}


variable "spread_id" {
  type        = string
  description = "spread id to put servers into"
}
variable "api_token" {
  type        = string
  description = "hetzner api token with read permission to read lb state"
}

variable "hcloud_token" {
  sensitive = true
}

variable "proxy_server_id" {
  type        = number
  description = "Proxy serverid"
}
