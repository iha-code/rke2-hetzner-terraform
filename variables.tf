variable "cluster_name" {
  type        = string
  default = "rke2-cluster"
  description = "name of the cluster"
}
variable "domain" {
  type        = string
  default = "rke2.local"
  description = "list of cluster domains"
}
variable "prefix" {
  type        = string
  default     = "rke2"
  description = "machine type to use for the workers"
}
variable "hcloud_token" {
  sensitive = true
}




