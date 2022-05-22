# Azure Log Analytics Workspace Terraform Module

A Log Analytics workspace is a unique environment for log data from Azure Monitor and other Azure services such as Microsoft Sentinel and Microsoft Defender for Cloud. Each workspace has its own data repository and configuration but may combine data from multiple services. This article provides an overview of concepts related to Log Analytics workspaces and provides links to other documentation for more details on each.

## Module Usage

```hcl
module "law" {
  source  = "ravensorb/azure-loganalyticsworkspace/azurerm"

  resource_prefix     = "shared-eastus2-001"
  location            = "eastus2"

  # By default, this module will create a resource group, proivde the name here
  # to use an existing resource group, specify the existing resource group name,
  # and set the argument to `create_resource_group = false`. Location will be same as existing RG.
  create_resource_group   = true
  #resource_group_name     = "shared-eastus2-001-law"

  sku  = "PerGB2018"

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

## Create resource group

By default, this module will create a resource group and the name of the resource group to be given in an argument `resource_group_name`. If you want to use an existing resource group, specify the existing resource group name, and set the argument to `create_resource_group = false`.

> *If you are using an existing resource group, then this module uses the same resource group location to create all resources in this module.*

## Requirements

Name | Version
-----|--------
terraform | >= 0.13
azurerm | >= 2.59.0

## Providers

| Name | Version |
|------|---------|
azurerm | >= 2.59.0

## Inputs

Name | Description | Type | Default
---- | ----------- | ---- | -------
`create_resource_group` | Whether to create resource group and use it for all networking resources | `string` | `true`
`resource_group_name` | The name of the resource group in which resources are created | `string` | `""`
`location`|The location of the resource group in which resources are created| `string` | `""`
`resource_prefix`|Prefix for all resources created (to be used in resource naming convention)| `string` | `""`
`sku`|Log Analytics Workspace SKU | `string` |``
`log_analytics_logs_retention_in_days`|The number of days to maintain log files| `number` | `30`
`Tags`|A map of tags to add to all resources| `map` |`{}`

## Outputs

Name | Description
---- | -----------
`resource_group_name`| The name of the resource group in which resources are created
`resource_group_id`| The id of the resource group in which resources are created
`resource_group_location`| The location of the resource group in which resources are created
`log_analytics_workspace_name`|Specifies the name of the Log Analytics Workspace
`log_analytics_workspace_id`|The resource id of the Log Analytics Workspace
`log_analytics_customer_id`|The Workspace (or Customer) ID for the Log Analytics Workspace.
`log_analytics_logs_retention_in_days`|The workspace data retention in days. Possible values range between 30 and 730

## Recommended naming and tagging conventions

Well-defined naming and metadata tagging conventions help to quickly locate and manage resources. These conventions also help associate cloud usage costs with business teams via chargeback and show back accounting mechanisms.

> ### Resource naming

An effective naming convention assembles resource names by using important resource information as parts of a resource's name. For example, using these [recommended naming conventions](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging#example-names), a public IP resource for a production SharePoint workload is named like this: `pip-sharepoint-prod-westus-001`.

> ### Metadata tags

When applying metadata tags to the cloud resources, you can include information about those assets that couldn't be included in the resource name. You can use that information to perform more sophisticated filtering and reporting on resources. This information can be used by IT or business teams to find resources or generate reports about resource usage and billing.

The following list provides the recommended common tags that capture important context and information about resources. Use this list as a starting point to establish your tagging conventions.

Tag Name|Description|Key|Example Value|Required?
--------|-----------|---|-------------|---------|
Created By|Name Person responsible for approving costs related to this resource.|CreatedBy|{email}|Yes
Created On|Date when this application, workload, or service was first deployed.|CreatedOn|{date}|No
Cost Center|Accounting cost center associated with this resource.|CostCenter|{number}|Yes
Environment|Deployment environment of this application, workload, or service.|Environment|Prod, Dev, QA, Stage, Test|Yes
Critical|Indicates if this is a critical resource|Critical|Yes|Yes
Location|Indicates the location of this resource|Location|eastus2|No
Solution|Indicates the solution related to this resource|Solution|hub|No
Service Class|Service Level Agreement level of this application, workload, or service.|ServiceClass|Dev, Bronze, Silver, Gold|Yes

other tag recommendations could include

Tag Name|Description|Key|Example Value|Required?
--------|-----------|---|-------------|---------|
Project Name|Name of the Project for the infra is created. This is mandatory to create a resource names.|ProjectName|{Project name}|Yes
Application Name|Name of the application, service, or workload the resource is associated with.|ApplicationName|{app name}|Yes
Business Unit|Top-level division of your company that owns the subscription or workload the resource belongs to. In smaller organizations, this may represent a single corporate or shared top-level organizational element.|BusinessUnit|FINANCE, MARKETING,{Product Name},CORP,SHARED|Yes
Disaster Recovery|Business criticality of this application, workload, or service.|DR|Mission Critical, Critical, Essential|Yes
Owner Name|Owner of the application, workload, or service.|Owner|{email}|Yes
Requester Name|User that requested the creation of this application.|Requestor| {email}|Yes
End Date of the Project|Date when this application, workload, or service is planned to be retired.|EndDate|{date}|No

> This module allows you to manage the above metadata tags directly or as a variable using `variables.tf`. All Azure resources which support tagging can be tagged by specifying key-values in argument `tags`. Tag `ResourceName` is added automatically to all resources.


## Resource Graph

## Authors

Original created by [Shawn Anderson](mailto:sanderson@eye-catcher.com)

## Other resources

* [Azure Log Analytics Documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/log-analytics-workspace-overview)
* [Terraform AzureRM Provider Documentation](https://www.terraform.io/docs/providers/azurerm/index.html)
