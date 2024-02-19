resource "hcloud_ssh_key" "ssh_key" {
  name       = "rk2-cluster-ssh-key"
  public_key =  tls_private_key.global_key.public_key_openssh
}

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "id_rsa"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0400"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
  file_permission = "0400"
}
