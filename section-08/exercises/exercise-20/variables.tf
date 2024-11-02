variable "my_sensitive_value" {
  type      = string
  sensitive = true
  default   = "secret"
}

variable "additional_tags" {
  type = map(string)
  default = {
    "AdditionalTags" = "variables.tf"
  }
}

output "sensitive_var" {
  sensitive = true # We must set this to true since the variable is sensitive!
  value     = var.my_sensitive_value
}
