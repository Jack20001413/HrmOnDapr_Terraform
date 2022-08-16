output "vnet_id" {
  value = azurerm_virtual_network.hrm_vnet.id
}

output "subnet_ids" {
  value = {for subnet in azurerm_subnet.hrm_subnet : subnet.name => subnet.id}
}

output "nsg_id" {
  value = azurerm_network_security_group.hrm_nsg.id
}