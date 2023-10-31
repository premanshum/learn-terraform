
resource "azurerm_network_interface" "object" {
  count               = var.vm_count
  name                = "${var.prefix}nic-${count.index+1}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "nicconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_ssh_public_key" "object" {
  name                = "${var.prefix}sshkey"
  resource_group_name = var.rg_name
  location            = var.location
  public_key          = file("../../assets/secrets/id_rsa.pub")
}


resource "azurerm_linux_virtual_machine" "object" {
  count               = var.vm_count
  name                = "${var.prefix}vm-linux-${count.index+1}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B1ls"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.object[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = azurerm_ssh_public_key.object.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  
  tags = {
    owner = "prem"
  }
}

output "nics" {
  value       = azurerm_network_interface.object
  description = "nic"
}