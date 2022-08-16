# Inject credentials vào các biến
resource "azurerm_resource_group" "hrm_on_dapr" {
  name     = "hrm-on-dapr-${terraform.workspace}"
  location = var.rg_name

  tags = local.tags
}

resource "azurerm_service_plan" "vm_plan" {
  name                = "hrm-vm-service-plan"
  resource_group_name = azurerm_resource_group.hrm_on_dapr.name
  location            = azurerm_resource_group.hrm_on_dapr.location
  os_type             = var.plan_os_type
  sku_name            = var.plan_sku

  tags = local.tags
}

resource "azurerm_servicebus_namespace" "hrm_rabbitmq" {
  name                = "hrm-rabbitmq"
  location            = azurerm_resource_group.hrm_on_dapr.location
  resource_group_name = azurerm_resource_group.hrm_on_dapr.name
  sku                 = var.service_bus_sku

  tags = local.tags
}

module "postgres_db" {
  source = "./modules/database"

  rg_name        = azurerm_resource_group.hrm_on_dapr.name
  location       = azurerm_resource_group.hrm_on_dapr.location
  admin_username = var.db_server_admin
  admin_pass     = var.db_server_pass
  server_version = var.db_server_version
  db_list        = var.db_list
  db_other_specs = var.db_other_specs
  tags           = local.tags
}

module "app_service" {
  source = "./modules/app"

  rg_name     = azurerm_resource_group.hrm_on_dapr.name
  app_plan_id = azurerm_service_plan.vm_plan.id
  app_list    = var.app_list
  tags        = local.tags
}

data "azurerm_container_registry" "hrm-acr" {
  name                = local.acr-admin["name"]
  resource_group_name = local.acr-admin["resource_group_name"]
}

module "role_assignment" {
  source = "./modules/role_assignment"

  role_name          = ["AcrPull", "Owner"]
  target_resource_id = [data.azurerm_container_registry.hrm-acr.id, module.postgres_db.server_id]
  resource_list      = module.app_service.principal_ids
}

module "network" {
  source = "./modules/network"

  rg_name        = azurerm_resource_group.hrm_on_dapr.name
  vnet_location  = var.vnet_location
  nsg_location   = var.nsg_location
  subnet_list    = var.subnet_list
  security_rules = var.security_rules
  tags           = local.tags
}
