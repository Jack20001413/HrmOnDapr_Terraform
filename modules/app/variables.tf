variable "app_list" {
  type = map(object({
    location                = string
    https_only              = bool
    client_affinity_enabled = bool
    application_stack       = map(string)
    env_variables           = map(string)
    site_always_on = bool
  }))
  default = {}
}

variable "app_plan_id" {
  type    = string
  default = ""
}

variable "rg_name" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}