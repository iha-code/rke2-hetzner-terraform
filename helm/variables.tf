variable "hcloud_token" {
  sensitive = true
}

variable "host" {
  type        = string
  default     = ""
  description = "host"
}

variable "lb_ext_ip" {
  type        = string
  default     = ""
  description = "LB external IP"
}
variable "private_key" {
  type        = string
  default     = ""
  description = "private_key"
}

variable "result" {
  type        = list
  default     = []
  description = "private_key"
}

variable "version_ccm_chart" {
  type        = string
  default     = "3.3.0"
  description = "Helm CCM chart version"
}

variable "version_csi_chart" {
  type        = string
  default     = "2.2.1"
  description = "Helm CSI chart version"
}

variable "version_ingress_chart" {
  type        = string
  default     = "4.7.1"
  description = "Helm nginx ingress chart version"
}

variable "rke2_nodes" {
  type        = list(string)
  default     = []
  description = "List RKE2 nodes"
}

