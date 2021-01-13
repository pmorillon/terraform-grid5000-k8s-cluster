output "nodes" {
    value = grid5000_deployment.k8s.nodes
}

output "kube_config_yaml" {
    value = rke_cluster.cluster.kube_config_yaml
}

output "control_plane_hosts" {
    value = [ for i in rke_cluster.cluster.control_plane_hosts : i["address" ] ]
}

output "worker_hosts" {
    value = [ for i in rke_cluster.cluster.worker_hosts : i["address"] ]
}
