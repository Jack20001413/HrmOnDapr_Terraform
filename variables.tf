variable "sub_id" {
  type    = string
  default = ""
}

variable "app_list" {
  type = map(object({
    location                = string
    https_only              = bool
    client_affinity_enabled = bool
    application_stack       = map(string)
    env_variables           = map(string)
    site_always_on          = bool
  }))
  default = {}
}

variable "db_list" {
  type = list(object({
    service_name = string
    charset      = string
    collation    = string
  }))
  default = []
}

variable "plan_os_type" {
  type    = string
  default = "Linux"
}

variable "plan_sku" {
  type    = string
  default = "F1"
}

variable "service_bus_sku" {
  type    = string
  default = "Standard"
}

variable "rg_name" {
  type    = string
  default = "eastus"
}

variable "vnet_location" {
  type    = string
  default = ""
}

variable "nsg_location" {
  type    = string
  default = ""
}

variable "subnet_list" {
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {}
}

variable "security_rules" {
  type    = list(map(string))
  default = []
}

variable "db_server_admin" {
  type = string
  default = "jack"
}

variable "db_server_pass" {
  type = string
  default = "J@ckStune286"
}

variable "db_server_version" {
  type = string
  default = "11"
}

variable "db_other_specs" {
  type = map(string)
  default = {}
}

locals {
  acr-admin = {
    name                = "AzureAdmin"
    resource_group_name = "SD5132"
  }

  tags = {
    Creator     = "Van Tran"
    Environment = terraform.workspace == "prod" ? "Production" : "Dev"
  }
}