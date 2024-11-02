variable "ec2_instance_type" {
  type = string

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "only t2.micro and t3.micro ara available"
  }

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
  type    = map(string)
  default = {}
}
