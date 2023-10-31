module nsgvnet {
  source = "../modules/nsg_vnet"
  rg_name = var.rg_name
  location = var.location
  suffix = var.suffix
}

module virtualmachine{
  source = "../modules/virtualmachine"
  rg_name = var.rg_name
  location = var.location
  vm_count = 2
  subnet_id = module.nsgvnet.subnets[0].id
}

module loadbalancer {
  source = "../modules/loadbalancer"
  rg_name = var.rg_name
  location = var.location
  vnet_id = module.nsgvnet.vnet_id
  niclist = module.virtualmachine.nics
  vm_count = 2
}
