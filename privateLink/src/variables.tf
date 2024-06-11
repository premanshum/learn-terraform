
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
    default     = ["<guid of subscription-1>", "<guid of subscription 2>"]
}
variable "vnet_name" {
    description = "Name of the virtual net that will contain the private link"
    type = string
}
