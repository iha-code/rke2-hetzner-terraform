variable "host" {
  type        = string
  default     = ""
  description = "host"
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

variable "hcloud_token" {
  sensitive = true
}