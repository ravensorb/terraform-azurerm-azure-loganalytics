# Azure File Sync Terraform module

Terraform module to create complete Azure File Sync service.

## Module Usage

```hcl
# Azurerm Provider configuration
provider "azurerm" {
  features {}
}

module "azure-law" {
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
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply

```

Run `terraform destroy` when you don't need these resources.

## Outputs

Name | Description
---- | -----------
`resource_group_name`|The name of the resource group in which resources are created
`resource_group_id`|The id of the resource group in which resources are created
`resource_group_location`|The location of the resource group in which resources are created
`virtual_network_name`|The name of the virtual network
`virtual_network_id`|The id of the virtual network
`storage_account_id`|The id of the storage account that was used/created
`storage_account_name`|The name of the storage account that was used/created
`storage_sync_id`|The id of the storage sync that was created
`storage_sync_name`|The name of the storage sync that was created
`storage_sync_group_id`|The id of the storage sync group that was created
`storage_sync_group_name`|The name of the storage sync group that was created
`storage_sync_cloud_endpoint_id`|The id of the storage sync cloud endpoint that was created
`storage_sync_cloud_endpoint_name`|The name of the storage sync cloud endpoint that was created
`storage_sync_cloud_endpoint_file_share_name`|The name of the storage sync cloud endpoint file share that was created
