variable "instance_type" {
  type = string
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "only t2.micro and t3.micro ara available"
  }
}

variable "volume_size" {
  type = number
  default = 10
}