variable "role_name" {
  type    = list(string)
  default = []
}

variable "target_resource_id" {
  type    = list(string)
  default = []
}

variable "resource_list" {
  type    = list(any)
  default = []
}

locals {
  roles = flatten([
    for res_idx, res in var.resource_list : [
      for role_idx, name in var.role_name : {
        resource_id = var.resource_list[res_idx]
        role        = var.role_name[role_idx]
        target_id   = var.target_resource_id[role_idx]
      }
    ]
  ])
}