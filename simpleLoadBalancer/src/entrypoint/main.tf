module nsgvnet {
  source = "../modules/nsg_vnet"
  rg_name = var.rg_name
  location = var.location
  suffix = var.suffix
}

module loadbalancer {
  source = "../modules/loadbalancer"
  rg_name = var.rg_name
  location = var.location
  suffix = var.suffix
  vm_count = 2
  subnet_id = module.nsgvnet.subnets[0].id
  vnet_id = module.nsgvnet.vnet_id
}

resource "azurerm_ssh_public_key" "object" {
  name                = "sshkey${var.suffix}"
  resource_group_name = var.rg_name
  location            = var.location
  public_key          = file("./id_rsa.pub")
}

# resource "azurerm_linux_virtual_machine" "object" {
#   count               = var.vm_count
#   name                = "vm-pm-linux-${count.index+1}"
#   resource_group_name = var.rg_name
#   location            = var.location
#   size                = "Standard_B1ls"
#   admin_username      = "adminuser"
#   network_interface_ids = [
#     module.loadbalancer.nics[count.index].id,
#   ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = azurerm_ssh_public_key.object.public_key
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
# }


# resource "azurerm_windows_virtual_machine" "object" {
#   count               = var.vm_count
#   name                = "vm-pm-${count.index+1}"
#   resource_group_name = var.rg_name
#   location            = var.location
#   size                = "Standard_B1ls"
#   admin_username      = "adminuser"
#   admin_password      = "P@$$w0rd1234!"
#   network_interface_ids = [
#     module.loadbalancer.nics[count.index].id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2016-Datacenter"
#     version   = "latest"
#   }
# }
