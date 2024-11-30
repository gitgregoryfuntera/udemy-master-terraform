variable "project_name" {
  type = string
}

variable "rds_name" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type = number
}

variable "rds_engine" {
  type = string
}

variable "rds_credential" {
  type = object({
    username = string
    password = string
  })
}

variable "rds_subnet_ids" {
  type = list(string)
}

variable "rds_sg_ids" {
  type = list(string)
}
