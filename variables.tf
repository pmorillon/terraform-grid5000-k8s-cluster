variable "site" {
    description = "Grid'5000 site where cluster will be deployed"
    type = string
    default = "rennes"
}

variable "nodes_count" {
    description = "Cluster size"
    type = number
    default = 4
}

variable "walltime" {
    description = "Experiment duration (OAR notation)"
    type = string
    default = "1"
}

variable "nodes_selector" {
    description = "Nodes selector (OAR SQL notation surrounded by curly brackets)"
    type = string
    default = ""

    validation {
      condition = var.nodes_selector == "" || length(regexall("{.*}",var.nodes_selector)) > 0
      error_message = "Nodes selector must be surrounded by curly brackets, \"{...}\"."
    }
}

variable "username" {
    description = "Grid'5000 account username"
    type = string
    default = ""
}

variable "password" {
    description = "Grid'5000 account password"
    type = string
    default = ""
}

variable "restfully_file" {
    description = "Path of the restfully config file for API authentication"
    type = string
    default = ""
}

variable "bastion_host" {
    description = "Bastion host"
    type = string
    default = ""
}

variable "bastion_user" {
    description = "Bastion user"
    type = string
    default = ""
}

variable "ssh_key_path" {
    description = "SSH key path"
    type = string
    default = "~/.ssh/id_rsa"
}

variable "deb_extra_pkgs" {
    description = "Debian packages to install on cluster nodes (eg. : ceph-common)"
    type = list(string)
    default = []
}