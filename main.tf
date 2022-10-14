resource "azurerm_subnet" "snet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = [var.address_prefixes]
  private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled

  dynamic "delegation" {
  for_each = var.delegation == true ? [1] : []
  content {
    name      = var.delegation_friendly_name
      dynamic "service_delegation" {
        for_each = var.delegation == true ? [1] : []
        content {
          name    = var.delegation_name
          actions = var.delegation_action
        }
      }
  }
  }
}