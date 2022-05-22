#---------------------------------
# Local declarations
#---------------------------------
locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  resource_prefix     = var.resource_prefix == "" ? local.resource_group_name : var.resource_prefix
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)

  timeout_create  = "15m"
  timeout_update  = "15m"
  timeout_delete  = "15m"
  timeout_read    = "15m"
}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "true"
#----------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${local.resource_prefix}-law"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = var.sku 
  retention_in_days   = var.log_analytics_logs_retention_in_days

  tags                = merge({ "ResourceName" = "${local.resource_prefix}-law" }, var.tags, )
}

resource "azurerm_log_analytics_solution" "container" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = local.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name
  
  tags                = merge({ "ResourceName" = "ContainerInsights" }, var.tags, )

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
