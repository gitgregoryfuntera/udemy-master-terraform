
# TF_VAR instance type = t3.micro
# ec2_instance_type instance type = t3.small
# prod.auto.tfvars instance type = t3.large
# -var cli argument instance type = t3.xlarge
# -var cli and var-file cli arguments, latest with the highest precedence = t3.xlarge

ec2_instance_type = "t2.micro"

ec2_volume_config = {
  size = 10
  type = "gp2"
}

additional_tags = {
  ValuesFrom = "terraform.tfvars"
}