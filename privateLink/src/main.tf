
data "azurerm_lb" "object" {
  name                = var.load_balancer_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_private_link_service" "object" {
  name                = var.pvtlink_name
  resource_group_name = var.rg_name
  location            = var.location

  visibility_subscription_ids                 = var.subscriptions
  auto_approval_subscription_ids              = var.subscriptions
  load_balancer_frontend_ip_configuration_ids = [data.azurerm_lb.object.frontend_ip_configuration[0].id]

  nat_ip_configuration {
    name                       = "primary"
    private_ip_address         = var.private_ip_address #
    private_ip_address_version = "IPv4"
    subnet_id                  = data.azurerm_subnet.subnet.id
    primary                    = true
  }
}

output "private_link_object_id" {
  value = azurerm_private_link_service.object.id
}