variable "ec2_instance_type" {
  type = string
}

variable "ec2_volume_config" {
  description = "The size and type of the root block volume for EC2 instances."

  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type = map(string)

  default = {}
}