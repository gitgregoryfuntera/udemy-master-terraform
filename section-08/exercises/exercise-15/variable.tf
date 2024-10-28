variable "ec2_volum_config" {
  description = "The size and type of the root block volume for EC2 instances."

  type = object({
    volume_size = number
    volume_type = string
  })

  default = {
    volume_size = 10
    volume_type = "gp3"
  }
}

variable "tags" {
  type = map(string)

  default = {}
}