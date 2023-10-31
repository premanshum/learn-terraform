
variable "load_balancer_name" {
    description = "Name of the load-balancer which uses the private link"
    type = string
}
variable "location" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "westeurope"
}
variable "pvtlink_name" {
    description = "name of the private link"
    type = string
}
variable "private_ip_address" {
    description = "private ip address of the private link"
    type = string
}
variable "rg_name" {
    description = "Name of the resource group under which all the components will be created"
    type = string
}
variable "subnet_name" {
    description = "Name of the subnet that will contain the private link"
    type = string
}
variable "subscriptions" {
    description = "List of subscriptions which are allowed"
    type        = list(string)
    default     = ["76a256fd-59fd-473a-9214-04eaddbcd56e", "b7fd0ade-bcd7-4416-bee0-558517f033a6"]
}
variable "vnet_name" {
    description = "Name of the virtual net that will contain the private link"
    type = string
}
