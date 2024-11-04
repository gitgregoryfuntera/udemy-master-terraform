variable "numbers_list" {
  type    = list(number)
  default = [1, 2, 3, 4]
}

variable "object_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
  default = [{
    firstname = "john"
    lastname  = "doe"
    },
    {
      firstname = "jane"
      lastname  = "doe"
    }

  ]
}


