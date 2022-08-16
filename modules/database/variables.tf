variable "rg_name" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "db_list" {
  type = list(object({
    service_name = string
    charset      = string
    collation    = string
  }))
  default = []
}

variable "server_version" {
  type    = string
  default = "11"
}

variable "admin_username" {
  type    = string
  default = "jack"
}

variable "admin_pass" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "db_other_specs" {
  type = map(string)
  default = {}
}
