
resource "azurerm_public_ip" "object" {
  name                = "${var.prefix}loadbalancer-publicip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    owner = "prem"
  }
}

resource "azurerm_lb" "object" {
  name                = "${var.prefix}public-load-Balancer"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "publicIPAddress"
    public_ip_address_id = azurerm_public_ip.object.id
  }
  tags = {
    owner = "prem"
  }
}

resource "azurerm_lb_backend_address_pool" "object" {
  loadbalancer_id = azurerm_lb.object.id
  name            = "BackEndAddressPool"
}

#Automated Backend Pool Addition > Gem Configuration to add the network interfaces of the VMs to the backend pool.
resource "azurerm_network_interface_backend_address_pool_association" "business-tier-pool" {
  count                   = 2
  network_interface_id    = var.niclist[count.index].id
  ip_configuration_name   = var.niclist[count.index].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.object.id

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