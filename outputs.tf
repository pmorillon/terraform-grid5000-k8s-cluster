output "site" {
    value = var.site
}
output "assigned_nodes" {
    value = grid5000_job.k8s.assigned_nodes
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

output "disks_resources" {
    value = grid5000_job.k8s.disks_resources
}

output "vlans_resources" {
    value = grid5000_job.k8s.vlans_resources
}

output "api_server_url" {
    value = rke_cluster.cluster.api_server_url
}

output "kube_admin_user" {
    value = rke_cluster.cluster.kube_admin_user
}

output "client_cert" {
    value = rke_cluster.cluster.client_cert
}

output "client_key" {
    value = rke_cluster.cluster.client_key
}

output "ca_crt" {
    value = rke_cluster.cluster.ca_crt
}