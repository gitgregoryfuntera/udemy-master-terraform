data "aws_availability_zones" "azs_available" {
  state = "available"
}

locals {
  vpc = {
    cidr            = "10.0.0.0/16"
    azs             = data.aws_availability_zones.azs_available.names
    private_subnets = ["10.0.0.0/24"]
    public_subnets  = ["10.0.128.0/24"]
  }
  common_tags = {
    ManagedBy = "terraform"
  }
}
