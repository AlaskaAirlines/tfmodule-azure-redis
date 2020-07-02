variable "resource-group-name" {
  type        = string
  description = "Name of the resource group that exists in Azure"
}

variable "appName" {
  type        = string
  description = "The base name of the application used in the naming convention."
}

variable "environment" {
  type        = string
  description = "Name of the environment ex (Dev, Test, QA, Prod)"
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "capacity" {
  type        = number
  description = "(Required) The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4."
}

variable "family" {
  type        = string
  description = "(Required) The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
}

variable "sku_name" {
  type        = string
  description = "(Required) The SKU of Redis to use. Possible values are Basic, Standard and Premium."
}

variable "minimum_tls_version" {
  type        = "string"
  description = "(Optional) The minimum TLS version. Defaults to 1.2."
  default     = "1.2"
}

variable "actionGroupId" {
  type        = string
  description = "The ID for the action group to receive notifications of alerts"
}
