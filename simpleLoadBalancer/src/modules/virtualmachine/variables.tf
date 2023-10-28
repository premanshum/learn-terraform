variable "rg_name" {
    description = "Name of the resource group under which all the components will be created"
    type = string
}
variable "location" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "westeurope"
}
variable "prefix" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "pmu-"
}
variable "vm_count" {    
    description = "count of virtual machines"
    type = number
    default = 2
}

variable "subnet_id" {
    description = "Subnet Id where the Network Interface Card will be attached."
    type = string
}