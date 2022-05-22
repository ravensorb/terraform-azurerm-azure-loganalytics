# Resource Group
output "resource_group_name" {
  description = "The name of the resource group in which resources are created"
  value       = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
}

output "resource_group_id" {
  description = "The id of the resource group in which resources are created"
  value       = element(coalescelist(data.azurerm_resource_group.rgrp.*.id, azurerm_resource_group.rg.*.id, [""]), 0)
}

output "resource_group_location" {
  description = "The location of the resource group in which resources are created"
  value       = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}

output "log_analytics_workspace_name" {
  description = "Specifies the name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.logws.name
}

output "log_analytics_workspace_resource_group_name" {
  description = "Specifies the name of the Log Analytics Workspace Resource Group Name"
  value       = azurerm_log_analytics_workspace.logws.resource_group_name
}

output "log_analytics_workspace_id" {
  description = "Specifies the id of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.logws.id
}

output "log_analytics_customer_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.logws.workspace_id
}

output "log_analytics_logs_retention_in_days" {
  description = "The workspace data retention in days. Possible values range between 30 and 730."
  value       = var.log_analytics_logs_retention_in_days
}
