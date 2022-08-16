resource "azurerm_virtual_network" "hrm_vnet" {
  name                = "hrm-vnet"
  location            = var.vnet_location
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = var.tags
}

resource "azurerm_network_security_group" "hrm_nsg" {
  name                = "hrm-security-group"
  location            = var.nsg_location
  resource_group_name = var.rg_name

  dynamic "security_rule" {
    for_each = var.security_rules != [] ? var.security_rules : []

    content {
      name                       = try(security_rule.value["name"], null)
      priority                   = try(security_rule.value["priority"], null)
      direction                  = try(security_rule.value["direction"], null)
      access                     = try(security_rule.value["access"], null)
      protocol                   = try(security_rule.value["protocol"], null)
      source_port_range          = try(security_rule.value["source_port_range"], null)
      destination_port_range     = try(security_rule.value["destination_port_range"], null)
      source_address_prefix      = try(security_rule.value["source_address_prefix"], null)
      destination_address_prefix = try(security_rule.value["destination_address_prefix"], null)
    }
  }
}

resource "azurerm_subnet" "hrm_subnet" {
  for_each = var.subnet_list

  name                 = "${each.key}-subnet"
  address_prefixes     = each.value["address_prefixes"]
  virtual_network_name = azurerm_virtual_network.hrm_vnet.name
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "hrm_subnet_nsg" {
  for_each = azurerm_subnet.hrm_subnet

  subnet_id                 = each.value["id"]
  network_security_group_id = azurerm_network_security_group.hrm_nsg.id
}