# terraform-grid5000-k8s-cluster

This module allow you deploy a Kubernetes cluster on [Grid'5000](https://www.grid5000.fr).

## Usage

Basic usage of this module from a Grid'5000 frontend :

```hcl
module "k8s_cluster" {
    source = "pmorillon/k8s-cluster/grid5000"

    site = "lille"
    # Default kubernetes version
    #kubernetes_version = "v1.22.4-rancher1-1"
}
```

__Note:__ See RKE provider [Release notes](https://github.com/rancher/terraform-provider-rke/releases/tag/v1.3.0) for supported values of `kubernetes_version`.

```sh
terraform init
# ...
terraform apply
# ...
export KUBECONFIG=$(pwd)/kube_config_cluster.yml
kubectl get nodes 
# NAME                           STATUS   ROLES               AGE     VERSION
# chetemi-1.lille.grid5000.fr    Ready    controlplane,etcd   2m29s   v1.22.4
# chetemi-5.lille.grid5000.fr    Ready    worker              2m25s   v1.22.4
# chifflet-3.lille.grid5000.fr   Ready    worker              2m28s   v1.22.4
# chifflet-6.lille.grid5000.fr   Ready    worker              2m28s   v1.22.4
```