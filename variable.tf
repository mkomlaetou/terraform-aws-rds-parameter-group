variable "pg_info" {
  description = "paramager group name and family"
  type = object({
    name        = string
    family      = string
    description = optional(string, "")
  })
  # default = {}
}


variable "instance_pg_parameters" {
  description = "parameters of db parameter group"
  type = map(object({
    name         = optional(string, "")
    value        = optional(string, "")
    apply_method = optional(string, "pending-reboot")
  }))
  default = {}
}


variable "cluster_pg_parameters" {
  description = "parameters of cluster parameter group"
  type = map(object({
    name         = optional(string, "")
    value        = optional(string, "")
    apply_method = optional(string, "pending-reboot")
  }))
  default = {}
}


variable "create_instance_pg" {
  description = "required when creating db parameter group"
  type        = bool
  default     = true
}

variable "create_cluster_pg" {
  description = "requred when creating cluster parameter group"
  type        = bool
  default     = true
}
