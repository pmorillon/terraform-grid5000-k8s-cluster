terraform {
    required_version = ">= 0.13.0"
    required_providers {
      grid5000 = {
          source = "pmorillon/grid5000"
          version = "~> 0.0.6"
      }
      rke = {
          source = "rancher/rke"
          version = "~> 1.1.6"
      }
    }
}

provider "grid5000" {
    restfully_file = var.restfully_file
}

resource "grid5000_job" "k8s" {
  name      = "Terraform RKE"
  site      = var.site
  command   = "sleep 1d"
  resources = "${var.nodes_selector}/nodes=${var.nodes_count},walltime=${var.walltime}"
  types     = ["deploy"]
}

resource "grid5000_deployment" "k8s" {
  site        = var.site
  environment = "debian10-x64-base"
  nodes       = grid5000_job.k8s.assigned_nodes
  key         = file("~/.ssh/id_rsa.pub")
}

resource "null_resource" "docker_install" {
  depends_on = [grid5000_deployment.k8s]

  count = var.nodes_count 

  connection {
    host          = element(sort(grid5000_deployment.k8s.nodes), count.index) 
    type          = "ssh"
    user          = "root"
    agent         = var.bastion_host != "" ? true : false
    bastion_host  = var.bastion_host != "" ? var.bastion_host : null
    bastion_user  = var.bastion_user != "" ? var.bastion_user : null
    private_key   = var.bastion_host != "" ? null : file("~/.ssh/id_rsa")
  }

  provisioner "file" {
    source = "${path.module}/files/install-docker.sh"
    destination = "/root/install-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sh /root/install-docker.sh >/dev/null 2>&1",
    ]
  }
}

resource "rke_cluster" "cluster" {
    depends_on = [null_resource.docker_install]

    dynamic "nodes" {
        for_each = [for s in range(var.nodes_count): {
            address = sort(grid5000_deployment.k8s.nodes)[s] 
            internal_address = sort(grid5000_deployment.k8s.nodes)[s]
            role = s > 0 ? ["worker"] : ["controlplane", "etcd"]
        }]

        content {
            address = nodes.value.address
            internal_address = nodes.value.internal_address
            user = "root"
            role = nodes.value.role
            ssh_key = file(var.ssh_key_path) 
        }
    }

    ssh_agent_auth = var.bastion_host != null ? true : false

    dynamic "bastion_host" {
        for_each = var.bastion_host[*]
        content {
            address = bastion_host.value
            user = var.bastion_user
            ssh_key_path = var.ssh_key_path
            port = 22
        }
    }

}

resource "local_file" "kube_cluster_yaml" {
  filename = "kube_config_cluster.yml"
  content = rke_cluster.cluster.kube_config_yaml
}