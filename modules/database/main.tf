resource "azurerm_postgresql_server" "postgres_server" {
  name                = "hrm-postgres-server"
  location            = var.location
  resource_group_name = var.rg_name

  sku_name = "B_Gen5_2"

  storage_mb                   = tonumber(var.db_other_specs["storage_mb"])
  backup_retention_days        = tonumber(var.db_other_specs["backup_retention_days"])
  geo_redundant_backup_enabled = tobool(var.db_other_specs["geo_redundant_backup_enabled"])
  auto_grow_enabled            = tobool(var.db_other_specs["auto_grow_enabled"])

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_pass
  version                      = var.server_version
  ssl_enforcement_enabled      = tobool(var.db_other_specs["ssl_enforcement_enabled"])

  tags = var.tags
}

resource "azurerm_postgresql_database" "postgres_db" {
  count = length(var.db_list)

  # Đổi tên db thành: admin-db
  name                = "${var.db_list[count.index].service_name}-db"
  resource_group_name = var.rg_name
  server_name         = azurerm_postgresql_server.postgres_server.name
  charset             = var.db_list[count.index].charset
  collation           = var.db_list[count.index].collation
}