resource "azurerm_network_security_group" "object" {
  name                = "${var.prefix}network-security-group"
  location            = var.location
  resource_group_name = var.rg_name
  
  tags = {
    owner = "prem"
  }
}

resource "azurerm_network_security_rule" "object" {
  name                        = "allow-all-tcp"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.object.name
}


resource "azurerm_virtual_network" "object" {
  name                = "${var.prefix}vnet-primary"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = ["27.27.0.0/22"]

  tags = {
    owner = "prem"
  }
}

resource "azurerm_subnet" "object" {
  count                = 3
  name                 = count.index == 0? "default" : "subnet-${count.index}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.object.name
  address_prefixes     = ["27.27.${count.index}.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "object" {
  subnet_id                 = azurerm_subnet.object[0].id
  network_security_group_id = azurerm_network_security_group.object.id
}

output "vnet_id" {
  value       = azurerm_virtual_network.object.id
  description = "vnetid"
}

output "subnets" {
  value       = azurerm_subnet.object
  description = "The subnets"
}