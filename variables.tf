variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = true
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "resource_prefix" {
  description = "(Optional) Prefix to use for all resoruces created (Defaults to resource_group_name)"
  default     = ""
}

variable "sku" {
  description = "(Optional) Indicates the sku to use for the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "log_analytics_logs_retention_in_days" {
  description = "(Optional) Indicates the number of days of retention for the log files"
  default     = 30
}