variable "users" {
  type = list(object({
    username = string
    role     = string
  }))

  default = [{
    username = "hello"
    role     = "admin"
    },
    {
      username = "hello"
      role     = "admin"
    }
  ]
}

variable "users_to_output" {
  type = string
}
