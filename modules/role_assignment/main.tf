resource "azurerm_role_assignment" "template_role_assignmet" {
  count = length(local.roles)

  role_definition_name = local.roles[count.index].role
  scope                = local.roles[count.index].target_id
  principal_id         = local.roles[count.index].resource_id
}
# resource "azurerm_role_assignment" "template_role_assignmet" {
#   for_each = var.resource_list

#   role_definition_name = var.role_name
#   scope                = var.target_resource_id
#   principal_id         = each.value.identity[0] != null ? each.value.identity[0].principal_id : ""
# }
