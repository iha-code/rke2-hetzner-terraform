variable "cluster_name" {
  type        = string
  description = "name of the cluster"
}
variable "network" {
  type        = string
  default     = "10.0.0.0/8"
  description = "network to use"
}
variable "subnet" {
  type        = string
  default     = "10.0.0.0/24"
  description = "subnet to use"
}
variable "net_zone" {
  type        = string
  default     = "eu-central"
  description = "hetzner netzwork zone"
}
variable "int_lbr_ip" {
  type        = string
  default     = "10.0.0.2"
  description = "IP to use for control plane loadbalancer"
}
variable "lb_type" {
  type        = string
  default     = "lb11"
  description = "Load balancer type"
}
variable "lb_location" {
  type        = string
  default     = "nbg1"
  description = "Load balancer location"
}

variable "hcloud_token" {
  sensitive = true
}

