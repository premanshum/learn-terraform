
resource "azurerm_public_ip" "object" {
  name                = "publicip${var.suffix}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "object" {
  count               = var.vm_count
  name                = "nic${var.suffix}${count.index+1}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "nicconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb" "object" {
  name                = "loadBalancer${var.suffix}"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "publicIPAddress"
    public_ip_address_id = azurerm_public_ip.object.id
  }
}

resource "azurerm_lb_backend_address_pool" "object" {
  loadbalancer_id = azurerm_lb.object.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "object" {
  count                   = var.vm_count
  name                    = "backendaddresspoolAddress${count.index+1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.object.id
  virtual_network_id      = var.vnet_id
  ip_address              = azurerm_network_interface.object[count.index].private_ip_address
}

resource "azurerm_lb_nat_rule" "Access22" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.object.id
  name                           = "Access22"
  protocol                       = "Tcp"
  frontend_port_start            = 22
  frontend_port_end              = 22 + var.vm_count
  backend_port                   = 22
  backend_address_pool_id        = azurerm_lb_backend_address_pool.object.id
  frontend_ip_configuration_name = "publicIPAddress"
}

resource "azurerm_lb_nat_rule" "Access8222" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.object.id
  name                           = "Access8222"
  protocol                       = "Tcp"
  frontend_port_start            = 8222
  frontend_port_end              = 8222 + var.vm_count
  backend_port                   = 8222
  backend_address_pool_id        = azurerm_lb_backend_address_pool.object.id
  frontend_ip_configuration_name = "publicIPAddress"
}

resource "azurerm_lb_nat_rule" "Access9222" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.object.id
  name                           = "Access9222"
  protocol                       = "Tcp"
  frontend_port                  = 9222
  backend_port                   = 8222
  frontend_ip_configuration_name = "publicIPAddress"
}

resource "azurerm_lb_probe" "object1" {
  loadbalancer_id = azurerm_lb.object.id
  name            = "probe22"
  port            = 22
}

resource "azurerm_lb_probe" "object2" {
  loadbalancer_id = azurerm_lb.object.id
  name            = "probe8222"
  port            = 8222
}

output "public_ip_address" {
  value       = azurerm_public_ip.object.ip_address
  description = "The public IP address"
}

output "public_ip_address_id" {
  value       = azurerm_public_ip.object.id
  description = "The ID of public IP address"
}

output "nics" {
  value       = azurerm_network_interface.object
  description = "nic"
}

output "backendpooladdress" {
  value       = azurerm_lb_backend_address_pool_address.object
  description = "nic"
}