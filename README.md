# terraform-grid5000-k8s-cluster

This module allow you deploy a Kubernetes cluster on [Grid'5000](https://www.grid5000.fr).

## Usage

Basic usage of this module from a Grid'5000 frontend :

```hcl
module "k8s_cluster" {
    source = "pmorillon/k8s-cluster/grid5000"

    site = "lille"
}
```

```sh
terraform init
# ...
terraform apply
# ...
export KUBECONFIG=./kube_config_cluster.yml
kubectl get nodes -o wide  
# NAME                           STATUS   ROLES               AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION    CONTAINER-RUNTIME
# chetemi-3.lille.grid5000.fr    Ready    controlplane,etcd   15m   v1.19.4   172.16.37.3   <none>        Debian GNU/Linux 10 (buster)   4.19.0-13-amd64   docker://19.3.14
# chetemi-8.lille.grid5000.fr    Ready    worker              15m   v1.19.4   172.16.37.8   <none>        Debian GNU/Linux 10 (buster)   4.19.0-13-amd64   docker://19.3.14
# chifflet-2.lille.grid5000.fr   Ready    worker              15m   v1.19.4   172.16.38.2   <none>        Debian GNU/Linux 10 (buster)   4.19.0-13-amd64   docker://19.3.14
# chifflet-5.lille.grid5000.fr   Ready    worker              15m   v1.19.4   172.16.38.5   <none>        Debian GNU/Linux 10 (buster)   4.19.0-13-amd64   docker://19.3.14
```