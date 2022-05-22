provider "azurerm" {
  features {}
}

module "law" {
  source  = "ravensorb/azure-loganalyticsworkspace/azurerm"

  resource_prefix     = "shared-eastus2-001"
  location            = "eastus2"

  # By default, this module will create a resource group, proivde the name here
  # to use an existing resource group, specify the existing resource group name,
  # and set the argument to `create_resource_group = false`. Location will be same as existing RG.
  create_resource_group   = true
  #resource_group_name     = "shared-eastus2-001-law"

  sku = "PerGB2018"

  # Adding TAG's to your Azure resources (Required)
  tags = {
    CreatedBy   = "Shawn Anderson"
    CreatedOn   = "2022/05/20"
    CostCenter  = "IT"
    Environment = "PROD"
    Critical    = "YES"
    Location    = "eastus2"
    Solution    = "filesync"
    ServiceClass = "Gold"
  }

}