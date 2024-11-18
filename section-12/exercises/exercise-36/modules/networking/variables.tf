variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Must be a valid IPv4 CIDR"
  }
}


variable "subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "Must be a valid IPv4 CIDR"
  }
}
