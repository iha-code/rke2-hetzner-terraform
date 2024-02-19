resource "random_string" "rke2_token" {
  length = 64
  special = false
}

resource "random_string" "api_token" {
  length = 64
  special = false
}
