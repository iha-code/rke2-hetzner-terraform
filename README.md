# rke2-cluster-hetzner


```bash
git clone https://github.com/iha-code/rke2-hetzner-terraform.git
```

# Terraform modules for setup rke2 cluster on hetzner cloud

This terraform module is fot deploy a RKE2 cluster in Hetzner Cloud, and consist of the followings modules:

- infra - for creating network/subnetes,load balancer services, firewall rules, placement group and generating ssh key and tokens
- master - for creating master nodes
- worker - for creating worker nodes
- kubeconfig - for generating KUBECONFIG file
- helm - for installaing helm charts: CCM, CSI and Nginx ingress

RKE2 clusters will be created from three master and three worker instances running Ubuntu 20.04. All instances will be accessible over SSH using the auto-generated SSH keys id_rsa and id_rsa.pub.


## Initialization terraform providers

```bash
terraform init
```

## Create RKE2 cluster

```bash
terraform plan -out="plan_1" -target="module.infra" -target="module.master" -target="module.worker" -target="module.kubeconfig"
terraform apply "plan_1" -var='hcloud_token=<API-TOKEN>' -auto-approve
terraform plan -out="plan_2" -target="module.helm"
terraform apply "plan_2" -var='hcloud_token=<API-TOKEN>' -auto-approve
```


## Create KUBECONFIG file

```bash
terraform output -raw kubeconfig > rke2-cluster
```

## Checking RKE2 cluster

```bash
Check are RKE2 nodes Ready
kubectl --kubeconfig rke2-config get node -o wide
Check are RKE2 pods Running
kubectl --kubeconfig rke2-config get pod -A -o wide
```

## Remove  RKE2 cluster

```bash
terraform destroy -var='hcloud_token=<API-TOKEN>' -auto-approve
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | 1.35.0 |


## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.24.1 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |
| <a name="provider_sshcommand"></a> [sshcommand](#provider\_sshcommand) | 0.2.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.10.1 |

## Resources


| Name | Type |
|------|------|
| [hcloud_network.private](https://registry.terraform.io/providers/hetznercloud/hcloud/1.24.1/docs/resources/network) | resource |
| [hcloud_network_subnet.private](https://registry.terraform.io/providers/hetznercloud/hcloud/1.24.1/docs/resources/network_subnet) | resource |
| [hcloud_server.quickstart_node](https://registry.terraform.io/providers/hetznercloud/hcloud/1.24.1/docs/resources/server) | resource |
| [hcloud_server.rancher_server](https://registry.terraform.io/providers/hetznercloud/hcloud/1.24.1/docs/resources/server) | resource |
| [hcloud_ssh_key.quickstart_ssh_key](https://registry.terraform.io/providers/hetznercloud/hcloud/1.24.1/docs/resources/ssh_key) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/2.4.0/docs/resources/sensitive_file) | resource |
| [tls_private_key.global_key](https://registry.terraform.io/providers/hashicorp/tls/4.0.4/docs/resources/private_key) | resource |
| [helm_release](https://registry.terraform.io/providers/hashicorp/helm/2.10.1/docs/resources/release) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#kubeconfig) | n/a |
| <a name="output_id_rsa"></a> [id_rsa](#id_rsa) | n/a |
| <a name="output_id_rsa_pub"></a> [id_rsa_pub](#id_rsa_pub) | n/a |
| <a name="output_helm_host"></a> [helm_host](#helm_host) | n/a |
