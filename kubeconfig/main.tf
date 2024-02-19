resource "ssh_resource" "set_helm_host" {
  host = var.host
  port = "2233"
  user = "rke2-user"
  private_key = var.private_key
  agent = false
  timeout = "5m"
  commands = [
    "max_retries=30; retries=0; while [ ! -f '/etc/rancher/rke2/rke2.yaml' ] && [ $retries -lt $max_retries ]; do   echo 'File not found. Retrying in 5 seconds...' &&  retries=$((retries+1)) && sleep 5; done; sudo sed -i -e 's/127.0.0.1/${var.host}/' /etc/rancher/rke2/rke2.yaml"
  ]
}
resource "ssh_resource" "kubeconfig" {
  host = var.host
  port = "2233"
  user = "rke2-user"
  private_key = var.private_key
  agent = false
  timeout = "5m"
  commands = [
    "sudo cat /etc/rancher/rke2/rke2.yaml"
  ]
  depends_on = [ssh_resource.set_helm_host]
}

resource "local_file" "k8s_config" {
  filename = "config"
  content  = ssh_resource.kubeconfig.result
  file_permission = "0600"
}

