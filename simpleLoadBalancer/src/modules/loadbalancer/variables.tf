variable "rg_name" {}
variable "location" {}
variable "vm_count" {}
variable "vnet_id" {}
variable "niclist" {}
variable "prefix" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "pmu-"
}