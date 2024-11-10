
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
