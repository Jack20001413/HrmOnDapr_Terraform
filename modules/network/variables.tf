variable "rg_name" {
  type    = string
  default = ""
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

variable "tags" {
  type = map(string)
  default = {}
}