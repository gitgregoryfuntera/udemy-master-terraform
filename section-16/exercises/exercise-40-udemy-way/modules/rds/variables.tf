variable "project_name" {
  type = string
}

variable "instance_class" {
  type = string
  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only free tier allowed"
  }
  default = "db.t3.micro"
}

variable "storage_size" {
  type = number
  validation {
    condition     = var.storage_size > 5 && var.storage_size <= 10
    error_message = "size should be minimum of 5 and not more than 10"
  }
  default = 10
}

variable "engine" {
  type = string

  validation {
    condition     = contains(["postgres-latest", "postgres-14"], var.engine)
    error_message = "only postgres are allowed as of the moment"
  }

  default = "postgres-latest"
}

variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true

  validation {
    condition = (length(regexall("[a-zA-Z]+", var.credentials.password)) > 0
      && length(regexall("[0-9]+", var.credentials.password)) > 0
      && length(regexall("^[a-zA-Z0-9+_?-]{6,}$", var.credentials.password)) > 0
    )
    error_message = "Password must contain 1 character and 1 digit, and be at least 6 characters"
  }
}

variable "subnet_ids" {
  type = list(string)
}


variable "sg_group_ids" {
  type = list(string)
}
