output "ids" {
  value = [for app in azurerm_linux_web_app.hrm-app : app.id]
}

output "apps" {
  value = azurerm_linux_web_app.hrm-app
}

output "urls" {
  value = [for app in azurerm_linux_web_app.hrm-app : app.default_hostname]
}

output "principal_ids" {
  value = [for app in azurerm_linux_web_app.hrm-app : app.identity[0].principal_id if app.identity[0] != null]
}