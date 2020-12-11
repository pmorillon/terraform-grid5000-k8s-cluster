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

variable "username" {
    description = "Grid'5000 account username"
    type = string
    default = null
}

variable "password" {
    description = "Grid'5000 account password"
    type = string
    default = null
}

variable "restfully_file" {
    description = "Path of the restfully config file for API authentication"
    type = string
    default = null
}

variable "bastion_host" {
    description = "Bastion host"
    type = string
    default = null
}

variable "bastion_user" {
    description = "Bastion user"
    type = string
    default = null
}

variable "ssh_key_path" {
    description = "SSH key path"
    type = string
    default = "~/.ssh/id_rsa"
}