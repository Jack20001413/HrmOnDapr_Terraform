resource "azurerm_linux_web_app" "hrm-app" {
  for_each = var.app_list

  name                    = each.key
  location                = each.value.location
  resource_group_name     = var.rg_name
  service_plan_id         = var.app_plan_id
  https_only              = each.value.https_only
  client_affinity_enabled = each.value.client_affinity_enabled

  site_config {
    always_on = each.value.site_always_on

    dynamic "application_stack" {
      for_each = each.value["application_stack"] != {} ? [each.value["application_stack"]] : []

      content {
        docker_image     = try(application_stack.value["docker_image"], null)
        docker_image_tag = try(application_stack.value["docker_image_tag"], null)
        dotnet_version   = try(application_stack.value["dotnet_version"], null)
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = each.value.env_variables

  tags = var.tags
}