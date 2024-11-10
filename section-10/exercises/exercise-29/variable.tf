
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

  default = []
}
