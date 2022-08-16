output "db_ids" {
  value = [for db in azurerm_postgresql_database.postgres_db : db.id]
}

output "server_id" {
  value = azurerm_postgresql_server.postgres_server.id
}

# output "connection_strings" {
#   value = [for con in azurerm_postgresql_database : con.connection_string]
# }