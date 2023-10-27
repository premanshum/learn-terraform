variable "rg_name" {}
variable "location" {}
variable "suffix" {}
variable "vm_count" {}
variable "subnet_id" {}
variable "vnet_id" {}

variable "prefix" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "pmu-"
}