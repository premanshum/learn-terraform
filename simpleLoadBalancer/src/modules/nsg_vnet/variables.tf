variable "rg_name" {
    description = "Name of the resource group under which all the components will be created"
    type = string
}
variable "location" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "westeurope"
}
variable "suffix" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = ""
}
variable "prefix" {
    description = "Location where all the components will be created. Default is westeurope"
    type = string
    default = "pmu-"
}
variable "preventDestroy" {    
    description = "Location where all the components will be created. Default is westeurope"
    type = bool
    default = true
}