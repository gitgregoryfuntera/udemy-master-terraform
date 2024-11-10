
variable "ec2_instance_count" {
  type = number
}

variable "project_name" {
  type = string
}

variable "project" {
  type = string
}

variable "subnet_count" {
  type = number
}


variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  validation {
    condition = alltrue([
      for value in var.ec2_instance_config_list : contains(["t2.micro", "t3.micro"], value.instance_type)
    ])
    error_message = "only t2.micro and t3.micro are available"
  }

  validation {
    condition = alltrue([
      for value in var.ec2_instance_config_list : contains(["ubuntu", "bitnami"], value.ami)
    ])
    error_message = "only ubuntu and bitnami are available"
  }
  default = []
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_index  = optional(number, 0)
    subnet_key    = optional(string, "subnet_1")
  }))

  default = {}

  validation {
    condition     = alltrue([for value in values(var.ec2_instance_config_map) : contains(["t2.micro", "t3.micro"], value.instance_type)])
    error_message = "only t2.micro and t3.micro are available"
  }

  validation {
    condition = alltrue([
      for value in values(var.ec2_instance_config_map) : contains(["ubuntu", "bitnami"], value.ami)
    ])

    error_message = "only ubuntu and bitnami are available"
  }

  validation {
    condition = alltrue([
      for value in values(var.ec2_instance_config_map) : contains(["subnet_1", "subnet_2"], value.subnet_key)
    ])
    error_message = "only subnet_1 and subnet_2 are available"
  }
}

variable "subnet_config_map" {
  type = map(object({
    cidr_block = string
  }))


  default = {

  }

  validation {
    condition = alltrue([
      for value in values(var.subnet_config_map) : can(cidrnetmask(value.cidr_block))
    ])
    error_message = "not valid cidr"
  }
}
