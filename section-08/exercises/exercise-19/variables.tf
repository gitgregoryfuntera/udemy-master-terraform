variable "my_sensitive_value" {
  type    = string
  default = "secret"
}

variable "additional_tags" {
  type = map(string)
  default = {
    "AdditionalTags" = "variables.tf"
  }
}
